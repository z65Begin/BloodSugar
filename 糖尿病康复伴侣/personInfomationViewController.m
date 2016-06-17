//
//  personInfomationViewController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/15.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "personInfomationViewController.h"
#import "personInfoView.h"
#import "UtilCommon.h"
#import "UserInfoModel.h"
#import "KMDatePicker.h"

#import "HomePageController.h"
//#import "LoginViewController.h"
//@class LoginViewController;

@interface personInfomationViewController ()<UITableViewDelegate,UITableViewDataSource,KMDatePickerDelegate,UIScrollViewDelegate>
{  UIView *  _backgroundView ;//遮罩视图
    personInfoView * person;
    NSString * _sexNum;//性别字符串
    NSString * _activityNum;//活动字符串
    NSString * _diabetesClass;//糖尿病类型字符串
    NSString * _familyHistory;//家族病史
    UIBarButtonItem * _backBtn;//返回按钮
    UIBarButtonItem * _saveBtn;//保存按钮
    UIButton * _consultBtn;//参考按钮
    NSArray * _aimfoot;//目标步数
    BOOL _isAllowEdit;//允许编辑
    BOOL _isConnected;//有网络
    UIView * child1;
//    UIView * child2;
    BOOL _child2IsExist;//是否存在
    NSUserDefaults * user;
    NSMutableArray * footstep;//步数数组（0 步数 1 序号）
}
@property (nonatomic) Reachability *hostReachability;
@property(nonatomic)UserInfoModel * infoModel;
@property(nonatomic,weak)UIButton * leftBtn;//底部按钮
@property(nonatomic,weak)UIButton * rightBtn;
@property(nonatomic, strong)UITextField * sportTF;//目标步数

@property (nonatomic, strong) UIView * child2View;


@end

@implementation personInfomationViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
//     [self createToolBar];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = YES;
        child1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, W, H-49-64)];
//        child2= [[UIView alloc]initWithFrame:CGRectMake(0, 64, W  , H-49-64)];
        child1.backgroundColor = [UIColor clearColor];
//        child2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:child1];
        
        _aimfoot = @[@"3000",@"5000",@"8000",@"10000",@"12000"];
        self.view.backgroundColor = [UIColor whiteColor];
        [self createNav];
        [self pageInit];
        [self createHomeScrollView];
        [self readinfo];
        [self createToolBar];
       
    });

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
dispatch_async(dispatch_get_main_queue(), ^{
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }
});
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
    self.navigationItem.title = @"个人信息";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = YES;
}

-(void)pageInit{
    //检测站点是否可以连接
    NSString *remoteHostName = WEN_SERVER_IP;
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    _isConnected =[UtilCommon isConnected:self.hostReachability];
    if (!_isConnected) {
        [UtilCommon alertView:@"提示" andMessage:@"您尚未连接网络个人信息将不可编辑。若要编辑信息，请先连接网络并重新打开页面"];
        _backgroundView = [[UIView alloc] init];
        _backgroundView.frame = CGRectMake(0, 0,W,H);
        _backgroundView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
        _backgroundView.alpha = 0.4;
        self.rightBtn.userInteractionEnabled = NO;
        self.leftBtn.userInteractionEnabled =NO;
        [self.view addSubview:_backgroundView];
    }else{
        //    填充数据
        user = [NSUserDefaults standardUserDefaults];
        if ([SingleManager sharedSingleManager].localLoginState == YES) {
            //          弹出验证登录界面
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请验证登录" message:@" " delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            alert.delegate = self;
            alert.tag = 1993;
            //    alert.textInputContextIdentifier = @"我的收藏";
            alert.alertViewStyle  =UIAlertViewStyleLoginAndPasswordInput;
            NSString * name = [user objectForKey:USER_ID];
            NSString * pass = [user objectForKey:USER_PWD];
            //得到输入框
            UITextField *tfname=[alert textFieldAtIndex:0];
            UITextField *tfpass=[alert textFieldAtIndex:1];
            tfname.text = name;
            tfpass.text = pass;
            [alert show];
        }
    }
    [self readinfo];
}
-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1993) {
        if(buttonIndex == 1){
            UITextField *tfname=[alertView textFieldAtIndex:0];
            UITextField *tfpass=[alertView textFieldAtIndex:1];
            if ([tfname.text isEqualToString:[user objectForKey:USER_ID]]&&[tfpass.text isEqualToString:[user objectForKey:USER_PWD]] ) {
                self.infoModel = [WebUtilsCommon getUserInfoFromServer:tfname.text];
                if(![FileUtils writeUserInfo:tfname.text andInfo:self.infoModel]||![WebUtilsCommon getUserInfoFromServer:tfname.text]){
                    return;
                }else{
                [UtilCommon alertView:@"" andMessage:@"登录成功"];
                }
            }
        }
    }else if (alertView.tag == 1992){
        if(buttonIndex == 1){
            //上传数据（先上传后存储）
            if (!_child2IsExist) {
                //            上传第一页的数据
                UserInfoModel * model = [[UserInfoModel alloc]init];
                model.UID = _infoModel.UID;
                model.Name =person.nameTF.text;
                model.Pinyin =person.pinyinTF.text;
                model.NickName = person.nickNameTF.text;
                model.Email = person.emailTF.text;
                model.Sex = [self judgeSex];
                model.Tel = person.telrphoneTF.text;
                model.Birthday = person.birthdayLable.text;
                model.Height = person.heightTF.text;
                model.Weight = person.weightTF.text;
                model.ExIntensity = [self judgeExIntensity];
                model.DiabetesType = [self judegUDiabType];
                model.Complication = [self  judgeComplication];
                model.RestHr = person.RestHrTF.text;
                model.FamilyHis = [self judgeFamilyHis];
                model.CliDiagnosis =person.clinicalDiagnosisTV.text;
                model.InfoSet = @"1";
                NSLog(@"%@UID  %@Name  %@Pinyin  %@NickName  %@Email  %@Sex  %@Tel  %@Birthday  %@Height  %@Weight %@ExIntensity  %@DiabetesType %@FamilyHis %@ Complication",model.UID,model.Name, model.Pinyin, model.NickName,model.Email,model.Sex,model.Tel, model.Birthday,model.Height,model.Weight,model.ExIntensity, model.DiabetesType,  model.FamilyHis,model.Complication);
                if ([WebUtilsCommon upUserInfoUseModel:model]) {
                    [UtilCommon alertView:@"" andMessage:@"上传成功"];
                    //                写入本地
//                    [FileUtils writeUserInfo:model.UID andInfo:model];
                    UserInfoModel * personInfomodel = [WebUtilsCommon getUserInfoFromServer:[SingleManager  sharedSingleManager].InfoModel.UID];
                    
                    [SingleManager sharedSingleManager].InfoModel = personInfomodel;
                    [FileUtils writeUserInfo:personInfomodel.UID andInfo:personInfomodel];
                    
                }else{
                    [UtilCommon alertView:@"错误" andMessage:@"上传个人信息失败"];
                }
            }else{
                //        上传第二页的数据
//                取序号
              NSString *  str  = footstep[1];
                
                int num = str.intValue;
                num= num+1;
                NSString * numstr = [NSString stringWithFormat:@"%d",num];
                //    取出目标步数
                NSDate *today = [NSDate date];
                
                NSString * todayDateStr =[self cutFinalCharacter:[UtilCommon dateFormateStr:today DATEFORMAT:@"YYYYMMDD"]];
                [WebUtilsCommon upUserTargetFootUseUID:_infoModel.UID footStepValue:self.sportTF.text Index:numstr Date:todayDateStr];
               NSData * data = [WebUtilsCommon getUserTargetUseUID:[SingleManager sharedSingleManager].InfoModel.UID];
                [FileUtils writeUserTargetWithUID:[SingleManager sharedSingleManager].InfoModel.UID andData:data];
                [UtilCommon alertView:@"" andMessage:@"上传成功"];
            }
        }
    }
}
#pragma mark -- 取消第一响应者
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [person endEditing:YES];
    [self.child2View endEditing:YES];
}

