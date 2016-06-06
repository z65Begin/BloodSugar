//
//  LoginViewController.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/1.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "LoginViewController.h"

#import "RegisterController.h"
#import "Const.h"
#import "FileUtils.h"
#import "UserInfoModel.h"
#import "KeyChainHelper.h"
#import "WebUtilsCommon.h"
#import "HomePageController.h"
#import "personInfomationViewController.h"
@interface LoginViewController (){
    NSString * currentTime;//当前时间
}
@property(nonatomic,strong)UserInfoModel * info;

@end

@implementation LoginViewController

-(UserInfoModel *)info{
    if (!_info) {
        _info = [[UserInfoModel alloc]init];
    }
    return _info;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置导航栏内容
    [self setupNavBar];
    [self createLoginView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

-(NSString *)getLocalTime{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
-(void)setupNavBar{
    UIImage *image = [UIImage imageNamed:@"aph"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
}
-(void)createLoginView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView * headImageView = [[UIImageView alloc]init];
    self.headImageView = headImageView;
    [self.view addSubview:_headImageView];
    headImageView.frame = CGRectMake(W/10*3, 30, W/5*2, 130);
    headImageView.image = [UIImage imageNamed:@"img_user_head.png"];
    
    UIView * lineView = [[UIView alloc]init];
    [self.view addSubview:lineView];
    lineView.frame = CGRectMake(0, 174, W, 1);
    lineView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    
    UITextField *nameText= [[UITextField alloc] initWithFrame:CGRectMake(0, 175, W,44)];
    nameText.returnKeyType = UIReturnKeyDone;
    nameText.placeholder = @"请输入用户ID";
    self.nameText = nameText;
    //    nameText.tag = Login_EmailTextField;
    nameText.delegate = self;
    nameText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:nameText];
    
    UIView * lineView2 = [[UIView alloc]init];
    [self.view addSubview:lineView2];
    lineView2.frame = CGRectMake(0, 219, W, 1);
    lineView2.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    
    UITextField *passText= [[UITextField alloc] initWithFrame:CGRectMake(0, 220, W,44)];
    passText.returnKeyType = UIReturnKeyDone;
    passText.placeholder = @"请输入密码";
    passText.secureTextEntry = YES;
    self.passText = passText;
    //    nameText.tag = Login_EmailTextField;
    passText.delegate = self;
    passText.keyboardType = UIKeyboardTypeEmailAddress;
    [self.view addSubview:passText];
    
    UIView * footView = [[UIView alloc]init];
    [self.view addSubview:footView];
    footView.frame = CGRectMake(0, 264, W, H-264);
    footView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn = loginBtn;
    [footView addSubview:_loginBtn];
    _loginBtn.frame = CGRectMake(10, 50, W-20, 40);
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setBackgroundColor:[UIColor blueColor]];
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerBtn = registerBtn;
    [footView addSubview:_registerBtn];
    _registerBtn.frame = CGRectMake(W-102, 115, 92, 30);
    [_registerBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
    [_registerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [_registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    if (![[user objectForKey:USER_ID]isEqualToString:@""]&&![[user objectForKey:USER_PWD]isEqualToString:@""]) {
        _nameText.text = [user objectForKey:USER_ID];
        _passText.text = [user objectForKey:USER_PWD];
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.nameText resignFirstResponder];
    [self.passText resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//登录
-(void)loginBtnClick:(UIButton *)button{
    [self.nameText resignFirstResponder];
    [self.passText resignFirstResponder];
    
    if ([_nameText.text isEqual:@""]){
        [self alertView:@"提示" andMessage:@"用户名不能为空"];
        return;
    }
    if([_passText.text isEqual:@""]){
        [self alertView:@"提示" andMessage:@"密码不能为空"];
        return;
    }else{
        [self userLoginFun];
    }
    
}

-(void)userLoginFun{
    NSString *userId = _nameText.text;
//    NSString *pwd = _passText.text;
//    sleep(1);
    
    //获取用户输入的信息
    //对用户信息的验证
    
    //检测站点是否可以连接
    NSString *remoteHostName = WEN_SERVER_IP;
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    BOOL isConnected =[UtilCommon isConnected:self.hostReachability];
    if (isConnected == NO) {
        NSString *userFileName = [userId stringByAppendingString:USER_INFO_FILE];
        if ([FileUtils hasFile:userFileName]) {
            self.info =  [FileUtils readUserInfo:userId];
            if (_info.Password){
                _localFlag = YES;//本地登录标志位
                [SingleManager sharedSingleManager].localLoginState = YES;
            }else{
                _localFlag = NO;
            }
        }
    }
    else{
        _localFlag = NO;
    }
    //本地登录
    if (_localFlag == YES) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        //        _nameText.text = [user objectForKey:USER_ID];
        //        _passText.text = [user objectForKey:USER_PWD];
        if ([_passText.text  isEqualToString:[user objectForKey:USER_PWD]]) {
            _isLoginSuccess =YES ;
        }
        if (_isLoginSuccess) {
            //写入配置文件信息
            [KeyChainHelper saveUserName:_nameText.text userNameService:USER_ID psaaword:_passText.text psaawordService:USER_PWD];
            HomePageController * homePageController = [[HomePageController alloc]init];
            [self.navigationController pushViewController:homePageController animated:YES];
            [SingleManager sharedSingleManager].InfoModel = [FileUtils readUserInfo:_nameText.text];
            
            homePageController.UserID = _nameText.text;
        }else{
            [self alertView:@"确定" andMessage:@"您的信息没有录入完毕，请联网录入"];
        }
    }else{
        _localFlag = NO;
    }
    //联网验证
    if (!_localFlag) {
        //检测站点是否可以连接
        NSString *remoteHostName = WEN_SERVER_IP;
        self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
        
        [self.hostReachability startNotifier];
        _isConnected =[UtilCommon isConnected:self.hostReachability];
        if (_isConnected) {
          [self saveData];
        }else{
            [self alertView:@"登录失败" andMessage:@"\n本地登录失败，请联网登录。"];
        }
    }
}

-(BOOL)checkUserAuthority:(UserInfoModel *)info{
    return YES;
}

//注册新用户触发事件
-(void)registerBtnClick
{
    [self requestCodeImage];
}

//弹出框
-(void)alertView:(NSString *)title andMessage:(NSString *)message{
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

-(void)requestCodeImage
{
    //    //设置请求路径
    //        NSString *urlStr=@"http://www.halsma.com/healthdiabetes/client/getVerifyCode?dataStr=";
    //        NSURL *url=[NSURL URLWithString:urlStr];
    //    //    2.创建请求对象
    //        NSURLRequest *request=[NSURLRequest requestWithURL:url];
    //    //    3.发送请求
    //    //发送同步请求，在主线程执行
    //        NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    UIImage * image = [UIImage imageWithData:data];
    //
    RegisterController * registerController = [[RegisterController alloc]init];
    //    registerController.codeImage = image;
    
    [self.navigationController pushViewController:registerController animated:YES];
}

-(void)saveData{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
//    HUD.delegate = self;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = @"正在初始化数据";
    
    [HUD showWhileExecuting:@selector(isLoginWithNet)  onTarget:self withObject:nil animated:YES];
}
- (void)isLoginWithNet{
    NSString *userId = _nameText.text;
    NSString *pwd = _passText.text;
    pwd = [UtilCommon encrytoMd5:pwd];
    //登录验证
    if([[WebUtilsCommon verifyServer:userId andPwd:pwd andType:@"02" andVersion:@"1"] isEqualToString:@"ok"]){
        _info = [WebUtilsCommon getUserInfoFromServer:userId];
        HUD.labelText = @"登录验证成功";
        [SingleManager sharedSingleManager].InfoModel = _info ;
        [SingleManager sharedSingleManager].InfoModel.Password = _passText.text;
        //_delegate.userInfo = _info;
        //用户账户验证
        _isLoginSuccess = [self checkUserAuthority:_info];
        if (_isLoginSuccess) {
//            NSLog(@"登录成功");
            HUD.labelText = @"登录成功";
            //                    登陆成功后把用户名和密码存储到UserDefault
            NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
            [user setObject:_nameText.text forKey:USER_ID];
            [user setObject:_passText.text forKey:USER_PWD];
            [user synchronize];
            //保存数据
            [self getDataFromserver];
        }
    }else{
        [self alertView:@"登录失败" andMessage:@"\n账号或者密码错误，请重新输入。"];
    }
}

-(void)getDataFromserver{
    HUD.labelText = @"正在获取用户信息";
    //写入用户信息
    BOOL flag = YES;
    UserInfoModel * personInfomodel = [WebUtilsCommon getUserInfoFromServer:_nameText.text];
    
        [SingleManager sharedSingleManager].InfoModel = personInfomodel;
    if(![FileUtils writeUserInfo:_nameText.text andInfo:personInfomodel]||!personInfomodel){
        return;
    }
    //获取用户目标并写入本地
    NSData * userTarget = [WebUtilsCommon getUserTargetUseUID:_nameText.text];
    HUD.labelText = @"正在写入用户目标和基准数据";
    if(![FileUtils writeUserTargetWithUID:_nameText.text andData:userTarget]){
        
        return ;
    }
    //    写入基准数据
    NSMutableArray * marray =[WebUtilsCommon BaseLineUID:_nameText.text BaseLineCode:@"All" beforeUpDataTime:nil];
    
    if (![FileUtils writegetBaselineData:marray dataTime:nil]||!marray) {
        return;
    }
    if (![FileUtils hasFile:FOOD_DATA_FILE]) {
        //食物数据
        NSData *foodData = [WebUtilsCommon getfoodMonsin:_nameText.text andDatatime:nil];
        if (!foodData || ![FileUtils writefoodMonsin:foodData]) {
            flag = NO;
        }
    }
    HUD.labelText = @"正在写入食物数据和运动数据";
    //运动种类
    NSData * sportData =[WebUtilsCommon getSportMonsin:_nameText.text andDatatime:[FileUtils readDataTimeFromFile:SPORT_TYPE_FILE]];
    if (![WebUtilsCommon getServerBool:sportData] || ![FileUtils writeSportMonsin:sportData]) {
        flag = NO;
    }
    //    药物列表
    NSData * yaoData =[WebUtilsCommon getyaoMonsin:_nameText.text andDatatime:nil];
    if (![WebUtilsCommon getServerBool:yaoData] || ![FileUtils writeyaoMonsin:yaoData]) {
        flag = NO;
    }
    HUD.labelText = @"正在写入药物列表和站内信";
    //    站内信
    NSData *innerMailArr;
//    有网络时获取最新站内信
    NSString *remoteHostName = WEN_SERVER_IP;
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    if ([UtilCommon isConnected:self.hostReachability]) {
        innerMailArr = [WebUtilsCommon getInnerMailFromServer:[FileUtils readInnerMailUpdateTime:_nameText.text] andUid:_nameText.text];
    }
   
// 将邮件 写入本地
    [FileUtils writeInnerMailWithUID:_nameText.text andServerData:innerMailArr];
    HUD.mode = MBProgressHUDModeCustomView;
    if (flag) {
        HUD.labelText = @"初始化数据完成";
        //        判断个人信息是否设置
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * name = [user objectForKey:USER_ID];
        UserInfoModel *  infoModel = [FileUtils readUserInfo:name];
        if ([infoModel.InfoSet isEqualToString:@"1"]) {
            HomePageController * homePageController = [[HomePageController alloc]init];
            [self.navigationController pushViewController:homePageController animated:YES];
            homePageController.UserID = _nameText.text;
        }else {
            personInfomationViewController * personinfovc = [[personInfomationViewController alloc]init];
            [self.navigationController pushViewController:personinfovc animated:YES];
            __weak typeof(self) weakSelf = self;
//            [self presentViewController:personinfovc animated:YES completion:nil];
            personinfovc.changeViewController = ^(NSString * userID){
                HomePageController * homePageController = [[HomePageController alloc]init];
                homePageController.UserID = userID;
                
                [weakSelf.navigationController pushViewController:homePageController animated:NO];
            
            };
        }
    }else{
        HUD.labelText = @"初始化数据失败";
    }
}
@end
