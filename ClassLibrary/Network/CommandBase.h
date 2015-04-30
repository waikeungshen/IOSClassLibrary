//
//  CommandBase.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/29.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandBase : NSObject

@property(copy, nonatomic) NSString *requestURL;
@property(nonatomic, strong) NSMutableDictionary* addition; // 直接包含在第一层json结构中

/**
 *  请求基础类
 *
 *  @param url 请求的url
 *
 *  @return 返回一个请求的实例
 */
- (CommandBase *)initWithURL:(NSString *)url;

- (NSData *)toJsonData;

@end

#pragma mark - 登录
#define CMD_Login_URL @"/api/login"
@interface CMD_Login : CommandBase
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *password;

@end