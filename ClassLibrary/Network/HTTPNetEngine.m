//
//  HTTPNetEngine.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/29.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "HTTPNetEngine.h"
#import "Common.h"
#import "ResponseBase.h"

static HTTPNetEngine *instance = nil;

@implementation HTTPNetEngine

+ (HTTPNetEngine *)getInstance {
    if (instance == nil) {
        instance = [[self alloc] init];
    }
    return instance;
}

- (ASIHTTPRequest *)request:(CommandBase *)command TimeOut:(NSInteger)time success:(SuccessBlock)success failed:(FailedBlock)failed{
    // 拼接URL
    NSURL *fullurl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", API_HOST, command.requestURL]];
    NSMutableData *body = [[NSMutableData alloc] initWithData:[command toJsonData]];
    NSLog(@"Send %@ : %@", fullurl, [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding]);
    
    // 创建请求
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:fullurl];
    // 设置请求内容
    if (time != 0) {
        [request setTimeOutSeconds:time];
    } else {
        [request setTimeOutSeconds:60];
    }
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",@"utf-8"]];
    [request setPostBody:body];
    
    __weak ASIHTTPRequest *weakRequest = request;
    
    // 请求成功
    [request setCompletionBlock:^{
        if (weakRequest.responseStatusCode == 200) {
            ResponseBase *response = [[ResponseBase alloc] init];
            response = [response initWithJsonData:[weakRequest responseData]];
            if (response.code == 0) {
                if (success) {
                    success(response);
                }
            } else {
                if (failed) {
                    failed(response, response.message);
                }
            }
        } else {
            NSLog(@"response(%@) : %d", command.requestURL, weakRequest.responseStatusCode);
            if (failed) {
                NSString *error = nil;
                ResponseBase *response = [[ResponseBase alloc] init];
                response = [response initWithJsonData:[weakRequest responseData]];
                if (response != nil && !IS_EMPTY(response.message)) {
                    error = response.message;
                }
                if(IS_EMPTY(error)) {
                    error = weakRequest.error.localizedFailureReason;
                }
                if(IS_EMPTY(error)) {
                    error = @"网络异常";
                }
                failed(response, error);
            }
        }
        [weakRequest setFailedBlock:nil];
        [weakRequest setCompletionBlock:nil];
    }];
    
    // 请求失败
    [request setFailedBlock:^{
        if (failed) {
            NSString *error = weakRequest.error.localizedFailureReason;
            if (IS_EMPTY(error)) {
                error = @"网络异常";
            }
            failed(nil, error);
        }
        [weakRequest setFailedBlock:nil];
        [weakRequest setCompletionBlock:nil];
    }];
    
    [request startAsynchronous]; // 异步请求
    
    return request;
}

- (ASIFormDataRequest *)request:(NSString *)url parameters:(NSDictionary *)parameters TimeOut:(NSInteger)time success:(SuccessBlock)success failed:(FailedBlock)failed {
    // 拼接URL
    NSString *fullurlString = [NSString stringWithFormat:@"%@%@", API_HOST, url];
    NSURL *fullurl = [NSURL URLWithString:fullurlString];
    
    // 创建请求
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:fullurl];
    // 设置请求内容
    if (time != 0) {
        [request setTimeOutSeconds:time];
    } else {
        [request setTimeOutSeconds:60];
    }
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",@"utf-8"]];
    NSString *dumpURL = [fullurlString stringByAppendingString:@"?"];
    for (NSString *key in parameters.allKeys) {
        id value = [parameters objectForKey:key];
        [request setPostValue:value forKey:key];    // 添加POST的数据
        dumpURL = [dumpURL stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, value]];
    }
    dumpURL = [dumpURL stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"&"]];
    NSLog(@"POST : %@", dumpURL);
    
    __weak ASIFormDataRequest *weakRequest = request;
    
    // 请求成功
    [request setCompletionBlock:^{
        if (weakRequest.responseStatusCode == 200) {
            ResponseBase *response = [[ResponseBase alloc] init];
            response = [response initWithJsonData:[weakRequest responseData]];
            if (response.code == 0) {
                if (success) {
                    success(response);
                }
            } else {
                if (failed) {
                    failed(response, response.message);
                }
            }
        } else {
            NSLog(@"response(%@) : %d", url, weakRequest.responseStatusCode);
            if (failed) {
                NSString *error = nil;
                ResponseBase *response = [[ResponseBase alloc] init];
                response = [response initWithJsonData:[weakRequest responseData]];
                if (response != nil && !IS_EMPTY(response.message)) {
                    error = response.message;
                }
                if(IS_EMPTY(error)) {
                    error = weakRequest.error.localizedFailureReason;
                }
                if(IS_EMPTY(error)) {
                    error = @"网络异常";
                }
                failed(response, error);
            }
        }
        [weakRequest setFailedBlock:nil];
        [weakRequest setCompletionBlock:nil];
    }];
    
    // 请求失败
    [request setFailedBlock:^{
        if (failed) {
            NSString *error = weakRequest.error.localizedFailureReason;
            if (IS_EMPTY(error)) {
                error = @"网络异常";
            }
            failed(nil, error);
        }
        [weakRequest setFailedBlock:nil];
        [weakRequest setCompletionBlock:nil];
    }];
    
    [request startAsynchronous]; // 异步请求
    
    return request;
}

@end
