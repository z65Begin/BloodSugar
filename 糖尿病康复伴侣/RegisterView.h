//
//  RegisterView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterView : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet RegisterView *userNameView;
@property(nonatomic,weak)UITextField * userNameText;//用户ID

@property (weak, nonatomic) IBOutlet UIView *passView;
@property(nonatomic,weak)UITextField * passText;// 密码

@property (weak, nonatomic) IBOutlet UIView *surePassView;
@property(nonatomic,weak)UITextField * surePassText;//确定密码

@property (weak, nonatomic) IBOutlet UIView *userView;
@property(nonatomic,weak)UITextField * userText;//姓名
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

@property (weak, nonatomic) IBOutlet UIView *sureCode;
@property(nonatomic,weak)UITextField * sureCodeText;//验证码

@property (weak, nonatomic) IBOutlet UIImageView *codeImage;//验证码图片

+(id)registerView;
@end
