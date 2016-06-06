//
//  MessageCell.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
@class MessageFrame;

@interface MessageCell : UITableViewCell<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) MessageFrame *messageFrame;

@end
