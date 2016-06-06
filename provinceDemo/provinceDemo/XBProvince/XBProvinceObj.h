//
//  XBProvinceObj.h
//  provinceDemo
//
//  Created by 周旭斌 on 16/4/27.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBCityObj.h"
#import "MJExtension.h"

@interface XBProvinceObj : NSObject
/**
 *  省的名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  市模型数组(XBCityObj)
 */
@property (nonatomic, strong) NSArray *sub;
/**
 *  是否展开
 */
@property (nonatomic, assign, getter=isSpread) BOOL spread;
/**
 *  用来装所有的市(后来自己加的)
 */
@property (nonatomic, strong) NSMutableArray *cities;

@end
