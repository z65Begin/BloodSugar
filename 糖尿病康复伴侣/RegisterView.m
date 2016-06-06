//
//  RegisterView.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView

+(id)registerView
{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"RegisterView" owner:nil options:nil];
    return [objs lastObject];
}

-(void)awakeFromNib{
    //用户ID
    CALayer *layerb = [self.userNameView layer];
    [layerb setMasksToBounds:YES];
    [layerb setCornerRadius:6.0];
    
    UITextField *userNameText= [[UITextField alloc] initWithFrame:CGRectMake(2, 2,W-40,self.userNameView.frame.size.height-4)];
    userNameText.backgroundColor = [UIColor whiteColor];
    userNameText.returnKeyType = UIReturnKeyDone;
    userNameText.placeholder = @"字母数字或下划线，4到30位";
    self.userNameText = userNameText;
    //    nameText.tag = Login_EmailTextField;
    userNameText.delegate = self;
    userNameText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.userNameView addSubview:userNameText];
    //密码
    CALayer *passLayer = [self.passView layer];
    [passLayer setMasksToBounds:YES];
    [passLayer setCornerRadius:6.0];
    
    UITextField *passText= [[UITextField alloc] initWithFrame:CGRectMake(2, 2,W-40,self.passView.frame.size.height-4)];
    passText.backgroundColor = [UIColor whiteColor];
    passText.returnKeyType = UIReturnKeyDone;
    passText.placeholder = @"6-20位密码";
    self.passText = passText;
    passText.secureTextEntry = YES;
    //    nameText.tag = Login_EmailTextField;
    passText.delegate = self;
    passText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.passView addSubview:passText];
    //确认密码
    CALayer *surePassLayer = [self.surePassView layer];
    [surePassLayer setMasksToBounds:YES];
    [surePassLayer setCornerRadius:6.0];
    
    UITextField *surePassText= [[UITextField alloc] initWithFrame:CGRectMake(2, 2,W-40,self.surePassView.frame.size.height-4)];
    surePassText.backgroundColor = [UIColor whiteColor];
    surePassText.returnKeyType = UIReturnKeyDone;
    surePassText.placeholder = @"请确认用户密码";
    surePassText.secureTextEntry = YES;
    self.surePassText = surePassText;
    //    nameText.tag = Login_EmailTextField;
    surePassText.delegate = self;
    surePassText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.surePassView addSubview:surePassText];
    //姓名
    CALayer *userLayer = [self.userView layer];
    [userLayer setMasksToBounds:YES];
    [userLayer setCornerRadius:6.0];
    
    UITextField *userText= [[UITextField alloc] initWithFrame:CGRectMake(2, 2,W-40,self.userView.frame.size.height-4)];
    userText.backgroundColor = [UIColor whiteColor];
    userText.returnKeyType = UIReturnKeyDone;
    self.userText = userText;
    //    nameText.tag = Login_EmailTextField;
    userText.delegate = self;
    userText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.userView addSubview:userText];
    //验证码
    CALayer *sureCodeLayer = [self.sureCode layer];
    [sureCodeLayer setMasksToBounds:YES];
    [sureCodeLayer setCornerRadius:6.0];
    
    UITextField *sureCodeText= [[UITextField alloc] initWithFrame:CGRectMake(2, 2,W-190,self.sureCode.frame.size.height-4)];
    sureCodeText.backgroundColor = [UIColor whiteColor];
    sureCodeText.returnKeyType = UIReturnKeyDone;
    self.sureCodeText = sureCodeText;
    //    nameText.tag = Login_EmailTextField;
    sureCodeText.delegate = self;
    sureCodeText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.sureCode addSubview:sureCodeText];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}
@end
