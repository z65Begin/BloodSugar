//
//  LoginViewController.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/1.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserInfoModel.h"
#import "AppDelegate.h"
@interface LoginViewController : UIViewController<MBProgressHUDDelegate,UITextFieldDelegate>
{
   BOOL _localFlag;
   BOOL _isLoginSuccess;
   BOOL _isConnected;
   MBProgressHUD *HUD;
    
}
@property(nonatomic,weak)UIImageView * headImageView;
@property(nonatomic,weak)UIButton * loginBtn;
@property(nonatomic,weak)UIButton * registerBtn;

@property(nonatomic,weak)UITextField * nameText;
@property(nonatomic,weak)UITextField * passText;
@property (nonatomic) Reachability *hostReachability;
//用户信息
@property (strong, nonatomic) UserInfoModel *userInfo;

-(void)alertView:(NSString *)title andMessage:(NSString *)message;
@end
