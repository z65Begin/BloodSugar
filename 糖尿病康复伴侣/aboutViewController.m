//
//  aboutViewController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/15.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "aboutViewController.h"

@interface aboutViewController ()

@end

@implementation aboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self createUI];
    
}
-(void)createNav{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;

    self.navigationItem.title =@"关于";
}
-(void)createUI{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = CGRectMake(0, 0, W, H-64);
    scrollView.contentSize = CGSizeMake(0, H);
    [self.view addSubview:scrollView];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, H - 64)];
    [scrollView addSubview:view];
    
    UIImage * image = [UIImage imageNamed:@"logo72_72"];
    
    UIImageView * imageView  = [[UIImageView alloc]initWithImage:image];
    
    imageView.frame = CGRectMake(W/3,20, W/3, W/3);
    imageView.center = CGPointMake(W/2, 44+W/10);
    [view addSubview:imageView];

    UILabel * versionLable = [[UILabel alloc]init];
    versionLable.text = @"V1.0";
    versionLable.textAlignment =NSTextAlignmentCenter;
    [view addSubview:versionLable];
    [versionLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.left.equalTo(imageView.mas_left).offset(0);
        make.right.equalTo(imageView.mas_right).offset(0);
    }];

    UILabel * sourceLable = [[UILabel alloc]init];
    sourceLable.text = @"糖尿病康复伴侣，由北京日历北工大信息系统有限公司（简称HBIS）研究并开发。它从饮食到运动两方面，全面支援糖尿病患者的“抗糖”生活，我们不仅为您配备了丰富全面的糖尿病人专属食谱和海量的食物库，还会随时记录您的运动情况；与此同时，系统后台还有专门的糖尿病医生，分析您的病情，为你提供健康建议。希望通过我们的系统，让您的糖尿病永远被控制在“前期的阶段”。";
    sourceLable.numberOfLines = 0;
    
    [view addSubview:sourceLable];
    
    [sourceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(versionLable.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
    }];
}
//返回首页
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
