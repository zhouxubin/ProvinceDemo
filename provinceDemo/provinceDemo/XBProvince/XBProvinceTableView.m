//
//  XBProvinceTableView.m
//  provinceDemo
//
//  Created by xingxiao on 16/4/29.
//  Copyright © 2016年 xingxiao. All rights reserved.
//

#import "XBProvinceTableView.h"
#import "XBProvinceObj.h"
#import "XBHeaderView.h"

@interface XBProvinceTableView () <UITableViewDelegate, UITableViewDataSource>
/**
 *  数据源(省)
 */
@property (nonatomic, strong) NSArray *provinceArray;
/**
 *  记录点击的组
 */
@property (nonatomic, assign) NSUInteger index;
@end

@implementation XBProvinceTableView

- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

#pragma mark - tableView dataSource
#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.provinceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XBProvinceObj *provinceObj = _provinceArray[section];
    if (provinceObj.isSpread) { // 省展开的时候
        return provinceObj.cities.count;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    XBProvinceObj *provinceObj = _provinceArray[indexPath.section];
    NSObject *obj = provinceObj.cities[indexPath.row];
    if ([obj isKindOfClass:[XBCityObj class]]) {
#warning 这里是市的设置
        XBCityObj *cityObj = (XBCityObj *)obj;
        cell.textLabel.text = cityObj.name;
        cell.detailTextLabel.text = nil;
    }else {
#warning 这里是区的设置
        cell.textLabel.text = nil;
        cell.detailTextLabel.text = (NSString *)obj;
    }
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XBProvinceObj *provinceObj = _provinceArray[indexPath.section];
    NSObject *obj = provinceObj.cities[indexPath.row];
    // 因为在XBProvinceObj的cities数组里有两种类,字符串(区),市(XBCityObj),所以在这里需要判断一下点击的是市还是区
    if (![obj isKindOfClass:[XBCityObj class]]) {
        if ([self.myDelegate respondsToSelector:@selector(provinceTableView:didSelectedAreaCell:areaName:)]) {
            [self.myDelegate provinceTableView:self didSelectedAreaCell:indexPath areaName:(NSString *)obj];
        }
        return;
    }
    // 走到这里说明点击的是市
    XBCityObj *cityObj = (XBCityObj *)obj;
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:cityObj.sub.count];
    for (int i = 0; i < cityObj.sub.count; ++i) {
        // 计算需要插入所有区的cell的位置
        NSIndexPath *indexP = [NSIndexPath indexPathForRow:indexPath.row + 1 + i inSection:indexPath.section];
        [tempArray addObject:indexP];
    }
    
    if (cityObj.isSpread) { // cell已经展开,应该删除区
        for (XBCityObj *obj in cityObj.sub) {
            [provinceObj.cities removeObject:obj];
        }
        // 因为位置是固定的,所以只要直接删除tempArray就可以了
        [tableView deleteRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
        cityObj.spread = NO;
    }else { // cell没展开,应该添加区
        for (int i = 0; i < cityObj.sub.count; ++i) {
            // 因为区都是字符串,所以直接取出来加进数组里就可以了
#warning 至于为什么要indexPath.row + 1 + i,你可以把1去掉之后看看区别就知道了
            NSString *name = cityObj.sub[i];
            [provinceObj.cities insertObject:name atIndex:indexPath.row + 1 + i];
        }
        [tableView insertRowsAtIndexPaths:tempArray withRowAnimation:UITableViewRowAnimationFade];
        // 记录哪个市已经展开
        cityObj.spread = YES;
    }
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    XBProvinceObj *provinceObj = _provinceArray[section];
    XBHeaderView *headerView = [XBHeaderView headerViewWith:tableView];
    // 绑定tag
    headerView.tag = section;
    headerView.provinceObj = provinceObj;
    __weak typeof(self) Self = self;
    headerView.clickBlock = ^(NSUInteger index) {
        if (provinceObj.isSpread) { // 需要展开省
            [provinceObj.cities addObjectsFromArray:provinceObj.sub];
        }else { // 关闭省,这个时候需要把所有的市的spread这个值设置为NO,如果不为NO那么下次展开省的时候就会有异常
            for (XBCityObj *obj in provinceObj.cities) {
                if ([obj isKindOfClass:[XBCityObj class]]) {
                    obj.spread = NO;
                }
            }
            // 移除所有数据
            [provinceObj.cities removeAllObjects];
        }
        [Self reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (NSArray *)provinceArray {
    if (!_provinceArray) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"address.plist" ofType:nil];
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
        _provinceArray = [XBProvinceObj mj_objectArrayWithKeyValuesArray:dictionary[@"address"]];
    }
    return _provinceArray;
}

@end
