//
//  XBProvinceTableView.h
//  provinceDemo
//
//  Created by xingxiao on 16/4/29.
//  Copyright © 2016年 xingxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XBProvinceTableView;
@protocol XBProvinceTableViewDelegate <NSObject>

@optional
- (void)provinceTableView:(XBProvinceTableView *)tableView didSelectedAreaCell:(NSIndexPath *)indexPath areaName:(NSString *)areaName;

@end

@interface XBProvinceTableView : UITableView

@property (nonatomic, weak) id <XBProvinceTableViewDelegate> myDelegate;

@end
