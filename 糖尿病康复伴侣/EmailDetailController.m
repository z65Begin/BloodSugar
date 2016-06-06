//
//  EmailDetailController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "EmailDetailController.h"

@interface EmailDetailController ()
@property(nonatomic,strong) AVSpeechSynthesizer* player;
@end

@implementation EmailDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    
    [self.playerBtn setBackgroundImage:[UIImage imageNamed:@"img_voice_q"] forState:UIControlStateNormal];
    [self.playerBtn setBackgroundImage:[UIImage imageNamed:@"img_voice"] forState:UIControlStateSelected];
    self.playerBtn.selected = NO;
    [self.playerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.playerBtn addTarget:self action:@selector(playerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _player=[[AVSpeechSynthesizer alloc]init];
    _player.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initData{
   
    _innerMail = _innerMailArr[_index];
    _emailName.text = _innerMail.senderName;
    _emailTitle.text = _innerMail.title;
    _emailText.text = _innerMail.content;
    _emailTime.text = _innerMail.sendTime;
    //    设置已读
    NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
    NSString * username = [userdef objectForKey:USER_ID];
    [FileUtils writeInnerMailReadStateUid:username mailId:_innerMail.mid state:@"ture"];
    if (_innerMail.Adjunct !=nil) {
        self.addfiles.image = [UIImage imageNamed:@"ico_adjunct"];
        self.adjunt.text = _innerMail.Adjunct;
        self.adjunt.userInteractionEnabled = YES;
        NSArray * array =[_innerMail.Adjunct componentsSeparatedByString:@"."];
        if ([array[1] isEqualToString:@"txt"]||[array[1] isEqualToString:@"jpg"]||[array[1] isEqualToString:@"jpeg"]||[array[1]isEqualToString:@"png"]) {
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
            [self.adjunt addGestureRecognizer:tap];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"格式有误" message:@"不能读取..." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}
-(void)tap{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"下载中" message:@"请稍后..." delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    //    下载附件
    //文件类型  用户id
    NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
    NSString * userName = [userdef objectForKey:@"name"];
    UserInfoModel * usermodel =  [FileUtils readUserInfo:userName];
    
//    NSData * data =   [WebUtilsCommon getNoticeAdjFromServerUID:userName Uorg:usermodel.Org FileName:_innerMail.Adjunct FileType:@"NoticeAdj"];
    //    将下载的数据写入到本地
    [FileUtils writeNoticeAdjtoLocal:nil UID:userName];
    [alert removeFromSuperview];
}


//前一封
- (IBAction)beforeEmailAct:(UIButton *)sender {
    if (_index == 0) {
        _beforeEmailBtn.enabled = NO;
    }else{
        _index--;
        [self initData];
    }
    _afterEmailBtn.enabled = YES;
    self.playerBtn.selected = NO;
    [self pauseSpeechReading];
}
//后一封
- (IBAction)afterEmailAct:(UIButton *)sender {
    if (_index == _innerMailArr.count - 1 ) {
        _afterEmailBtn.enabled = NO;
    }else{
        _index++;
        [self initData];
    }
    _beforeEmailBtn.enabled = YES;
    self.playerBtn.selected = NO;
    [self pauseSpeechReading];
}

//页面即将消失时
-(void)viewWillDisappear:(BOOL)animated{
    
    NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
    NSString * username = [userdef objectForKey:@"name"];
    [FileUtils writeInnerMail:_innerMailArr andUid:username];
    
    self.playerBtn.selected = NO;
    [self pauseSpeechReading];
}

-(void)playerBtnClick
{
    if (self.playerBtn.selected == NO) {
        NSString * dayweather =_innerMail.content;
        
        //       playViewController* sound=[playViewController soundPlayerInstance];
        //  [_player continueSpeaking];
        [self play:dayweather];
        self.playerBtn.selected = YES;
        
    }else {
        
        [self pauseSpeechReading];
        
        self.playerBtn.selected = NO;
    }
    
}

-(void)pauseSpeechReading
{
    [_player stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@""];
    [_player speakUtterance:utterance];
    [_player stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}

//播放声音
-(void)play:(NSString*)text
{
    
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
    self.playerBtn.selected = NO;
    
}

@end
