//
//  MessageCell.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "MessageCell.h"
#import "Message.h"
#import "MessageFrame.h"

@interface MessageCell ()
{
    UIButton     *_timeBtn;
    UIImageView *_iconView;
    UIButton    *_contentBtn;
    UIButton * _speakButton;
//    UILabel * nameLabel;
}
@property(nonatomic,strong) AVSpeechSynthesizer* player;

@property (nonatomic, copy) NSString * content;
@end

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//#warning 必须先设置为clearColor，否则tableView的背景会被遮住
        self.backgroundColor = [UIColor clearColor];
        // 1、创建时间按钮
        _timeBtn = [[UIButton alloc] init];
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
//        _timeBtn.backgroundColor = [UIColor yellowColor];
//        [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        // 2、创建头像
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
        
        // 3、创建内容
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _contentBtn.titleLabel.font = kContentFont;
        _contentBtn.titleLabel.numberOfLines = 0;
        _contentBtn.layer.cornerRadius = 3.0f;
        _contentBtn.layer.borderWidth = 0.5f;
        _contentBtn.layer.borderColor = [UIColor grayColor].CGColor;
        
        [self.contentView addSubview:_contentBtn];
        //        4. 创建语音按钮
        _speakButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _speakButton.selected = NO;
        [_speakButton setImage:[UIImage imageNamed:@"img_voice_q"] forState:UIControlStateNormal];
        [_speakButton setImage:[UIImage imageNamed:@"img_voice"] forState:UIControlStateSelected];
        [_speakButton addTarget:self action:@selector(playerBtnClick) forControlEvents:UIControlEventTouchUpInside];        [self.contentView addSubview:_speakButton];
        _player=[[AVSpeechSynthesizer alloc]init];
        _player.delegate = self;
        _speakButton.backgroundColor = blueColorWithRGB(61, 172, 225);
        [self.contentView addSubview:_speakButton];
        
        
    }
    return self;
}

- (void)setMessageFrame:(MessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    Message *message = _messageFrame.message;
    
    // 1、设置时间
    [_timeBtn setTitle:message.username forState:UIControlStateNormal];
    
    _timeBtn.frame = _messageFrame.timeF;

    // 2、设置头像
//    _iconView.image = [UIImage imageNamed:message.icon];
//    _iconView.frame = _messageFrame.iconF;
    if (message.type == MessageTypeMe) {
        _iconView.image = nil;
    }else{
        _iconView.image = [UIImage imageNamed:@"img_mdc_head"];
    }
    
    // 3、设置内容
    self.content = message.text;
    
    [_contentBtn setTitle:message.text forState:UIControlStateNormal];
    _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight);
    _contentBtn.frame = _messageFrame.contentF;
    
    _speakButton.frame = _messageFrame.speakF;
    if (message.type == MessageTypeMe) {
        _contentBtn.contentEdgeInsets = UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft);
    }
    
    //    UIImage *normal , *focused;
    UIColor * backgroundColor ;
    if (message.type == MessageTypeMe) {
        backgroundColor = blueColorWithRGB(61, 172, 225);
    }else{
        backgroundColor = [UIColor orangeColor];
    }
    [_contentBtn setBackgroundColor:backgroundColor];
}
-(void)playerBtnClick{
    if (_speakButton.selected == NO) {
        NSString * dayweather =self.content;
        
        //       playViewController* sound=[playViewController soundPlayerInstance];
        //  [_player continueSpeaking];
        [self play:dayweather];
        _speakButton.selected = YES;
        
    }else {
        
        [self pauseSpeechReading];
        
        _speakButton.selected = NO;
    }
    
}

-(void)pauseSpeechReading{
    [_player stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@""];
    [_player speakUtterance:utterance];
    [_player stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

//播放声音
-(void)play:(NSString*)text{
    
    AVSpeechUtterance* u=[[AVSpeechUtterance alloc]initWithString:text];//设置要朗读的字符串
    u.voice=[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置语言
    u.volume=0.7;  //设置音量（0.0~1.0）默认为1.0
    u.rate=0.45;  //设置语速
    u.pitchMultiplier=1.0;  //设置语调
    [_player speakUtterance:u];
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utteranc
{
    //        NSLog(@"停止");
    _speakButton.selected = NO;
}



@end
