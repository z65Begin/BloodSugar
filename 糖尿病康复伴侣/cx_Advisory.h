//
//  cx_Advisory_reply.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cx_Advisory : NSObject
//读取
@property (nonatomic, copy) NSString * isNew;
//文件名
@property (nonatomic, copy) NSString * title;
//正文
@property (nonatomic, copy) NSString * text;
//附件
@property (nonatomic, copy) NSString * adjunct;
//更新时间
@property (nonatomic, copy) NSString * updtime;
//最后回复时间
@property (nonatomic, copy) NSString * rpltime;
//id
@property (nonatomic, copy) NSString * idAddress;
//医生编号
@property (nonatomic, copy) NSString * docID;
//医生姓名
@property (nonatomic, copy) NSString * docName;

//@property (nonatomic, copy) NSString *;
@end
