//
//  ResponseBase.h
//  ClassLibrary
//
//  Created by waikeungshen on 15/4/29.
//  Copyright (c) 2015年 waikeungshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResponseBase : NSObject

@property (assign, nonatomic) NSInteger code;
@property (copy, nonatomic) NSString *message;
@property (strong, nonatomic) id data;

- (id)initWithJsonData:(NSData *)jsonData;
@end
