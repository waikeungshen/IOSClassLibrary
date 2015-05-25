//
//  UIButton+Add.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/5/24.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "UIButton+Add.h"

@implementation UIButton (Add)


- (void)setCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    [self setCornerRadius:radius];
    [self setBorderColor:color width:width];
}

@end
