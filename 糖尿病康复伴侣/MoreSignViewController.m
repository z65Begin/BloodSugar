//
//  MoreSignViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MoreSignViewController.h"

#import "MoreSignVIew.h"

#import "BodySignModel.h"

@interface MoreSignViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) MoreSignVIew * moreSign;

@property (nonatomic, strong) BodySignModel* bodySignModel;

@end

@implementation MoreSignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigation];
    [self backgrundScrollView];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    BodySignModel* model = [FileUtils readBodySignWithUID:self.userId withDate:self.date];
    self.bodySignModel = model;
    //    for (BodySignModel * model in array) {
//        if ([model.date isEqualToString:@"2016-04-26"]) {
//            self.bodySignModel = model;
//            break;
//        }
//    }
    if (self.bodySignModel.Temperature && ![self.bodySignModel.Temperature isEqualToString:@"0"]  ) {
        self.moreSign.temperatureTF.text = self.bodySignModel.Temperature;
    }
    if (self.bodySignModel.BlipidChol &&![self.bodySignModel.BlipidChol isEqualToString:@"0"]) {
        self.moreSign.blood1TF.text = self.bodySignModel.BlipidChol;
    }
    if (self.bodySignModel.BlipidTG &&![self.bodySignModel.BlipidTG isEqualToString:@"0"]) {
        self.moreSign.blood2TF.text = self.bodySignModel.BlipidTG;
    }
    if (self.bodySignModel.BlipidHDLIP &&![self.bodySignModel.BlipidHDLIP isEqualToString:@"0"]) {
        self.moreSign.blood3TF.text = self.bodySignModel.BlipidHDLIP;
    }
    if (self.bodySignModel.BlipidLDLIP &&![self.bodySignModel.BlipidLDLIP isEqualToString:@"0"]) {
        self.moreSign.blood4TF.text = self.bodySignModel.BlipidLDLIP;
    }
    if (self.bodySignModel.GlyHemoglobin &&![self.bodySignModel.GlyHemoglobin isEqualToString:@"0"]) {
        self.moreSign.Synthesis1TF.text = self.bodySignModel.GlyHemoglobin;
    }
    if (self.bodySignModel.TotalBilirubin &&![self.bodySignModel.TotalBilirubin isEqualToString:@"0"]) {
        self.moreSign.Synthesis2TF.text = self.bodySignModel.TotalBilirubin;
    }
    if (self.bodySignModel.DirectBilirubin &&![self.bodySignModel.DirectBilirubin isEqualToString:@"0"]) {
        self.moreSign.Synthesis3TF.text = self.bodySignModel.DirectBilirubin;
    }
    if (self.bodySignModel.SerumCreatinine &&![self.bodySignModel.SerumCreatinine isEqualToString:@"0"]) {
        self.moreSign.Synthesis4TF.text = self.bodySignModel.SerumCreatinine;
    }
    if (self.bodySignModel.UricAcid &&![self.bodySignModel.UricAcid isEqualToString:@"0"]) {
        self.moreSign.Synthesis5TF.text = self.bodySignModel.UricAcid;
    }
    if (self.bodySignModel.MiAlbuminuria &&![self.bodySignModel.MiAlbuminuria isEqualToString:@"0"]) {
        self.moreSign.Synthesis6TF.text = self.bodySignModel.MiAlbuminuria;
    }
    if (self.bodySignModel.Fundus && ![self.bodySignModel.Fundus isEqualToString:@"0"]) {
        if ([self.bodySignModel.Fundus isEqualToString:@"1"]) {
            self.moreSign.ear1Btn.selected = YES;
        }
        if ([self.bodySignModel.Fundus isEqualToString:@"2"]) {
            self.moreSign.ear2Btn.selected = YES;
        }
        if ([self.bodySignModel.Fundus isEqualToString:@"3"]) {
            self.moreSign.ear3Btn.selected = YES;
        }
        if ([self.bodySignModel.Fundus isEqualToString:@"4"]) {
            self.moreSign.ear4Btn.selected = YES;
        }
        if ([self.bodySignModel.Fundus isEqualToString:@"5"]) {
            self.moreSign.ear5Btn.selected = YES;
        }
        if ([self.bodySignModel.Fundus isEqualToString:@"6"]) {
            self.moreSign.ear6Btn.selected = YES;
        }
       
    }
    if (self.bodySignModel.Plantar &&![self.bodySignModel.Plantar isEqualToString:@"0"]) {
        if ([self.bodySignModel.Plantar isEqualToString:@"1"]) {
            self.moreSign.footer1Btn.selected = YES;
        }
        if ([self.bodySignModel.Plantar isEqualToString:@"2"]) {
            self.moreSign.footer2Btn.selected = YES;
        }
        if ([self.bodySignModel.Plantar isEqualToString:@"4"]) {
            self.moreSign.footer3Btn.selected = YES;
        }
        if ([self.bodySignModel.Plantar isEqualToString:@"3"]) {
            self.moreSign.footer1Btn.selected = YES;
            self.moreSign.footer2Btn.selected = YES;
        }
        if ([self.bodySignModel.Plantar isEqualToString:@"5"]) {
            self.moreSign.footer1Btn.selected = YES;
            self.moreSign.footer3Btn.selected = YES;
        }
        if ([self.bodySignModel.Plantar isEqualToString:@"6"]) {
            self.moreSign.footer2Btn.selected = YES;
            self.moreSign.footer3Btn.selected = YES;
        }
        if ([self.bodySignModel.Plantar isEqualToString:@"7"]) {
            self.moreSign.footer1Btn.selected = YES;
            self.moreSign.footer2Btn.selected = YES;
            self.moreSign.footer3Btn.selected = YES;
        }
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backgrundScrollView{
    CGRect frame = [UIScreen mainScreen].bounds;
    
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:frame];
    
    scrollView.contentSize = CGSizeMake(0, 784);
    
    MoreSignVIew * view = [MoreSignVIew viewWithXIB];

    [scrollView addSubview:view];
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    self.moreSign = view;
}
#pragma mark  保存
- (void)saveBtn:(UIButton *)sender{
    BodySignModel * model = [[BodySignModel alloc]init];
    model.date = self.date;
    model.UpdTime = [FileUtils getNowUpdTime];
    if (![self.moreSign.temperatureTF.text isEqualToString:@""]) {
        model.Temperature = self.moreSign.temperatureTF.text;
    }else{
        model.Temperature = @"0";
    }
    if (![self.moreSign.blood1TF.text isEqualToString:@""]) {
        model.BlipidChol = self.moreSign.blood1TF.text;
    }else{
        model.BlipidChol = @"0";
    }
    if (![self.moreSign.blood3TF.text isEqualToString:@""]) {
        model.BlipidHDLIP = self.moreSign.blood3TF.text;
    }else{
        model.BlipidHDLIP = @"0";
    }
    if (![self.moreSign.blood2TF.text isEqualToString:@""]) {
        model.BlipidTG = self.moreSign.blood2TF.text;
    }else{
        model.BlipidTG = @"0";
    }
    if (![self.moreSign.blood4TF.text isEqualToString:@""]) {
        model.BlipidLDLIP = self.moreSign.blood4TF.text;
    }else{
        model.BlipidLDLIP = @"0";
    }
    if (![self.moreSign.Synthesis1TF.text isEqualToString:@""]) {
        model.GlyHemoglobin = self.moreSign.Synthesis1TF.text;
    }else{
        model.GlyHemoglobin = @"0";
    }
    if (![self.moreSign.Synthesis2TF.text isEqualToString:@""]) {
        model.TotalBilirubin = self.moreSign.Synthesis2TF.text;
    }else{
        model.TotalBilirubin = @"0";
    }
    if (![self.moreSign.Synthesis3TF.text isEqualToString:@""]) {
        model.DirectBilirubin = self.moreSign.Synthesis3TF.text;
    }else{
        model.DirectBilirubin = @"0";
    }
    if (![self.moreSign.Synthesis4TF.text isEqualToString:@""]) {
        model.SerumCreatinine = self.moreSign.Synthesis4TF.text;
    }else{
        model.SerumCreatinine = @"0";
    }
    if (![self.moreSign.Synthesis5TF.text isEqualToString:@""]) {
        model.UricAcid = self.moreSign.Synthesis5TF.text;
    }else{
        model.UricAcid = @"0";
    }
    if (![self.moreSign.Synthesis6TF.text isEqualToString:@""]) {
        model.MiAlbuminuria = self.moreSign.Synthesis6TF.text;
    }else{
        model.MiAlbuminuria = @"0";
    }
//    model.BlipidLDLIP = self.moreSign.blood4TF.text;
//    model.GlyHemoglobin = self.moreSign.Synthesis1TF.text;
//    model.TotalBilirubin = self.moreSign.Synthesis2TF.text;
//    model.DirectBilirubin = self.moreSign.Synthesis3TF.text;
//    model.SerumCreatinine = self.moreSign.Synthesis4TF.text;
//    model.UricAcid = self.moreSign.Synthesis5TF.text;
//    model.MiAlbuminuria = self.moreSign.Synthesis6TF.text;
    if (self.moreSign.ear1Btn.selected) {
        model.Fundus = @"1";
    }else if (self.moreSign.ear2Btn.selected) {
        model.Fundus = @"2";
    }else if (self.moreSign.ear3Btn.selected) {
        model.Fundus = @"3";
    }else if (self.moreSign.ear4Btn.selected) {
        model.Fundus = @"4";
    }else if (self.moreSign.ear5Btn.selected) {
        model.Fundus = @"5";
    }else if (self.moreSign.ear6Btn.selected) {
        model.Fundus = @"6";
    }else{
        model.Fundus = @"0";
    }
    
    int i = 0;
    if (self.moreSign.footer1Btn.selected) {
        i += 1;
    }
    if (self.moreSign.footer2Btn.selected) {
        i += 2;
    }
    if (self.moreSign.footer3Btn.selected) {
        i += 4;
    }
    model.Plantar = [NSString stringWithFormat:@"%d",i];
    [FileUtils saveBodySignWithUID:self.userId AndModel:model];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
- (void)setNavigation{
    self.navigationItem.title = @"更多体征";
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 50, 30);
    button.layer.cornerRadius = 3.0f;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:blueColorWithRGB(61, 172, 225)];
    [button addTarget:self  action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}



@end