-(void)createNav{
    self.navigationItem.title = @"个人信息";
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 50, 30);
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  
    _backBtn = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = _backBtn;
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4.0f;
    [button setBackgroundColor:blueColorWithRGB(61, 172, 225)];
    [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    _saveBtn = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem =_saveBtn;
}
#pragma mark -- 返回
-(void)back{
    NSString * name = [user objectForKey:USER_ID];
    UserInfoModel * infoModel = [FileUtils readUserInfo:name];
    NSLog(@"%@",infoModel.InfoSet);
    if ([infoModel.InfoSet isEqualToString:@"1"] && self.navigationController.viewControllers.count == 2) {
        [self.navigationController popViewControllerAnimated:NO];
        if (self.changeViewController) {
            self.changeViewController(infoModel.UID);
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}
#pragma mark -- 保存
-(void)save{
//保存按钮
//   判断个人信息录入是否完全
    if([person.nameTF.text isEqualToString:@""] ||[person.birthdayLable.text isEqualToString:@""]  ||[person.heightTF.text  isEqualToString:@""] ||[person.heightTF.text isEqualToString:@""] || [person.RestHrTF.text isEqualToString:@""]){
        UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"用户信息录入不完全" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        [alert show];
    }
    else{
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"将要保存并上传[个人信息]，继续吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.delegate = self;
        alert.tag = 1992;
        [alert show];
        
//      用户设置变更
        NSString * name = [user objectForKey:USER_ID];
        [FileUtils writeUserinfoSetStateUseUID:name andState:@"1"];
    }
}
//判断并发症
-(NSString *)judgeComplication{
   int  num1=0;
    NSString  *returnStr2 = @"";
    NSString  *returnStr3 = @"";
    if (person.noBothDisease.selected == YES) {
//        无并发症 返回空
        return @"";
    }
    else{
//    有并发症
        if(person.bothDiseaseHypertension.selected == YES)
        {
            num1  +=1;
            if (person.bothDiseaseHypertensionSlight.selected == YES) {
                returnStr2 = [returnStr2 stringByAppendingString:@"1"];
            }
            else if ( person.bothDiseaseHypertensionM.selected == YES){
                returnStr2 = [returnStr2 stringByAppendingString:@"2"];
            }else{
            returnStr2 = [returnStr2 stringByAppendingString:@"3"];
            }
        }else{
         returnStr2 = [returnStr2 stringByAppendingString:@"0"];
        }
        if (person.heartBrain.selected == YES) {
            num1 +=2;
            if (person.heartBrainSlight.selected == YES) {
                returnStr2 = [returnStr2 stringByAppendingString:@"1"];
            }
            else if ( person.heartBrainM.selected == YES){
                returnStr2 = [returnStr2 stringByAppendingString:@"2"];
            }else{
                returnStr2 = [returnStr2 stringByAppendingString:@"3"];
            }
        }else{
            returnStr2 = [returnStr2 stringByAppendingString:@"0"];
        }
        if (person.Eye.selected == YES) {
            num1 +=4;
            if (person.eyeSlight.selected == YES) {
                returnStr2 = [returnStr2 stringByAppendingString:@"1"];
            }
            else if ( person.eyeM.selected == YES){
                
                returnStr2 = [returnStr2 stringByAppendingString:@"2"];
            }else{
                returnStr2 = [returnStr2 stringByAppendingString:@"3"];
            }
        }else{
            returnStr2 = [returnStr2 stringByAppendingString:@"0"];
            
        }
        if ( person.nervousSystem.selected == YES) {
            num1 +=8;
            if (person.nervousSystemSlight.selected == YES) {
                returnStr2 = [returnStr2 stringByAppendingString:@"1"];
            }
            else if ( person.nervousSystemM.selected == YES){
                returnStr2 = [returnStr2 stringByAppendingString:@"2"];
            }else{
                returnStr2 = [returnStr2 stringByAppendingString:@"3"];
            }
        }else{
            returnStr2 = [returnStr2 stringByAppendingString:@"0"];
        }
        if (person.diabeticNephropathy.selected == YES) {
              num1 +=16;
            if (person.diabeticNephropathySlight.selected == YES) {
                returnStr2 = [returnStr2 stringByAppendingString:@"1"];
            }
            else if ( person.diabeticNephropathyM.selected == YES){
                returnStr2 = [returnStr2 stringByAppendingString:@"2"];
            }else{
                returnStr2 = [returnStr2 stringByAppendingString:@"3"];
            }
        }else{
            returnStr2 = [returnStr2 stringByAppendingString:@"0"];
        }
        if (person.DiabeticFoot.selected == YES) {
            num1 +=32;
            if (person.DiabeticFootSlight.selected == YES) {
                returnStr2 = [returnStr2 stringByAppendingString:@"1"];
            }
            else if ( person.DiabeticFootM.selected == YES){
                returnStr2 = [returnStr2 stringByAppendingString:@"2"];
            }else{
                returnStr2 = [returnStr2 stringByAppendingString:@"3"];
            }
        }else{
            returnStr2 = [returnStr2 stringByAppendingString:@"0"];
        }
      NSString *   returnStr1 = [self ToHex:num1];
        if ( person.other.selected == YES) {
            returnStr3 = person.otherTF.text;
        }
        return [NSString stringWithFormat:@"%@:%@:%@",returnStr1,returnStr2,returnStr3];
    }
    return 0;
}
//判断家族病史
-(NSString *)judgeFamilyHis{
    NSString * STR = @"";
    if(person.diabetes.selected== NO && person.hypertension.selected == NO && person.Obesity.selected == NO && person.coronary_heart_disease.selected == NO && person.tumour.selected == NO &&  person.Cerebral_vascular_disease.selected == NO){
        return @"";
    }else{
        if (person.diabetes.selected == YES) {
            STR = [STR stringByAppendingString:@"01,"];
        }
        if (person.hypertension.selected== YES){
            STR = [STR stringByAppendingString:@"02,"];
        }
        if (person.Obesity.selected == YES){
            STR = [STR stringByAppendingString:@"03,"];
        }
        if (person.coronary_heart_disease.selected == YES){
            STR = [STR stringByAppendingString:@"04,"];
        }
        if ( person.tumour.selected == YES){
            STR = [STR stringByAppendingString:@"05,"];
        }
        if (  person.Cerebral_vascular_disease.selected == YES){
            STR = [STR stringByAppendingString:@"06,"];
        }
        return  STR = [self cutFinalCharacter:STR];
    }
}
//删除最后一个字符
-(NSString * )cutFinalCharacter:(NSString *)str{
    return  [str substringToIndex:[str length] - 1];
}
//判断糖尿病类型
-(NSString *)judegUDiabType{
    person.diabetesTwo.selected = NO;
    if( person.highSugarPeople.selected == YES)
    {
    return @"0";
    
    }else if (  person.diabetesOne.selected == YES){
    return @"1";
    }else return @"2";

}

//判断活动强度
-(NSString *)judgeExIntensity{
    if (person.bedridden.selected == YES) {
        return @"0";
    }else if (person.smallWork.selected == YES){
    
    return @"1";
    }else if (   person.middleWork.selected ==YES){
    return @"2";
    }else
    return @"3";
}
-(NSString *)judgeSex{
    if (person.SexManBtn.selected == YES) {
        return @"1";
    }
else return @"2";
}
#pragma mark  -- 建立视图
-(void)createHomeScrollView{
     [self createLeftView];
}
#pragma mark --  工具栏 俩按钮
-(void)createToolBar{
    UIView * toolView = [[UIView alloc]init];
    toolView.backgroundColor = [UIColor colorWithHexString:@"#cecece"];
    toolView.frame = CGRectMake(0, H-49, W, 49);
    
    [self.view addSubview:toolView];
    //创建2个button
    UIButton * Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toolView addSubview:Btn];
    self.leftBtn = Btn;
    Btn.frame = CGRectMake(0, 0, W/2, 49);
    [Btn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]];
    [Btn setTitle:@"个人信息" forState:UIControlStateNormal];
    Btn.selected = YES;
    [Btn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * doctorBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [toolView addSubview:doctorBtn];
    self.rightBtn = doctorBtn;
    doctorBtn.frame = CGRectMake(W/2, 0, W/2, 49);
    [doctorBtn setTitle:@"目标设置" forState:UIControlStateNormal];
    doctorBtn.selected = NO;
    [doctorBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:toolView];
}
-(void)leftBtnClick{
    if (self.leftBtn.selected == NO) {
        self.leftBtn.selected = YES;
        self.rightBtn.selected = NO;
//        [child2 removeFromSuperview];
//        child2.hidden = YES;
        self.child2View.hidden = YES;
        
        _child2IsExist = NO;
        [self.leftBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]];
        [self.rightBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
    }
}
-(void)rightBtnClick{
    if (self.rightBtn.selected == NO) {
        self.rightBtn.selected = YES;
        self.leftBtn.selected = NO;
        [self createrightView];
            _child2IsExist = YES;
        [self.rightBtn setBackgroundColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]];
        [self.leftBtn setBackgroundColor:[UIColor colorWithHexString:@"#cecece"]];
    }
}
-(void)createrightView{
    //获取用户目标并写入本地
    NSData * userTarget = [WebUtilsCommon getUserTargetUseUID:_infoModel.UID];
    if(![FileUtils writeUserTargetWithUID:_infoModel.UID andData:userTarget]){
        return ;
    }
    //    取出目标步数
    NSDate *today = [NSDate date];
    NSString * todayDateStr =[self cutFinalCharacter:[UtilCommon dateFormateStr:today DATEFORMAT:@"YYYYMMDD"]];
    NSString * name = [user objectForKey:USER_ID];
    footstep =  [FileUtils getTargetFootStepUseUID:name andDate:todayDateStr];
    if ([footstep[0] isEqualToString:@""]) {
        self.sportTF.text = @"5000";
    }else{
        self.sportTF.text = footstep[0];
    }
    if ([self.view.subviews containsObject:self.child2View]) {
        self.child2View.hidden = NO;
    }else{
        [self.view addSubview:self.child2View];
    }
}
- (UITextField *)sportTF{
    if (!_sportTF) {
        _sportTF = [[UITextField alloc]init];
        _sportTF.keyboardType = UIKeyboardTypeNumberPad;
        _sportTF.layer.cornerRadius = 5;
        _sportTF.layer.masksToBounds = YES;
        _sportTF.layer.borderWidth = 1;
        _sportTF.layer.borderColor = [[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]CGColor];
    }
    return _sportTF;
}

