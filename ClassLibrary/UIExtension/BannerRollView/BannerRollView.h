//
//  BannerRollView.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/30.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerRollView : UIView <UIScrollViewDelegate>

//@property (strong, nonatomic) BOOL isHorizontal; //方向，是否为横向
@property (assign, nonatomic) BOOL hasPageControl;
@property (strong, nonatomic) NSArray *pictures;

- (BannerRollView *) initWithFrame:(CGRect)frame withPictures:(NSArray *)pictures;
@end
