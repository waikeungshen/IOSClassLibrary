//
//  Util.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

/**
 *  将object中的属性与属性值转换为字典
 *
 *  @param object   对象
 *  @param property block, 返回YES表示该属性值加入字典中
 *
 *  @return 包含属性与属性值的字典
 */
+ (NSDictionary *)getDictionaryFromObject:(id) object :(BOOL (^)(NSString *))property;

@end
