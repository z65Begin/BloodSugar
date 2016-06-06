//
//  changePasswordViewController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/15.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "changePasswordViewController.h"

@interface changePasswordViewController ()<UITextFieldDelegate>

@end

@implementation changePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self createUI];
}
-(void)createNav{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.title =@"修改密码";
}

-(void)createUI{
    NSArray * placeHolderArray = @[@"原密码",@"新密码",@"重复密码"];
    for (int i = 0; i < 3; i ++) {
        UITextField * tf = [[UITextField alloc]initWithFrame:CGRectMake(5, 0+i*45+5, W-10, 35)];
        tf.layer.cornerRadius = 4;
        tf.layer.masksToBounds = YES;
        tf.tag = 30+i;
        tf.secureTextEntry = YES;
        tf.layer.borderColor = [[UIColor colorWithRed:37/255.0 green:122/255.0 blue:247/255.0 alpha:1.0]CGColor];
        tf.layer.borderWidth = 1.0;
        tf.keyboardType = UIKeyboardTypeDefault;
        tf.placeholder = placeHolderArray[i];
        [self.view addSubview:tf];
        
        
    }
    UIButton * makeSureBtn = [[UIButton alloc]init];
    [makeSureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [makeSureBtn addTarget:self action:@selector(makeSure:) forControlEvents:UIControlEventTouchUpInside];
    makeSureBtn.backgroundColor = [UIColor colorWithRed:37/255.0 green:122/255.0 blue:247/255.0 alpha:1.0];
    makeSureBtn.layer.cornerRadius = 4;
    makeSureBtn.layer.masksToBounds =YES;
    [self.view addSubview:makeSureBtn];
    UITextField * tf = [self.view viewWithTag:32];
    [makeSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.top.equalTo(tf.mas_bottom).offset(10);
    }];
    UIButton * reset = [[UIButton alloc]init];
    [reset setTitle:@"重置" forState:UIControlStateNormal];
    [reset addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
    reset.backgroundColor = [UIColor colorWithRed:37/255.0 green:122/255.0 blue:247/255.0 alpha:1.0];
    reset.layer.cornerRadius = 4;
    reset.layer.masksToBounds =YES;
    [self.view addSubview:reset];
    
    [reset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(5);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.top.equalTo(makeSureBtn.mas_bottom).offset(10);
    }];
    
}

-(void)makeSure:(UIButton * )btn{
    UITextField * tf1 = [self.view viewWithTag:30];
    UITextField * tf2 = [self.view viewWithTag:31];
    UITextField * tf3 = [self.view viewWithTag:32];
    //确定，上传更改后的密码
    if(tf1.text.length == 0 || tf2.text.length == 0 || tf3.text.length == 0){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入原始密码及新密码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if(tf1.text.length<6||tf1.text.length>20){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"原密码长度有误，请从新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else  if(tf2.text.length<6||tf2.text.length>20){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"新密码长度有误，请从新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    else if(tf3.text.length<6||tf3.text.length>20){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"新密码长度有误，请从新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
        
    }
    else if(!(tf2.text == tf3.text)){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"新密码不一致，请从新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        //上传 新密码
        //检测站点是否可以连接
        NSString *remoteHostName = WEN_SERVER_IP;
        self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
        
        [self.hostReachability startNotifier];
        
        BOOL isConnected =[UtilCommon isConnected:self.hostReachability];
        
        if(isConnected){
            
            NSString *base64Str = [Base64codeFunc  base64StringFromText:tf2.text  withKey:@"healthdi"];
            NSString *newPwd = @"";
            for(int i = 0; i<base64Str.length; i++){
                //转化为ASCII转码
                NSString *str = [[NSString alloc] initWithFormat:@"%1x",[base64Str characterAtIndex:i]];
                //小写转化大写，拼接字符串
                newPwd = [newPwd stringByAppendingString: [str uppercaseString] ];
            }
            
            //    上传数据
            NSString * OldPwd = [UtilCommon encrytoMd5:tf1.text];
            
            NSString * userId = [SingleManager sharedSingleManager].InfoModel.UID;
            //        NSLog(@"%@userId",userId);
            if ([WebUtilsCommon modifyPwd:userId andOldPwd:OldPwd andNewPwd:newPwd]) {
                [self alertView:nil andMessage:@"密码修改成功"];
            }else{
                [self alertView:nil andMessage:@"密码修改失败"];
            }
        }else{
            [self alertView:nil andMessage:@"两次填写的密码不一致"];
        }
    }
}
//弹出框
-(void)alertView:(NSString *)title andMessage:(NSString *)message{
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
-(void)resetAction{
    //重置输入
    UITextField * tf1 = [self.view viewWithTag:30];
    UITextField * tf2 = [self.view viewWithTag:31];
    UITextField * tf3 = [self.view viewWithTag:32];
    tf1.text = @"";
    tf2.text = @"";
    tf3.text = @"";
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    UITextField * tf1 = [self.view viewWithTag:30];
    UITextField * tf2 = [self.view viewWithTag:31];
    UITextField * tf3 = [self.view viewWithTag:32];
    
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [tf3 resignFirstResponder];
    for (UIView * textField in self.view.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            [textField resignFirstResponder];
        }
    }
    
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//返回首页
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc{
    NSLog(@"%s",__func__);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITextField * tf1 = [self.view viewWithTag:30];
    UITextField * tf2 = [self.view viewWithTag:31];
    UITextField * tf3 = [self.view viewWithTag:32];
    [tf1 resignFirstResponder];
    [tf2 resignFirstResponder];
    [tf3 resignFirstResponder];
    
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
