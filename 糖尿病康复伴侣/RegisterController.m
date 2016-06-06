//
//  RegisterController.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterView.h"
#import "Base64codeFunc.h"
#import "GDataXMLNode.h"
@interface RegisterController ()
@property(nonatomic,strong)RegisterView * registerView;
@end

@implementation RegisterController
{
    NSString * _VerificationCode;//验证码
    NSString * _sexNum;//性别
}
-(void)setCodeImage:(UIImage *)codeImage
{
    _codeImage = codeImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self createRegisterView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)createNav{
    //右边注册按钮
    UIBarButtonItem * registerBtn = [[UIBarButtonItem alloc]init];
    registerBtn.title = @"提交";
    registerBtn.tintColor = [UIColor blueColor];
    registerBtn.target = self;
    registerBtn.action = @selector(registerClick);
    self.navigationItem.rightBarButtonItem = registerBtn;
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor darkGrayColor];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新用户注册";  //设置标题
    self.navigationItem.titleView = titleLabel;
}
-(void)createRegisterView{
    RegisterView * registerView = [RegisterView registerView];
    self.registerView = registerView;
    [self.view addSubview:registerView];
    registerView.frame = CGRectMake(0, 64, W, H);
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    registerView.codeImage.image = self.codeImage;
    
    registerView.codeImage.userInteractionEnabled = YES;
    //添加点击操作
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(codeImageTouch:)];
    [ registerView.codeImage addGestureRecognizer:tap];
    registerView.userNameText.layer.cornerRadius = 5;
    registerView.userNameText.layer.masksToBounds = YES;
    registerView.userNameText.layer.borderWidth =1;
    registerView.userNameText.layer.borderColor = [[UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f]CGColor];
    
    registerView.passText.layer.cornerRadius = 5;
    registerView.passText.layer.masksToBounds = YES;
    registerView.passText.layer.borderWidth =1;
    registerView.passText.layer.borderColor = [[UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f]CGColor];
    
    registerView.surePassText.layer.cornerRadius = 5;
    registerView.surePassText.layer.masksToBounds = YES;
    registerView.surePassText.layer.borderWidth =1;
    registerView.surePassText.layer.borderColor = [[UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f]CGColor];
    
    registerView.userText.layer.cornerRadius = 5;
    registerView.userText.layer.masksToBounds = YES;
    registerView.userText.layer.borderWidth =1;
    registerView.userText.layer.borderColor = [[UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f]CGColor];

    registerView.sureCodeText.layer.cornerRadius = 5;
    registerView.sureCodeText.layer.masksToBounds = YES;
    registerView.sureCodeText.layer.borderWidth =1;
    registerView.sureCodeText.layer.borderColor = [[UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f]CGColor];

    
    self.registerView.manBtn.selected = YES;
    self.registerView.womanBtn.selected = NO;
    _sexNum = @"1";
    
    [self.registerView.manBtn addTarget:self action:@selector(manBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.registerView.womanBtn addTarget:self action:@selector(womanBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}
-(void)viewWillAppear:(BOOL)animated{
 [self getcodeimage];
     self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBarHidden = NO;
}
-(void)getcodeimage{
    NSURL *url = [NSURL URLWithString:@"http://www.halsma.com/healthdiabetes/client/getVerifyCode?dataStr="];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.registerView.codeImage.image = [UIImage imageWithData:data];
            NSLog(@"返回数据-%@",response);
        NSString *  cons = @"filename=";
        NSRange range = [[NSString stringWithFormat:@"%@",response] rangeOfString:cons];
        unsigned long location = range.location;
        unsigned long  leight = range.length;
        NSString * returnStr = [[NSString stringWithFormat:@"%@",response]substringWithRange:NSMakeRange(location+leight+2, 4)];
        _VerificationCode = returnStr;
    }];
}
-(void)codeImageTouch:(UITapGestureRecognizer *)tap
{
    [self getcodeimage];
}
///注册按钮点击事件
- (void)registerClick{
   if([self clickUser])
   {
       NSString * base64Str = [Base64codeFunc  base64StringFromText:self.registerView.passText.text  withKey:@"healthdi"];
       NSString *newPwd = @"";
       for(int i = 0; i<base64Str.length; i++){
           //转化为ASCII转码
           NSString *str = [[NSString alloc] initWithFormat:@"%1x",[base64Str characterAtIndex:i]];
           //小写转化大写，拼接字符串
           newPwd = [newPwd stringByAppendingString: [str uppercaseString] ];
       }
       if ([self.registerView.sureCodeText.text isEqualToString: _VerificationCode]) {
           if ([WebUtilsCommon userServer:self.registerView.userNameText.text andPwd:newPwd andName:self.registerView.userText.text andSex:_sexNum]) {
               [UtilCommon alertView:@"提示" andMessage:@"注册成功"];
               [self.navigationController popViewControllerAnimated:YES];
           }else{
           [UtilCommon alertView:@"提示" andMessage:@"注册失败,检查后重新输入"];
           }
       }else{
       [UtilCommon alertView:@"提示" andMessage:@"验证码错误"];
       }
   }
}
///判断各个 textField 是否 有值
-(BOOL)clickUser{
    if ([self.registerView.userNameText.text isEqualToString:@""]) {
        [self alertView:nil andMessage:@"用户ID不能为空"];
        return NO;
    }
    if ([self.registerView.passText.text isEqualToString:@""]) {
        [self alertView:nil andMessage:@"密码不能为空"];
        return NO;
    }
    if ([self.registerView.surePassText.text isEqualToString:@""]) {
        [self alertView:nil andMessage:@"确认密码不能为空"];
        return NO;
    }
    if ([self.registerView.userText.text isEqualToString:@""]) {
        [self alertView:nil andMessage:@"用户姓名不能为空"];
        return NO;
    }
    if ([self.registerView.sureCodeText.text isEqualToString:@""]) {
        [self alertView:nil andMessage:@"验证码不能为空"];
        return NO;
    }
    if (self.registerView.userNameText.text.length>30 || self.registerView.userNameText.text.length<4) {
        [self alertView:nil andMessage:@"用户ID不能超过30位或小于4位"];
        return NO;
    }
    if (self.registerView.passText.text.length>20 || self.registerView.passText.text.length<6) {
        [self alertView:nil andMessage:@"密码不能超过20位或小于6位"];
        return NO;
    }
    
    if (![self.registerView.passText.text isEqualToString:self.registerView.surePassText.text]) {
        [self alertView:nil andMessage:@"两次输入的密码不一致"];
        return NO;
    }

    return YES;
}
//弹出框
-(void)alertView:(NSString *)title andMessage:(NSString *)message{
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
//MARK:男士按钮点击事件
-(void)manBtnClick
{
    _sexNum = @"1";
    self.registerView.manBtn.selected = YES;
    self.registerView.womanBtn.selected = NO;
}
-(void)womanBtnClick
{
    _sexNum = @"2";
    self.registerView.manBtn.selected = NO;
    self.registerView.womanBtn.selected = YES;
}

@end
