//
//  MessageFrame.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//



#import "MessageFrame.h"
#import "Message.h"

@implementation MessageFrame

- (void)setMessage:(Message *)message{
    
    _message = message;
    
    // 0、获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 1、计算时间的位置
    if (_showTime){
        
        CGFloat timeY = kMargin;
        CGSize timeSize = [_message.updtime sizeWithFont:kTimeFont];

        _timeF = CGRectMake(kMargin, timeY, timeSize.width + kTimeMarginW, timeSize.height + kTimeMarginH);
    }
    // 2、计算头像位置
    CGFloat iconX = kMargin;
    // 2.1 如果是自己发得，头像在右边
    if (_message.type == MessageTypeMe) {
        iconX = screenW - kMargin;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    
    // 3、计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    CGSize contentSize = [_message.text sizeWithFont:kContentFont constrainedToSize:CGSizeMake(kContentW, CGFLOAT_MAX)];
    
    if (_message.type == MessageTypeMe) {
        contentX = iconX - kMargin - contentSize.width - kContentLeft - kContentRight;
    }
    _contentF = CGRectMake(contentX, contentY, contentSize.width + kContentLeft + kContentRight, contentSize.height + kContentTop + kContentBottom);
    CGFloat orginX = 0;
    if (_message.type == MessageTypeMe) {
        orginX = CGRectGetMinX(_contentF)-kMargin- 40;
    }else{
        orginX = CGRectGetMaxX(_contentF)+kMargin;
    }
    _speakF = CGRectMake(orginX, contentY+(CGRectGetHeight(_contentF)-40)*0.5, 40, 40);
    // 4、计算高度
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_iconF))  + kMargin;
}

@end
