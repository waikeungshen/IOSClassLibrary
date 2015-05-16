//
//  UIView+Gradient.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/5/16.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "UIView+Gradient.h"

@implementation UIView (Gradient)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)addGradientbackgroundColor:(UIColor *)startColor toColor:(UIColor *)endColor; {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.frame;
    gradient.colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
