//
//  NSObject+Reflect.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSObject (Reflect)

/**
 *  获取对象的所有属性
 *
 *  @return 对象的所有属性
 */
- (NSArray *)propertyKeys;

/**
 *  根据dataSource设置属性, 利用反射机制赋值
 *
 *  @param dataSource 数据源
 *
 *  @return 设置成功返回YES，否则返回NO
 */
- (BOOL)reflectDataFromOtherObject:(NSObject *)dataSource;

@end
