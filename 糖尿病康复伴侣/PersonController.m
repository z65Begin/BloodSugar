//
//  personController.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/19.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "PersonController.h"
#import "PersonView.h"
#import "personInfomationViewController.h"
#import "changePasswordViewController.h"
#import "SetViewController.h"
#import "aboutViewController.h"
#import "UserInfoModel.h"
@interface PersonController ()
@property(nonatomic,strong)PersonView * personView;

@end

@implementation PersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人中心";
    //创建personView
    [self createPersonView];

}
///个人信息
-(void)JumpToPersonPageAction{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    personInfomationViewController * info = [[personInfomationViewController alloc]init];
    [self.navigationController pushViewController:info animated:YES];

}
///修改密码
-(void)changePasswordAction{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    changePasswordViewController * changePassword = [[changePasswordViewController alloc]init];
    [self.navigationController pushViewController:changePassword animated:YES];
}
///设置
-(void)setAction{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    SetViewController * set = [[SetViewController alloc]init];
    [self.navigationController pushViewController:set animated:YES];
}
///关于
-(void)aboutAction{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    aboutViewController * about = [[aboutViewController alloc]init];
    [self.navigationController pushViewController:about animated:YES];
}
-(void)exitAction{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认是否退出" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.delegate = self;
    alert.alertViewStyle  =UIAlertViewStyleDefault;
    [alert show];
}
-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

//创建personView
-(void)createPersonView
{
    PersonView * personView = [PersonView PersonView];
    [self.view addSubview:personView];
    personView.frame = CGRectMake(0, 0, W, H);
    UserInfoModel * model = [FileUtils readUserInfo:self.userid];
    personView.name.text =model.Name;
    personView.uid.text = model.UID;
    [personView.personInfo addTarget:self action:@selector(JumpToPersonPageAction) forControlEvents:UIControlEventTouchUpInside];
    [personView.changePassword addTarget:self action:@selector(changePasswordAction) forControlEvents:UIControlEventTouchUpInside];
    [personView.set addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    [personView.about addTarget:self action:@selector(aboutAction) forControlEvents:UIControlEventTouchUpInside];
    [personView.exit addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
    
}



@end
