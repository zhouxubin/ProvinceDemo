//
//  XBCityObj.h
//  provinceDemo
//
//  Created by 周旭斌 on 16/4/27.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBCityObj : NSObject
/**
 *  市的名字
 */
@property (nonatomic, copy) NSString *name;
/**
 *  区数组
 */
@property (nonatomic, strong) NSArray *sub;
/**
 *  邮编
 */
@property (nonatomic, copy) NSString *zipcode;
/**
 *  是否是展开(后来自己加的)
 */
@property (nonatomic, assign, getter=isSpread) BOOL spread;

@end
