//
//  NSObject+Reflect.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "NSObject+Reflect.h"
#import <objc/runtime.h>

@implementation NSObject (Reflect)

- (NSArray *)propertyKeys {
    unsigned int outcount, i;
    objc_property_t *properties =  class_copyPropertyList([self class], &outcount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outcount];
    for (i = 0; i < outcount; i++) {
        objc_property_t property = properties[i];
        NSString *propertName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertName];
    }
    free(properties);
    return keys;
}

- (BOOL)reflectDataFromOtherObject:(NSObject *)dataSource {
    BOOL ret = NO;
    for (NSString *key in [self propertyKeys]) {
        if ([dataSource isKindOfClass:[NSDictionary class]]) {
            ret = ([dataSource valueForKey:key] == nil) ? NO : YES;
        } else {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            // 该值不为NSNULL，并且不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue != nil) {
                [self setValue:propertyValue forKey:key];
            }
        }
    }
    return ret;
}
@end
