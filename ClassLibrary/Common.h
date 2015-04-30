//
//  Common.h
//  skylineLib
//
//  Created by waikeungshen on 15/4/17.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#ifndef skylineLib_Common_h
#define skylineLib_Common_h

//判断字符串是否为空
#define IS_EMPTY(str) (str == nil || [str length] == 0)

//程序中默认字体
#define DEFAULT_FONT @"Helvetica"

//获取RGB实现
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

//判断是否版本超过7.0
#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue]>=7.0)

//判断是否版本超过8.0
#define IOS8 ([[UIDevice currentDevice].systemVersion doubleValue]>=8.0)

//适配的导航栏高度
#define TITLE_BAR_HEIGHT (IOS7?64:(TRANS_FOR_TITLE?64:44))

//导航栏状态栏高度
#define TITLE_HEIGHT_WITH_BAR (STATUS_BAR_HEIGHT+44)
//包括状态栏的屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//不包括状态栏的屏幕尺寸
#define FRAME_WIDTH ([UIScreen mainScreen].applicationFrame.size.width)
#define FRAME_HEIGHT ([UIScreen mainScreen].applicationFrame.size.height)

//状态栏尺寸,不包含热点时的多出尺寸
#define STATUS_BAR_WIDTH ([[UIApplication sharedApplication] statusBarFrame].size.width)
#define STATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)

//适配的导航栏高度
#define TITLE_BAR_HEIGHT (IOS7?64:(TRANS_FOR_TITLE?64:44))

//判断字符串是否为空
#define IS_EMPTY(str) (str == nil || [str length] == 0)

/*******************************************************************/

// 服务器接口根地址
#define API_HOST @"http://115.29.203.21:10003/index.php/Mobile/"

#endif