- (UIView *)child2View{
    if (!_child2View) {
        _child2View = [[UIView alloc]initWithFrame:CGRectMake(0, 64, W  , H-49-64)];
        _child2View.backgroundColor = [UIColor whiteColor];
        
        UILabel * lb1 = [UILabel new];
        lb1.text = @"目标步数：";
        lb1.font = [UIFont systemFontOfSize:15];
        [_child2View addSubview:lb1];
        lb1.frame = CGRectMake(10, 20, 75, 25);
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
         button.frame = CGRectMake(W-50, 20, 40, 25);
        [button setTitle:@"参考" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        
        [button setTitleColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(consultBtn:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [_child2View addSubview:button];
       self.sportTF.frame = CGRectMake(CGRectGetMaxX(lb1.frame)+5, 20, W - CGRectGetMaxX(lb1.frame)- 60, 25);
        [_child2View addSubview:self.sportTF];
    }
    return _child2View;
}

#pragma mark -- 参考按钮点击事件
-(void)consultBtn:(UIButton *)btn{
    _backgroundView = [[UIView alloc] init];
    _backgroundView.frame = CGRectMake(0, 0,W,H);
    _backgroundView.backgroundColor = [UIColor colorWithRed:(40/255.0f) green:(40/255.0f) blue:(40/255.0f) alpha:1.0f];
    _backgroundView.alpha = 0.4;
    [self.view addSubview:_backgroundView];
    
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGRClick:)];
    [_backgroundView addGestureRecognizer:tapGR];
    
    UITableView * consultView = [[UITableView alloc]initWithFrame:CGRectMake(20, (W - 30 * _aimfoot.count) * 0.5, [UIScreen mainScreen].bounds.size.width-40, 30 * _aimfoot.count) style:UITableViewStylePlain];
    consultView.delegate = self;
    consultView.dataSource = self;
    consultView.tag = 2001;
    consultView.alpha = 1.0;
    consultView.layer.cornerRadius = 8.0f;
    consultView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:consultView];
}
- (void)tapGRClick:(UITapGestureRecognizer *)tapGR{
    [_backgroundView removeFromSuperview];
    UIView * view = [self.view viewWithTag:2001];
    [view removeFromSuperview];
}

#pragma mark -- tableViewdelegate -- 参考步数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _aimfoot.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"aimfoot"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aimfoot"];
    }
    cell.textLabel.text = _aimfoot[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"point"];
    cell.imageView.highlightedImage = [UIImage imageNamed:@"point_select"];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView * consultView  = [self.view viewWithTag:2001];
    [consultView removeFromSuperview];
    [_backgroundView removeFromSuperview];
    _sportTF.text = _aimfoot[indexPath.row];
}

