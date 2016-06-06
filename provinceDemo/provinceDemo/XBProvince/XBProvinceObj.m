//
//  XBProvinceObj.m
//  provinceDemo
//
//  Created by 周旭斌 on 16/4/27.
//  Copyright © 2016年 周旭斌. All rights reserved.
//

#import "XBProvinceObj.h"

@implementation XBProvinceObj

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"sub" : [XBCityObj class]};
}

- (NSMutableArray *)cities {
    if (!_cities) {
        _cities = [NSMutableArray array];
    }
    return _cities;
}

@end
