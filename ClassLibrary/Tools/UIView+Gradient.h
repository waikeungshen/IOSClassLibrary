//
//  UIView+Gradient.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/5/16.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Gradient)

/**
 *  给View添加渐变的背景色
 *
 *  @param startColor 开始颜色
 *  @param endColor   结束颜色
 */
- (void)addGradientbackgroundColor:(UIColor *)startColor toColor:(UIColor *)endColor;

@end