- (void)createLeftView{
    CGRect frame = self.view.bounds;
    frame.size.height -= (49+64);
    UIScrollView * personScrollView = [[UIScrollView alloc]initWithFrame:frame];
    personScrollView.contentSize = CGSizeMake(0,1800);
    personScrollView.showsHorizontalScrollIndicator = NO;
    personScrollView.showsVerticalScrollIndicator = NO;
    personScrollView.bounces = NO;
    personScrollView.delegate = self;
    
    personInfoView * personscrollview = [personInfoView PersonInfoView];
    person = personscrollview;
    person.frame = CGRectMake(0, 0, W, 1750);
    [personScrollView addSubview:personscrollview];
      [self addImage:person.SexManBtn];
      [self addImage:person.SexWomanBtn];
      [person.SexManBtn addTarget:self action:@selector(manBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
      [person.SexWomanBtn addTarget:self action:@selector(womanBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [person.timeChooseBtn addTarget:self action:@selector(createChooseTime:) forControlEvents:UIControlEventTouchUpInside];
//    活动强度
     [self addImage:person.bedridden];
    person.bedridden.tag = 10000;
     [self addImage:person.smallWork];
    person.smallWork.tag = 10001;
     [self addImage:person.middleWork];
    person.middleWork.tag = 10002;
     [self addImage:person.bigWork];
    person.bigWork.tag = 10003;
    [person.bedridden addTarget:self action:@selector(ActivityIntensity:) forControlEvents:UIControlEventTouchUpInside];
    [person.smallWork addTarget:self action:@selector(ActivityIntensity:) forControlEvents:UIControlEventTouchUpInside];
    [person.middleWork addTarget:self action:@selector(ActivityIntensity:) forControlEvents:UIControlEventTouchUpInside];
    [person.bigWork addTarget:self action:@selector(ActivityIntensity:) forControlEvents:UIControlEventTouchUpInside];
//    糖尿病类型
    [self addImage:person.highSugarPeople];
    person.highSugarPeople.tag = 10004;
    [self addImage:person.diabetesOne];
    person.diabetesOne.tag = 10005;
    [self addImage:person.diabetesTwo];
    person.diabetesTwo.tag = 10006;
    [person.highSugarPeople addTarget:self action:@selector(diabetesType:) forControlEvents:UIControlEventTouchUpInside];
    [person.diabetesOne addTarget:self action:@selector(diabetesType:) forControlEvents:UIControlEventTouchUpInside];
    [person.diabetesTwo addTarget:self action:@selector(diabetesType:) forControlEvents:UIControlEventTouchUpInside];
//    家族病史
    [self addImage2:person.diabetes];
    person.diabetes.tag = 10010;
   
    [self addImage2:person.hypertension];
    person.hypertension.tag = 10011;
    [self addImage2:person.Obesity];
    person.Obesity.tag = 10012;
    [self addImage2:person.coronary_heart_disease];
    person.coronary_heart_disease.tag = 10013;
    [self addImage2:person.tumour];
    person.tumour.tag = 10014;
    [self addImage2:person.Cerebral_vascular_disease];
    person.Cerebral_vascular_disease.tag = 10015;
    
    [person.diabetes addTarget:self action:@selector(familyHisAction:) forControlEvents:UIControlEventTouchUpInside];
    [person.hypertension addTarget:self action:@selector(familyHisAction:) forControlEvents:UIControlEventTouchUpInside];
    [person.Obesity addTarget:self action:@selector(familyHisAction:) forControlEvents:UIControlEventTouchUpInside];

    [person.coronary_heart_disease addTarget:self action:@selector(familyHisAction:) forControlEvents:UIControlEventTouchUpInside];
    [person.tumour addTarget:self action:@selector(familyHisAction:) forControlEvents:UIControlEventTouchUpInside];
    [person.Cerebral_vascular_disease addTarget:self action:@selector(familyHisAction:) forControlEvents:UIControlEventTouchUpInside];
//    并发症
    [self addImage2:person.noBothDisease];
    [person.noBothDisease addTarget:self action:@selector(bothdiabetes:) forControlEvents:UIControlEventTouchUpInside];
//    高血压
     [self addImage2:person.bothDiseaseHypertension];
    person.bothDiseaseHypertension.tag = 10020;
    
    [self addImage:person.bothDiseaseHypertensionSlight];
    person.bothDiseaseHypertensionSlight.tag = 10021;
    
    [self addImage:person.bothDiseaseHypertensionM];
    person.bothDiseaseHypertensionM.tag = 10022;
    
    [self addImage:person.bothDiseaseHypertensionHeavy];
    person.bothDiseaseHypertensionHeavy.tag = 10023;
    
    [person.bothDiseaseHypertension addTarget:self action:@selector(Hypertension:) forControlEvents:UIControlEventTouchUpInside];
    [person.bothDiseaseHypertensionSlight addTarget:self action:@selector(Hypertension:) forControlEvents:UIControlEventTouchUpInside];
    [person.bothDiseaseHypertensionM addTarget:self action:@selector(Hypertension:) forControlEvents:UIControlEventTouchUpInside];
    [person.bothDiseaseHypertensionHeavy addTarget:self action:@selector(Hypertension:) forControlEvents:UIControlEventTouchUpInside];
    
//    心脑血管病变
    [self addImage2:person.heartBrain];
    person.heartBrain.tag = 10030;
    [self addImage:person.heartBrainSlight];
    person.heartBrainSlight.tag = 10031;
    [self addImage:person.heartBrainM];
    person.heartBrainM.tag = 10032;
    [self addImage:person.heartBrainHeavy];
    person.heartBrainHeavy.tag = 10033;
    
    [person.heartBrain addTarget:self action:@selector(heartBrain:) forControlEvents:UIControlEventTouchUpInside];
     [person.heartBrainSlight addTarget:self action:@selector(heartBrain:) forControlEvents:UIControlEventTouchUpInside];
     [person.heartBrainM addTarget:self action:@selector(heartBrain:) forControlEvents:UIControlEventTouchUpInside];
     [person.heartBrainHeavy addTarget:self action:@selector(heartBrain:) forControlEvents:UIControlEventTouchUpInside];
//    眼部病变
    [self addImage2:person.Eye];
    person.Eye.tag = 10040;
    [self addImage:person.eyeSlight];
    person.eyeSlight.tag = 10041;
    [self addImage:person.eyeM];
    person.eyeM.tag = 10042;
    [self addImage:person.eyeHeavy];
    person.eyeHeavy.tag = 10043;
    [person.Eye addTarget:self action:@selector(Eye:) forControlEvents:UIControlEventTouchUpInside];
    [person.eyeSlight addTarget:self action:@selector(Eye:) forControlEvents:UIControlEventTouchUpInside];
    [person.eyeM addTarget:self action:@selector(Eye:) forControlEvents:UIControlEventTouchUpInside];
    [person.eyeHeavy addTarget:self action:@selector(Eye:) forControlEvents:UIControlEventTouchUpInside];
//    神经系统病变
    [self addImage2:person.nervousSystem];
    [self addImage:person.nervousSystemSlight];
    [self addImage:person.nervousSystemM];
    [self addImage:person.nervousSystemHeavy];
     person.nervousSystem.tag = 10050;
    person.nervousSystemSlight.tag = 10051;
     person.nervousSystemM.tag = 10052;
     person.nervousSystemHeavy.tag = 10053;
    [person.nervousSystem addTarget:self action:@selector(nervousSystem:) forControlEvents:UIControlEventTouchUpInside];
    [person.nervousSystemSlight addTarget:self action:@selector(nervousSystem:) forControlEvents:UIControlEventTouchUpInside];
    [person.nervousSystemM addTarget:self action:@selector(nervousSystem:) forControlEvents:UIControlEventTouchUpInside];
    [person.nervousSystemHeavy addTarget:self action:@selector(nervousSystem:) forControlEvents:UIControlEventTouchUpInside];
//    糖尿病肾病
    [self addImage2:person.diabeticNephropathy];
    [self addImage:person.diabeticNephropathySlight];
    [self addImage:person.diabeticNephropathyM];
    [self addImage:person.diabeticNephropathyHeavy];
    person.diabeticNephropathy.tag = 10060;
    person.diabeticNephropathySlight.tag = 10061;
    person.diabeticNephropathyM.tag = 10062;
    person.diabeticNephropathyHeavy.tag = 10063;
    [person.diabeticNephropathy addTarget:self action:@selector(diabeticNephropathy:) forControlEvents:UIControlEventTouchUpInside];
    [person.diabeticNephropathySlight addTarget:self action:@selector(diabeticNephropathy:) forControlEvents:UIControlEventTouchUpInside];
    [person.diabeticNephropathyM addTarget:self action:@selector(diabeticNephropathy:) forControlEvents:UIControlEventTouchUpInside];
    [person.diabeticNephropathyHeavy addTarget:self action:@selector(diabeticNephropathy:) forControlEvents:UIControlEventTouchUpInside];
//    糖尿病足
    [self addImage2:person.DiabeticFoot];
    
    [self addImage:person.DiabeticFootSlight];
    [self addImage:person.DiabeticFootM];
    [self addImage:person.DiabeticFootHeavy];
    person.DiabeticFoot.tag = 10070;
    person.DiabeticFootSlight.tag = 10071;
    person.DiabeticFootM.tag = 10072;
    person.DiabeticFootHeavy.tag = 10073;
    [person.DiabeticFoot addTarget:self action:@selector(DiabeticFoot:) forControlEvents:UIControlEventTouchUpInside];
    [person.DiabeticFootSlight addTarget:self action:@selector(DiabeticFoot:) forControlEvents:UIControlEventTouchUpInside];
    [person.DiabeticFootM addTarget:self action:@selector(DiabeticFoot:) forControlEvents:UIControlEventTouchUpInside];
    [person.DiabeticFootHeavy addTarget:self action:@selector(DiabeticFoot:) forControlEvents:UIControlEventTouchUpInside];
//    其他
  [self addImage2:person.other];
    person.other.tag = 10080;
    [person.other addTarget:self action:@selector(other:) forControlEvents:UIControlEventTouchUpInside];
    [child1 addSubview:personScrollView];
}

//other点击事件
-(void)other:(UIButton *)sender{
    person.other.selected =! person.other.selected ;
    if ( person.other.selected == NO) {
        person.otherTF.userInteractionEnabled = NO;
    }else{
        person.otherTF.userInteractionEnabled = YES;
    }
}


//糖尿病足点击事件
-(void)DiabeticFoot:(UIButton *)sender{
    
    if(sender.tag == 10070){
        person.DiabeticFoot.selected =!person.DiabeticFoot.selected;
        if (person.DiabeticFoot.selected == NO) {
            person.DiabeticFootSlight.selected = NO;
            person.DiabeticFootM.selected = NO;
            person.DiabeticFootHeavy.selected = NO;
            
            person.DiabeticFootSlight.userInteractionEnabled = NO;
            person.DiabeticFootM.userInteractionEnabled = NO;
            person.DiabeticFootHeavy.userInteractionEnabled = NO;
        }
        
    }else if (sender.tag == 10071){
        person.DiabeticFootSlight.userInteractionEnabled = YES;
        person.DiabeticFootM.userInteractionEnabled = YES;
        person.DiabeticFootHeavy.userInteractionEnabled = YES;

        person.DiabeticFootSlight.selected = YES;
        person.DiabeticFootM.selected = NO;
        person.DiabeticFootHeavy.selected = NO;
    }else if (sender.tag == 10072){
        person.DiabeticFootSlight.userInteractionEnabled = YES;
        person.DiabeticFootM.userInteractionEnabled = YES;
        person.DiabeticFootHeavy.userInteractionEnabled = YES;
        person.DiabeticFootSlight.selected = NO;
        person.DiabeticFootM.selected = YES;
        person.DiabeticFootHeavy.selected = NO;
        
    }else if (sender.tag == 10073){
        person.DiabeticFootSlight.userInteractionEnabled = YES;
        person.DiabeticFootM.userInteractionEnabled = YES;
        person.DiabeticFootHeavy.userInteractionEnabled = YES;
        person.DiabeticFootSlight.selected = NO;
        person.DiabeticFootM.selected = NO;
        person.DiabeticFootHeavy.selected = YES;
    }
}

//糖尿病肾病点击事件
-(void)diabeticNephropathy:(UIButton *)sender{
    if(sender.tag == 10060){
        person.diabeticNephropathy.selected =!person.diabeticNephropathy.selected;
        if (person.diabeticNephropathy.selected == NO) {
            person.diabeticNephropathySlight.selected = NO;
            person.diabeticNephropathyM.selected = NO;
            person.diabeticNephropathyHeavy.selected = NO;
            
            person.diabeticNephropathySlight.userInteractionEnabled = NO;
            person.diabeticNephropathyM.userInteractionEnabled = NO;
            person.diabeticNephropathyHeavy.userInteractionEnabled = NO;
        }
        
    }else if (sender.tag == 10061){
        person.diabeticNephropathySlight.userInteractionEnabled = YES;
        person.diabeticNephropathyM.userInteractionEnabled = YES;
        person.diabeticNephropathyHeavy.userInteractionEnabled = YES;
        person.diabeticNephropathySlight.selected = YES;
        person.diabeticNephropathyM.selected = NO;
        person.diabeticNephropathyHeavy.selected = NO;
    }else if (sender.tag == 10062){
        person.diabeticNephropathySlight.userInteractionEnabled = YES;
        person.diabeticNephropathyM.userInteractionEnabled = YES;
        person.diabeticNephropathyHeavy.userInteractionEnabled = YES;
        person.diabeticNephropathySlight.selected = NO;
        person.diabeticNephropathyM.selected = YES;
        person.diabeticNephropathyHeavy.selected = NO;
        
    }else if (sender.tag == 10063){
        person.diabeticNephropathySlight.userInteractionEnabled = YES;
        person.diabeticNephropathyM.userInteractionEnabled = YES;
        person.diabeticNephropathyHeavy.userInteractionEnabled = YES;
        person.diabeticNephropathySlight.selected = NO;
        person.diabeticNephropathyM.selected = NO;
        person.diabeticNephropathyHeavy.selected = YES;
    }
}

//神经系统点击事件
-(void)nervousSystem:(UIButton * )sender{
            if(sender.tag == 10050){
        person.nervousSystem.selected =!person.nervousSystem.selected;
        if (person.nervousSystem.selected == NO) {
            person.nervousSystemSlight.selected = NO;
            person.nervousSystemM.selected = NO;
            person.nervousSystemHeavy.selected = NO;
            
            person.nervousSystemSlight.userInteractionEnabled = NO;
            person.nervousSystemM.userInteractionEnabled = NO;
            person.nervousSystemHeavy.userInteractionEnabled = NO;
            
        }
        
    }else if (sender.tag == 10051){
        person.nervousSystemSlight.userInteractionEnabled = YES;
        person.nervousSystemM.userInteractionEnabled = YES;
        person.nervousSystemHeavy.userInteractionEnabled = YES;
        person.nervousSystemSlight.selected = YES;
        person.nervousSystemM.selected = NO;
        person.nervousSystemHeavy.selected = NO;
        
    }else if (sender.tag == 10052){
        person.nervousSystemSlight.userInteractionEnabled = YES;
        person.nervousSystemM.userInteractionEnabled = YES;
        person.nervousSystemHeavy.userInteractionEnabled = YES;
        person.nervousSystemSlight.selected = NO;
        person.nervousSystemM.selected = YES;
        person.nervousSystemHeavy.selected = NO;
        
        
    }else if (sender.tag == 10053){
        person.nervousSystemSlight.userInteractionEnabled = YES;
        person.nervousSystemM.userInteractionEnabled = YES;
        person.nervousSystemHeavy.userInteractionEnabled = YES;
        person.nervousSystemSlight.selected = NO;
        person.nervousSystemM.selected = NO;
        person.nervousSystemHeavy.selected = YES;
    }
    
}
//眼部病变点击事件
-(void)Eye:(UIButton *)sender{
    if(sender.tag == 10040){
        person.Eye.selected =!person.Eye.selected;
        if (person.Eye.selected == NO) {
            person.eyeSlight.selected = NO;
            person.eyeM.selected = NO;
            person.eyeHeavy.selected = NO;
            
            person.eyeSlight.userInteractionEnabled = NO;
            person.eyeM.userInteractionEnabled = NO;
            person.eyeHeavy.userInteractionEnabled = NO;

            
        }
        
    }else if (sender.tag == 10041){
        person.eyeSlight.userInteractionEnabled = YES;
        person.eyeM.userInteractionEnabled = YES;
        person.eyeHeavy.userInteractionEnabled = YES;
        

        person.eyeSlight.selected = YES;
        person.eyeM.selected = NO;
        person.eyeHeavy.selected = NO;
        
        
    }else if (sender.tag == 10042){
        person.eyeSlight.userInteractionEnabled = YES;
        person.eyeM.userInteractionEnabled = YES;
        person.eyeHeavy.userInteractionEnabled = YES;
        person.eyeSlight.selected = NO;
        person.eyeM.selected = YES;
        person.eyeHeavy.selected = NO;
        
        
    }else if (sender.tag == 10043){
        person.eyeSlight.userInteractionEnabled = YES;
        person.eyeM.userInteractionEnabled = YES;
        person.eyeHeavy.userInteractionEnabled = YES;
        person.eyeSlight.selected = NO;
        person.eyeM.selected = NO;
        person.eyeHeavy.selected = YES;
        
    }

}
//心脑血管疾病点击事件
-(void)heartBrain:(UIButton *)sender{
  
    if(sender.tag == 10030){
        person.heartBrain.selected =!person.heartBrain.selected;
        if (person.heartBrain.selected == NO) {
            person.heartBrainSlight.selected = NO;
            person.heartBrainM.selected = NO;
            person.heartBrainHeavy.selected = NO;
            
            
            person.heartBrainSlight.userInteractionEnabled = NO;
            person.heartBrainM.userInteractionEnabled = NO;
            person.heartBrainHeavy.userInteractionEnabled = NO;
            
        }
        
    }else if (sender.tag == 10031){
        person.heartBrainSlight.userInteractionEnabled = YES;
        person.heartBrainM.userInteractionEnabled = YES;
        person.heartBrainHeavy.userInteractionEnabled = YES;

        person.heartBrainSlight.selected = YES;
        person.heartBrainM.selected = NO;
        person.heartBrainHeavy.selected = NO;

        
    }else if (sender.tag == 10032){
        person.heartBrainSlight.userInteractionEnabled = YES;
        person.heartBrainM.userInteractionEnabled = YES;
        person.heartBrainHeavy.userInteractionEnabled = YES;
        

        person.heartBrainSlight.selected = NO;
        person.heartBrainM.selected = YES;
        person.heartBrainHeavy.selected = NO;

        
    }else if (sender.tag == 10033){
        person.heartBrainSlight.userInteractionEnabled = YES;
        person.heartBrainM.userInteractionEnabled = YES;
        person.heartBrainHeavy.userInteractionEnabled = YES;
        

        person.heartBrainSlight.selected = NO;
        person.heartBrainM.selected = NO;
        person.heartBrainHeavy.selected = YES;

    }


}
//高血压点击事件
-(void)Hypertension:(UIButton *)sender{
    if(sender.tag == 10020){
        person.bothDiseaseHypertension.selected =!person.bothDiseaseHypertension.selected;
        if (person.bothDiseaseHypertension.selected == NO) {
            person.bothDiseaseHypertensionSlight.selected = NO;
            person.bothDiseaseHypertensionM.selected = NO;
            person.bothDiseaseHypertensionHeavy.selected = NO;

            person.bothDiseaseHypertensionSlight.userInteractionEnabled = NO;
            person.bothDiseaseHypertensionM.userInteractionEnabled = NO;
            person.bothDiseaseHypertensionHeavy.userInteractionEnabled = NO;

        }
        
    }else if (sender.tag == 10021){
        person.bothDiseaseHypertensionSlight.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionM.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionHeavy.userInteractionEnabled = YES;

        person.bothDiseaseHypertensionSlight.selected = YES;
        person.bothDiseaseHypertensionM.selected = NO;
        person.bothDiseaseHypertensionHeavy.selected = NO;
        
    }else if (sender.tag == 10022){
        person.bothDiseaseHypertensionSlight.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionM.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionHeavy.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionSlight.selected = NO;
        person.bothDiseaseHypertensionM.selected = YES;
        person.bothDiseaseHypertensionHeavy.selected = NO;
        
    }else if (sender.tag == 10023){
        person.bothDiseaseHypertensionSlight.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionM.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionHeavy.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionSlight.selected = NO;
        person.bothDiseaseHypertensionM.selected = NO;
        person.bothDiseaseHypertensionHeavy.selected = YES;
    }

}

//家族病史点击事件
-(void)familyHisAction:(UIButton *)sender{
    
    if (sender.tag == 10010) {
        person.diabetes.selected = !person.diabetes.selected;
    
    }else if (sender.tag == 10011){
        person.hypertension.selected = !person.hypertension.selected;

    }else if (sender.tag == 10012){
        person.Obesity.selected = !person.Obesity.selected;

    
    }else if (sender.tag == 10013){
        person.coronary_heart_disease.selected = !person.coronary_heart_disease.selected;

    }else if (sender.tag == 10014){
        person.tumour.selected = !person.tumour.selected;

    }else if (sender.tag == 10015){
        person.Cerebral_vascular_disease.selected = !person.Cerebral_vascular_disease.selected;

    
    }
}
//活动强度
-(void)ActivityIntensity:(UIButton *)sender{
    if (sender.tag == 10000) {
        person.bedridden.selected = YES;
        person.smallWork.selected = NO;
        person.middleWork.selected = NO;
        person.bigWork.selected = NO;
    }else if (sender.tag == 10001){
        person.bedridden.selected = NO;
        person.smallWork.selected = YES;
        person.middleWork.selected = NO;
        person.bigWork.selected = NO;
    
    }else if (sender.tag == 10002){
    
        person.bedridden.selected = NO;
        person.smallWork.selected = NO;
        person.middleWork.selected = YES;
        person.bigWork.selected = NO;
    }else if (sender.tag == 10003){
        person.bedridden.selected = NO;
        person.smallWork.selected = NO;
        person.middleWork.selected = NO;
        person.bigWork.selected = YES;
    }
}
//糖尿病类型
-(void)diabetesType:(UIButton *)sender{
    if (sender.tag == 10004) {
        person.highSugarPeople.selected = YES;
        person.diabetesOne.selected = NO;
        person.diabetesTwo.selected = NO;
    }else if (sender.tag == 10005){
    
        person.highSugarPeople.selected = NO;
        person.diabetesOne.selected = YES;
        person.diabetesTwo.selected = NO;
    
    }else if (sender.tag == 10006){
        person.highSugarPeople.selected = NO;
        person.diabetesOne.selected = NO;
        person.diabetesTwo.selected = YES;
    
    }
}
//无并发症
-(void)bothdiabetes:(UIButton *)sender{
    
        person.noBothDisease.selected =!person.noBothDisease.selected;
    if (person.noBothDisease.selected == YES) {
        person.bothDiseaseHypertension.selected = NO;
       
        person.bothDiseaseHypertensionSlight.selected = NO;
        person.bothDiseaseHypertensionM.selected = NO;
        person.bothDiseaseHypertensionHeavy.selected = NO;
        
        person.heartBrain.selected = NO;
        person.heartBrainSlight.selected = NO;
        person.heartBrainM.selected = NO;
        person.heartBrainHeavy.selected = NO;
        
        person.Eye.selected = NO;
        person.eyeSlight.selected = NO;
        person.eyeM.selected = NO;
        person.eyeHeavy.selected = NO;
        
        person.nervousSystem.selected = NO;
        person.nervousSystemSlight.selected = NO;
        person.nervousSystemM.selected = NO;
        person.nervousSystemHeavy.selected = NO;
        
        person.diabeticNephropathy.selected = NO;
        person.diabeticNephropathySlight.selected = NO;
        person.diabeticNephropathyM.selected = NO;
        person.diabeticNephropathyHeavy.selected = NO;
        
        person.DiabeticFoot.selected = NO;
        person.DiabeticFootSlight.selected = NO;
        person.DiabeticFootM.selected = NO;
        person.DiabeticFootHeavy.selected = NO;
        
        person.other.selected = NO;
        person.otherTF.userInteractionEnabled = NO;
        
        person.bothDiseaseHypertension.userInteractionEnabled = NO;
        
        person.bothDiseaseHypertensionSlight.userInteractionEnabled = NO;
        person.bothDiseaseHypertensionM.userInteractionEnabled = NO;
        person.bothDiseaseHypertensionHeavy.userInteractionEnabled = NO;
        person.heartBrain.userInteractionEnabled = NO;
        person.heartBrainSlight.userInteractionEnabled = NO;
        person.heartBrainM.userInteractionEnabled = NO;
        person.heartBrainHeavy.userInteractionEnabled = NO;
        
        person.Eye.userInteractionEnabled = NO;
        person.eyeSlight.userInteractionEnabled = NO;
        person.eyeM.userInteractionEnabled = NO;
        person.eyeHeavy.userInteractionEnabled = NO;
        
        person.nervousSystem.userInteractionEnabled = NO;
        person.nervousSystemSlight.userInteractionEnabled = NO;
        person.nervousSystemM.userInteractionEnabled = NO;
        person.nervousSystemHeavy.userInteractionEnabled = NO;
        person.diabeticNephropathy.userInteractionEnabled = NO;
        person.diabeticNephropathySlight.userInteractionEnabled = NO;
        person.diabeticNephropathyM.userInteractionEnabled = NO;
        person.diabeticNephropathyHeavy.userInteractionEnabled = NO;
        
        person.DiabeticFoot.userInteractionEnabled = NO;
        person.DiabeticFootSlight.userInteractionEnabled = NO;
        person.DiabeticFootM.userInteractionEnabled = NO;
        person.DiabeticFootHeavy.userInteractionEnabled = NO;
        
        person.other.userInteractionEnabled = NO;
        person.otherTF.userInteractionEnabled = NO;
         person.bothDiseaseHypertension.userInteractionEnabled = NO;
    }else {
        person.bothDiseaseHypertension.userInteractionEnabled = YES;
        
        person.bothDiseaseHypertensionSlight.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionM.userInteractionEnabled = YES;
        person.bothDiseaseHypertensionHeavy.userInteractionEnabled = YES;
        person.heartBrain.userInteractionEnabled = YES;
        person.heartBrainSlight.userInteractionEnabled = YES;
        person.heartBrainM.userInteractionEnabled = YES;
        person.heartBrainHeavy.userInteractionEnabled = YES;
        
        person.Eye.userInteractionEnabled = YES;
        person.eyeSlight.userInteractionEnabled = YES;
        person.eyeM.userInteractionEnabled = YES;
        person.eyeHeavy.userInteractionEnabled = YES;
        
        person.nervousSystem.userInteractionEnabled = YES;
        person.nervousSystemSlight.userInteractionEnabled = YES;
        person.nervousSystemM.userInteractionEnabled = YES;
        person.nervousSystemHeavy.userInteractionEnabled = YES;
        person.diabeticNephropathy.userInteractionEnabled = YES;
        person.diabeticNephropathySlight.userInteractionEnabled = YES;
        person.diabeticNephropathyM.userInteractionEnabled = YES;
        person.diabeticNephropathyHeavy.userInteractionEnabled = YES;
        
        person.DiabeticFoot.userInteractionEnabled = YES;
        person.DiabeticFootSlight.userInteractionEnabled = YES;
        person.DiabeticFootM.userInteractionEnabled = YES;
        person.DiabeticFootHeavy.userInteractionEnabled = YES;
        
        person.other.userInteractionEnabled = YES;
        person.otherTF.userInteractionEnabled = YES;
    }

}
-(void)addImage:(UIButton *)btn{
    [ btn setImage:[UIImage imageNamed:@"point"] forState:UIControlStateNormal];
    [ btn setImage:[UIImage imageNamed:@"point_select"] forState:UIControlStateSelected];
}
-(void)addImage2:(UIButton *)btn{
    [ btn setImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
    [ btn setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateSelected];
}
-(void)manBtnClick
{
    person.SexManBtn.selected = YES;
    person.SexWomanBtn.selected = NO;
}
-(void)womanBtnClick
{
    
    person.SexManBtn.selected = NO;
    person.SexWomanBtn.selected = YES;
}

#pragma mark -- 读取个人信息数据
-(void)readinfo{
    user = [NSUserDefaults standardUserDefaults];
    NSString * name = [user objectForKey:USER_ID];
    
   _infoModel = [FileUtils readUserInfo:name];
//数据处理
    [self handleData];

}
#pragma mark -- 处理数据类
-(void)handleData{
    person.nameTF.text = _infoModel.Name;
    person.nickNameTF.text = _infoModel.NickName;
    person.pinyinTF.text = _infoModel.Pinyin;
    person.emailTF.text = _infoModel.Email;
    person.telrphoneTF.text = _infoModel.Tel;
    if ([_infoModel.Sex isEqualToString:@"1"]) {
        person.SexManBtn.selected = YES;
        person.SexWomanBtn.selected = NO;
    }else{
        person.SexManBtn.selected =  NO;
        person.SexWomanBtn.selected = YES;
    }
    person.birthdayLable.text = _infoModel.Birthday;
    person.heightTF.text = _infoModel.Height;
    person.weightTF.text = _infoModel.Weight;
    person.RestHrTF.text = _infoModel.RestHr;
    if ([_infoModel.ExIntensity isEqualToString:@"0"]) {
        person.bedridden.selected = YES;
        person.smallWork.selected = NO;
        person.middleWork.selected = NO;
        person.bigWork.selected = NO;
    }else if (([_infoModel.ExIntensity isEqualToString:@"1"])){
        person.bedridden.selected = NO;
        person.smallWork.selected = YES;
        person.middleWork.selected = NO;
        person.bigWork.selected = NO;
    }else if (([_infoModel.ExIntensity isEqualToString:@"2"])){
        person.bedridden.selected = NO;
        person.smallWork.selected = NO;
        person.middleWork.selected = YES;
        person.bigWork.selected = NO;
    }else if (([_infoModel.ExIntensity isEqualToString:@"3"])){
        person.bedridden.selected = NO;
        person.smallWork.selected = NO;
        person.middleWork.selected = NO;
        person.bigWork.selected = YES;
    
    }

    if([_infoModel.DiabetesType isEqualToString:@"0"]){
        person.highSugarPeople.selected = YES;
        person.diabetesOne.selected = NO;
        person.diabetesTwo.selected = NO;
    
    }else if ([_infoModel.DiabetesType isEqualToString:@"1"]){
        person.highSugarPeople.selected = NO;
        person.diabetesOne.selected = YES;
        person.diabetesTwo.selected = NO;
        
    }else if ([_infoModel.DiabetesType isEqualToString:@"2"]){
    
        person.highSugarPeople.selected = NO;
        person.diabetesOne.selected = NO;
        person.diabetesTwo.selected = YES;
    }
    NSArray * FamilyHis = [_infoModel.FamilyHis componentsSeparatedByString:@","];
    for (NSString * str  in FamilyHis) {
        if ([str isEqualToString:@"01"]) {
             person.diabetes.selected = YES;
        }
        if ([str isEqualToString:@"02"]) {
            person.hypertension.selected = YES;
        }
        if ([str isEqualToString:@"03"]) {
            person.Obesity.selected = YES;
        }
        if ([str isEqualToString:@"04"]) {
            person.coronary_heart_disease.selected = YES;
        }
        if ([str isEqualToString:@"05"]) {
            person.tumour.selected = YES;
        }
        if ([str isEqualToString:@"06"]) {
            person.Cerebral_vascular_disease.selected = YES;
        }
        
    }

    if (![_infoModel.Complication isEqualToString: @""]) {
        NSString *BothDiseaseStr = _infoModel.Complication;
        NSArray *noBothDiseaseArray = [BothDiseaseStr componentsSeparatedByString:@":"];
        
               if ([noBothDiseaseArray[0] isEqualToString:@"0"]) {
            person.noBothDisease.selected = YES;
            person.bothDiseaseHypertension.selected = NO;
            person.bothDiseaseHypertensionSlight.selected = NO;
            person.bothDiseaseHypertensionM.selected = NO;
            person.bothDiseaseHypertensionHeavy.selected = NO;
            person.heartBrain.selected = NO;
            person.heartBrainSlight.selected = NO;
            person.heartBrainM.selected = NO;
            person.heartBrainHeavy.selected = NO;
            person.Eye.selected = NO;
            person.eyeSlight.selected = NO;
            person.eyeM.selected = NO;
            person.eyeHeavy.selected = NO;
            person.nervousSystem.selected = NO;
            person.nervousSystemSlight.selected = NO;
            person.nervousSystemM.selected = NO;
            person.nervousSystemHeavy.selected = NO;
            person.diabeticNephropathy.selected = NO;
            person.diabeticNephropathySlight.selected = NO;
            person.diabeticNephropathyM.selected = NO;
            person.diabeticNephropathyHeavy.selected = NO;
            person.DiabeticFoot.selected = NO;
            person.DiabeticFootSlight.selected = NO;
            person.DiabeticFootM.selected = NO;
            person.DiabeticFootHeavy.selected = NO;
            person.other.selected = NO;
            
            
        }else{
            NSMutableArray * noBothDiseasenNum = [self judgementWhichDiseaseUseModel_Complication:noBothDiseaseArray[0]];
            NSLog(@"%@",noBothDiseasenNum);
            //    noBothDisease;//无并发症//   bothDiseaseHypertension;//并发症高血压//  bothDiseaseHypertensionSlight;//并发症高血压轻微//    bothDiseaseHypertensionM;//并发症高血压中度//    bothDiseaseHypertensionHeavy;//并发症高血压重度//
            
//            int tempNum = [noBothDiseaseArray[1]intValue];
            NSString * tempNum =noBothDiseaseArray[1];
            
            
            for (int i = 0;i<noBothDiseasenNum.count; i++) {
                if ([[noBothDiseasenNum[i]stringValue] isEqualToString:@"1"]) {
                    person.bothDiseaseHypertension.selected = YES;
                    if ([[tempNum substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]) {
                        person.bothDiseaseHypertensionSlight.selected = YES;
                        person.bothDiseaseHypertensionM.selected = NO;
                        person.bothDiseaseHypertensionHeavy.selected = NO;
                        
                    }else if ([[tempNum substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"2"])
                    {
                        person.bothDiseaseHypertensionSlight.selected =NO ;
                        person.bothDiseaseHypertensionM.selected = YES;
                        person.bothDiseaseHypertensionHeavy.selected = NO;
                        
                        
                    }else if ([[tempNum substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"3"]){
                        person.bothDiseaseHypertensionSlight.selected =NO ;
                        person.bothDiseaseHypertensionM.selected = NO;
                        person.bothDiseaseHypertensionHeavy.selected = YES;
                        
                    }
                    
                }
                if ([[noBothDiseasenNum[i]stringValue] isEqualToString:@"2"]) {
                    person.heartBrain.selected = YES;
                    //        heartBrain;//心脑血管病变//    heartBrainSlight;//心脑血管病变轻微//    heartBrainM;//心脑血管病变中度//    heartBrainHeavy;//心脑血管病变中毒//
                    if ([[tempNum substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"]) {
                        
                        person.heartBrainSlight.selected = YES;
                        person.heartBrainM.selected = NO;
                        person.heartBrainHeavy.selected = NO;
                        
                    }else if ([[tempNum substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"2"])
                    {
                        person.heartBrainSlight.selected = NO;
                        person.heartBrainM.selected = YES;
                        person.heartBrainHeavy.selected = NO;
                        
                        
                        
                    }else if ([[tempNum substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"3"]){
                        person.heartBrainSlight.selected = NO;
                        person.heartBrainM.selected = NO;
                        person.heartBrainHeavy.selected = YES;
                        
                    }
                    
                }
                if ([[noBothDiseasenNum[i]stringValue] isEqualToString:@"4"]) {
                    person.Eye.selected = YES;
                    //                Eye;//眼部病变//eyeSlight;//眼部病变轻微//    eyeM;//眼部病变中度//    eyeHeavy;//眼部病变重度//
                    if ([[tempNum substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"1"]) {
                        
                        person.eyeSlight.selected = YES;
                        person.eyeM.selected = NO;
                        person.eyeHeavy.selected = NO;
                        
                    }else if ([[tempNum substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"2"])
                    {
                        person.eyeSlight.selected = NO;
                        person.eyeM.selected = YES;
                        person.eyeHeavy.selected = NO;
                        
                        
                    }else if ([[tempNum substringWithRange:NSMakeRange(2, 1)] isEqualToString:@"3"]){
                        person.eyeSlight.selected = NO;
                        person.eyeM.selected = NO;
                        person.eyeHeavy.selected = YES;
                    }
                    
                }
                if ([[noBothDiseasenNum[i]stringValue] isEqualToString:@"8"]) {
                    //                nervousSystem;//神经系统病变//    nervousSystemSlight;//神经系统病变轻微//   nervousSystemM;//神经系统病变中度//    nervousSystemHeavy;//神经系统病变重度
                    person.nervousSystem.selected = YES;
                    if ([[tempNum substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"1"]) {
                        person.nervousSystemSlight.selected = YES;
                        person.nervousSystemM.selected = NO;
                        person.nervousSystemHeavy.selected = NO;
                    }else if ([[tempNum substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"2"]){
                        person.nervousSystemSlight.selected = NO;
                        person.nervousSystemM.selected = YES;
                        person.nervousSystemHeavy.selected = NO;
                    }else if ([[tempNum substringWithRange:NSMakeRange(3, 1)] isEqualToString:@"3"]){
                        person.nervousSystemSlight.selected = NO;
                        person.nervousSystemM.selected = NO;
                        person.nervousSystemHeavy.selected = YES;
                    }
                }
                if ([[noBothDiseasenNum[i]stringValue] isEqualToString:@"16"]) {
                    person.diabeticNephropathy.selected = YES;
                    //    diabeticNephropathy;//糖尿病肾病//   diabeticNephropathySlight;//糖尿病肾病轻度//    diabeticNephropathyM;//糖尿病肾病中度//  diabeticNephropathyHeavy;//糖尿病肾病重度
                    if ([[tempNum substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"]) {
                        person.diabeticNephropathySlight.selected = YES;
                        person.diabeticNephropathyM.selected = NO;
                        person.diabeticNephropathyHeavy.selected = NO;
                    }else if ([[tempNum substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"2"]){
                        
                        person.diabeticNephropathySlight.selected = NO;
                        person.diabeticNephropathyM.selected = YES;
                        person.diabeticNephropathyHeavy.selected = NO;
                    }else if ([[tempNum substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"3"]){
                        person.diabeticNephropathySlight.selected = NO;
                        person.diabeticNephropathyM.selected = NO;
                        person.diabeticNephropathyHeavy.selected = YES;
                    }
                }
                if ([[noBothDiseasenNum[i]stringValue] isEqualToString:@"32"]) {
                    // DiabeticFoot;//糖尿病足//  DiabeticFootSlight;//糖尿病足轻微//  DiabeticFootM;//糖尿病足中度//  DiabeticFootHeavy;//糖尿病足重度//  other;//其他
                    person.DiabeticFoot.selected = YES;
                    if ([[tempNum substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"1"]) {
                        
                        person.DiabeticFootSlight.selected = YES;
                        person.DiabeticFootM.selected = NO;
                        person.DiabeticFootHeavy.selected = NO;
                    }else if ([[tempNum substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"2"]){
                        person.DiabeticFootSlight.selected = NO;
                        person.DiabeticFootM.selected = YES;
                        person.DiabeticFootHeavy.selected = NO;
                    }else if ([[tempNum substringWithRange:NSMakeRange(5, 1)] isEqualToString:@"3"]){
                        person.DiabeticFootSlight.selected = NO;
                        person.DiabeticFootM.selected = NO;
                        person.DiabeticFootHeavy.selected = YES;
                   }
                    
                }
            }
            if(![noBothDiseaseArray[2] isEqualToString:@""])
                person.other.selected = YES;
            person.otherTF.text =noBothDiseaseArray[2];
        }
    }
    
    person.clinicalDiagnosisTV.text = _infoModel.CliDiagnosis;
    
}
#pragma mark -- 时间选择器相关
-(void)createChooseTime:(UITapGestureRecognizer *)sender{
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    rect = CGRectMake(0.0, 64.0, rect.size.width, 216.0);
    // 时分
    KMDatePicker * datePicker = [[KMDatePicker alloc]
                                 initWithFrame:rect
                                 delegate:self
                                 datePickerStyle:KMDatePickerStyleYearMonthDay];
    [self.view addSubview:datePicker];
    
}

#pragma mark - KMDatePickerDelegate
- (void)datePicker:(KMDatePicker *)datePicker didSelectDate:(KMDatePickerDateModel *)datePickerDate {
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@",
                         datePickerDate.year,
                         datePickerDate.month,datePickerDate.day
                         ];
    [datePicker removeFromSuperview];
    person.birthdayLable.text = dateStr;
}

//判断是否是字符串中的一条
-(NSMutableArray *)judgementWhichDiseaseUseModel_Complication:(NSString *)str{
    long strnum = strtoul([str UTF8String], 0, 16);
    NSMutableArray * marray = [NSMutableArray array];
    int num[] = {1,2,4,8,16,32};
    for (int a = 0; a < 6; a ++) {
        if((strnum&num[a]) == num[a]){
            NSNumber *  n = [NSNumber numberWithInt:num[a]];
            
            [marray addObject:n];
        }
    }
    return marray;
}
// 十六进制转换为普通字符串的。
-(NSString *)stringFromHexString:(NSString *)hexString { //
    
    char *myBuffer = (char *)malloc((int)[hexString length] / 2 + 1);
    bzero(myBuffer, [hexString length] / 2 + 1);
    for (int i = 0; i < [hexString length] - 1; i += 2) {
        unsigned int anInt;
        NSString * hexCharStr = [hexString substringWithRange:NSMakeRange(i, 2)];
        NSScanner * scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        myBuffer[i / 2] = (char)anInt;
    }
    NSString *unicodeString = [NSString stringWithCString:myBuffer encoding:4];
    return unicodeString;
}
-(NSString *)ToHex:( long int)tmpid
{
    NSString *nLetterValue;
    NSString *str =@"";
    long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig)
        {
            case 10:
                nLetterValue =@"a";break;
            case 11:
                nLetterValue =@"b";break;
            case 12:
                nLetterValue =@"c";break;
            case 13:
                nLetterValue =@"d";break;
            case 14:
                nLetterValue =@"e";break;
            case 15:
                nLetterValue =@"f";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%li",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}
#pragma mark ScrollViewDelegate

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
