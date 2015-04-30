//
//  CommandBase.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/29.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "CommandBase.h"
#import "Util.h"

@implementation CommandBase

- (CommandBase *)initWithURL:(NSString *)url {
    _requestURL = url;
    return self;
}

- (NSData *)toJsonData {
    NSError* error = nil;
    NSDictionary *dic = [self toDictionary];
    [self.addition setValuesForKeysWithDictionary:dic];
    
    NSData *returnData = [NSJSONSerialization dataWithJSONObject:self.addition options:kNilOptions error:&error];
    if (error != nil) {
        return nil;
    }
    return returnData;
}

-(NSDictionary *)toDictionary {
    NSDictionary *dic = [Util getDictionaryFromObject:self :^BOOL(NSString *property) {
        if ([property isEqualToString:@"requestURL"] ||
            [property isEqualToString:@"addition"]) {
            return NO;
        }
        return YES;
    }];
    return dic;
}

@end

#pragma mark - 登录
@implementation CMD_Login

- (CMD_Login *)init {
    if (self = [super init]) {
        self.requestURL = CMD_Login_URL;
        self.addition = [NSMutableDictionary dictionary];
    }
    return self;
}

@end