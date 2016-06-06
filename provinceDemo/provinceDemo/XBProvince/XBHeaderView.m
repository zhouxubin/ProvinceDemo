//
//  XBHeaderView.m
//  provinceDemo
//
//  Created by 周旭斌 on 16/4/27.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import "XBHeaderView.h"
#import "XBProvinceObj.h"

@interface XBHeaderView ()

@property (nonatomic, weak) UIButton *titleButton;

@end

@implementation XBHeaderView

#pragma mark - 重写setter方法给属性赋值
- (void)setProvinceObj:(XBProvinceObj *)provinceObj {
    _provinceObj = provinceObj;
    [self.titleButton setTitle:provinceObj.name forState:UIControlStateNormal];
}

#pragma mark - 快速创建对象
+ (instancetype)headerViewWith:(UITableView *)tableView {
    static NSString *ID = @"headerView";
    XBHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView = [[XBHeaderView alloc] initWithReuseIdentifier:ID];
    }
    return headerView;
}

#pragma mark - 设置子控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleButton.frame = self.bounds;
}

#pragma mark - 标题的点击事件
- (void)buttonClick {
    if (self.clickBlock) {
        self.provinceObj.spread = !self.provinceObj.spread;
        self.clickBlock(self.tag);
    }
}

#pragma mark - 懒加载
- (UIButton *)titleButton {
    if (!_titleButton) {
        UIButton *button = [[UIButton alloc] init];
        button.titleLabel.textAlignment = NSTextAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:button];
        [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        _titleButton = button;
    }
    return _titleButton;
}

@end
