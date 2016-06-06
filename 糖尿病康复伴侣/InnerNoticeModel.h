//
//  InnerNoticeModel.h
//  HalsmaForIos
//
//  Created by liuyang on 15/12/21.
//  Copyright © 2015年 hbis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InnerNoticeModel : NSObject

/** 公告ID */
@property(nonatomic,copy)NSString *mid;
/** 标题 */
@property(nonatomic,copy)NSString *title;
/** 正文 */
@property(nonatomic,copy)NSString *content;
/** 发送时间 */
@property(nonatomic,copy)NSString *sendTime;

+(id)innerNoticeModelWithDict:(NSDictionary *)dict;
-(id)initWithDict:(NSDictionary *)dict;

@end
