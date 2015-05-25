//
//  ViewController.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/29.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "ViewController.h"
#import "BannerRollView.h"
#import "Common.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *pictures = [NSMutableArray array];
    for (int i = 1; i <= 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"pic%d", i];
        UIImage *image = [UIImage imageNamed:imageName];
        [pictures addObject:image];
    }
    
    BannerRollView *bannerRollView = [[BannerRollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) withPictures:[pictures copy]];
    bannerRollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bannerRollView];
}

@end
