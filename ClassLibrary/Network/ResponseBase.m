//
//  ResponseBase.m
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/29.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import "ResponseBase.h"
#import "Common.h"

@implementation ResponseBase

// 将返回的json数据解析
- (id)initWithJsonData:(NSData *)jsonData {
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    if (dic != nil && [dic count] >  0){
        NSString *dataStr = (NSString *)self.data;
        if (IS_EMPTY(dataStr)) { // self.data为空时
            NSString *data = [dic objectForKey:@"data"];
            if (IS_EMPTY(data)) {
                self.data = [[NSDictionary alloc] init];
            } else {
                self.data = (NSDictionary *)data;
            }
        } else { // self.data不为空时
            self.data = [NSJSONSerialization JSONObjectWithData:[dataStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
            if (!self.data) {
                self.data = (NSDictionary *)dataStr;
            }
        }

    }
    return self;
}

@end
