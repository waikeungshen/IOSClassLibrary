//
//  Util.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "Util.h"
#import "NSObject+Reflect.h"
#import <objc/runtime.h>

@implementation Util

+ (NSDictionary *)getDictionaryFromObject:(id)object :(BOOL (^)(NSString *))property {
    NSArray *propertyKeys = [object propertyKeys]; // 属性名数组
    NSMutableArray *propertyArray = [NSMutableArray array];
    NSMutableArray *valueArray = [NSMutableArray array];
    
    for (NSString *key in propertyKeys) {
        if (!property(key)) {
            continue;
        }
        id value = [object objectForKey:key];
        [propertyArray addObject:key];
        if (value == nil) {
            [valueArray addObject:[NSNull null]];
        } else {
            [valueArray addObject:value];
        }
    }
    
    NSDictionary *returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    
    return returnDic;
}

@end
