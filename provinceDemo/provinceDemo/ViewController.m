//
//  ViewController.m
//  provinceDemo
//
//  Created by xingxiao on 16/4/29.
//  Copyright © 2016年 xingxiao. All rights reserved.
//

#import "ViewController.h"
#import "XBProvinceTableView.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController () <XBProvinceTableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XBProvinceTableView *tableView = [[XBProvinceTableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.myDelegate = self;
    [self.view addSubview:tableView];
}

#pragma mark - XBProvinceTableViewDelegate
- (void)provinceTableView:(XBProvinceTableView *)tableView didSelectedAreaCell:(NSIndexPath *)indexPath areaName:(NSString *)areaName {
    NSLog(@"%@", areaName);
    [MBProgressHUD showSuccess:areaName];
}

@end
