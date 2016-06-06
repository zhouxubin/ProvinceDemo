//
//  XBHeaderView.h
//  provinceDemo
//
//  Created by 周旭斌 on 16/4/27.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TitleClickBlock)(NSUInteger index);

@class XBProvinceObj;
@interface XBHeaderView : UITableViewHeaderFooterView

/**
 *  数据模型
 */
@property (nonatomic, strong) XBProvinceObj *provinceObj;
/**
 *  标题点击
 */
@property (nonatomic, copy) TitleClickBlock clickBlock;
/**
 *  快速创建对象
 */
+ (instancetype)headerViewWith:(UITableView *)tableView;

@end
