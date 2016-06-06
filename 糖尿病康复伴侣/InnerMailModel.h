//
//  InnerMailModel.h
//  HalsmaForIos
//
//  Created by User on 14/12/23.
//  Copyright (c) 2014年 hbis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InnerMailModel : NSObject

/** 信件ID */
@property(nonatomic,copy)NSString *mid;
/** 已读标记 */
@property(nonatomic,copy)NSString * opened;
/** 标题 */
@property(nonatomic,copy)NSString *title;
/** 正文 */
@property(nonatomic,copy)NSString *content;
/** 发送时间 */
@property(nonatomic,copy)NSString *sendTime;
/** 发送者ID */
@property(nonatomic,copy)NSString *senderId;
/** 发送者姓名 */
@property(nonatomic,copy)NSString *senderName;
/**   附件      */
@property(nonatomic,copy)NSString * Adjunct;
@end
