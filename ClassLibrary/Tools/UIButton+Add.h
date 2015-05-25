//
//  UIButton+Add.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/5/24.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Add)
/**
 *  设置按钮的圆角
 *
 *  @param radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 *  设置按钮边框
 *
 *  @param color 边框颜色
 *  @param width 边框宽度
 */
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;

/**
 *  设置按钮的圆角和边框
 *
 *  @param radius 圆角半径
 *  @param color  边框颜色
 *  @param width  边框宽度
 */
- (void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width;

@end
