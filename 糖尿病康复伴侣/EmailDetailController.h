//
//  EmailDetailController.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface EmailDetailController : UIViewController<AVSpeechSynthesizerDelegate>
//附件图标
@property (weak, nonatomic) IBOutlet UIImageView *addfiles;

-(void)initData;
//附件名字
@property (weak, nonatomic) IBOutlet UILabel *adjunt;

//发件人
@property (weak, nonatomic) IBOutlet UILabel *emailName;
//邮件标题
@property (weak, nonatomic) IBOutlet UILabel *emailTitle;
//邮件内容
@property (weak, nonatomic) IBOutlet UITextView *emailText;
//发件时间
@property (weak, nonatomic) IBOutlet UILabel *emailTime;
@property (weak, nonatomic) IBOutlet UIButton *playerBtn;

@property(strong,nonatomic)NSArray *innerMailArr;
//站内邮箱
@property (strong,nonatomic)InnerMailModel *innerMail;

@property (nonatomic)NSInteger index;


//前一封
@property (weak, nonatomic) IBOutlet UIButton *beforeEmailBtn;
- (IBAction)beforeEmailAct:(UIButton *)sender;
//后一封
@property (weak, nonatomic) IBOutlet UIButton *afterEmailBtn;
- (IBAction)afterEmailAct:(UIButton *)sender;

-(void)play:(NSString*)text;
@end
