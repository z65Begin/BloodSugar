//
//  Message.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    MessageTypeMe = 0, // 自己发的
    MessageTypeOther = 1 //别人发得
    
} MessageType;

@interface Message : NSObject

@property (nonatomic, copy) NSString *rid;
@property (nonatomic, copy) NSString *usrid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, assign) MessageType type;
@property (nonatomic, copy) NSString * text;
@property (nonatomic, copy) NSString * adjunct;
@property (nonatomic, copy) NSString * updtime;



//@property (nonatomic, copy) NSDictionary *dict;

@end
