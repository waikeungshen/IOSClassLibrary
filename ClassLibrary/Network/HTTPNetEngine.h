//
//  HTTPNetEngine.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/29.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandBase.h"
#import "ResponseBase.h"
#import "ASIHTTPRequest.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASIFormDataRequest.h"

typedef void (^SuccessBlock)(ResponseBase* response);
typedef void (^FailedBlock)(ResponseBase* response, NSString* error);

@interface HTTPNetEngine : NSObject

+ (HTTPNetEngine *)getInstance;

/**
 *  采用异步方式向服务器请求数据，发送的自定义数据类型为json
 *
 *  @param command 请求命令
 *  @param time    超时时间
 *  @param success 请求成功的回调
 *  @param failed  请求失败的回调
 *
 *  @return 请求的ASIHTTPRequset实例
 */
- (ASIHTTPRequest *)request:(CommandBase *)command TimeOut:(NSInteger)time success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 *  采用异步方式向服务器请求数据，模拟Form表单提交
 *
 *  @param url        请求的URL
 *  @param parameters POST的字典
 *  @param time       超时时间
 *  @param success    请求成功的回调
 *  @param failed     请求失败的回调
 *
 *  @return 请求的ASIFormDataRequest实例
 */
- (ASIFormDataRequest *)request:(NSString *)url parameters:(NSDictionary *)parameters TimeOut:(NSInteger)time success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
