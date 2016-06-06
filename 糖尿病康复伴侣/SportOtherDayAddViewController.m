//
//  SportOtherDayAddViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/8.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportOtherDayAddViewController.h"

#import "SportCataChooseViewController.h"

#import "CXChooseDateView.h"

#import "SportAlertView.h"

#import "sportCataModel.h"

#import "SportRecordModel.h"

@interface SportOtherDayAddViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIView * chooseView;
@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * energyLabel;

@property (nonatomic, weak) IBOutlet UIButton * timeBtn;
@property (nonatomic, weak) IBOutlet UIButton * resultBtn;
@property (nonatomic, weak) IBOutlet UITextField * minuteTF;
@property (nonatomic, weak) IBOutlet UITextField * secondTF;
@property (nonatomic, weak) IBOutlet UIButton * cancelBtn;
@property (nonatomic, weak) IBOutlet UIButton * sureBtn;

- (IBAction)cancelBtnClick:(UIButton*)sender;
- (IBAction)sureBtnClick:(UIButton*)sender;
- (IBAction)timeBtnClick:(UIButton*)sender;
- (IBAction)resultBtnClick:(UIButton*)sender;

@property (nonatomic, strong) SportRecordModel* model;

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation SportOtherDayAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.chooseView.layer.cornerRadius = 8.0f;
    self.resultBtn.layer.cornerRadius = 4.0f;
    self.timeBtn.layer.cornerRadius = 4.0f;
    self.navigationController.navigationBarHidden = YES;
    
    NSArray * cataModelArr = [SportFileUtils readSid];
    
    sportCataModel* cataModel = [cataModelArr firstObject];
    self.model.Type = cataModel.sid;
    self.model.Result = SPORT_Result_00;
    self.model.date = self.date;
    self.nameLabel.text = cataModel.Name;
    self.energyLabel.text = cataModel.Energy;
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseCataSport:)];
    [self.chooseView addGestureRecognizer:tapGR];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate * nowData = [NSDate date];
    NSString * timeStr = [formatter stringFromDate:nowData];
    
    self.model.time = [NSString stringWithFormat:@"%@ %@",self.date,timeStr];
    self.dataSource = [SportFileUtils readSportRecordWithUID:self.userId andDate:self.model.date];
    [self.timeBtn setTitle:[UtilCommon stringData_mm_ssFromStr:self.model.time] forState:UIControlStateNormal];
    
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
- (void)sureBtnClick:(UIButton *)sender{
    if((!self.minuteTF.text || [self.minuteTF.text isEqualToString:@""])&&(!self.secondTF.text || [self.secondTF.text isEqualToString:@""])) {
        [UtilCommon alertView:@"提示" andMessage:@"请输入时间"];
        return;
    }
    for (SportRecordModel * model in self.dataSource) {
        if ([self.model.time isEqualToString:model.time]) {
             [UtilCommon alertView:@"提示" andMessage:@"不能添加相同时间运动"];
            return;
        }
    }
    self.model.UpdTime = [FileUtils getNowUpdTime];
    
    self.model.TimeLength = [NSString stringWithFormat:@"%d",(self.minuteTF.text.intValue * 60 + self.secondTF.text.intValue)];
    
    if ([SportFileUtils saveSportRecordWithUID:self.userId andRecordModel:self.model]) {
        if (self.nameBlock) {
            self.nameBlock();
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    [UtilCommon alertView:@"提示" andMessage:@"保存失败"];
    }
}
//更换时间
- (void)timeBtnClick:(UIButton *)sender{
    [self.view endEditing:YES];
    
    CXChooseDateView * view = [CXChooseDateView viewWithXIBWithDate:self.model.time];
    [view viewAddToView:self.view];
    view.timeChoose = ^(NSString* timeStr){
        self.model.time = timeStr;
        [self.timeBtn setTitle:[UtilCommon stringData_mm_ssFromStr:timeStr] forState:UIControlStateNormal];
    };
}
//更换结果
- (void)resultBtnClick:(UIButton *)sender{
     [self.view endEditing:YES];
    UIView * view = [[UIView alloc]initWithFrame:self.view.bounds];
    view.backgroundColor = [UIColor darkGrayColor];
    view.alpha = 0.8;
    [self.view addSubview:view];
    SportAlertView * alert = [SportAlertView viewWithXIB];
    alert.frame = CGRectMake(20, (H-400)/2, W-40, 204);
    [self.view addSubview:alert];
    __weak typeof(alert) weakAlert = alert;
    alert.chooseChildResult = ^(NSString* result){
              self.model.Result = result;
        
        [view removeFromSuperview];
        [weakAlert removeFromSuperview];
        NSString *resultStr = nil;
        UIImage * image = nil;
        if ([self.model.Result isEqualToString:SPORT_Result_00]) {
            resultStr = @"正常呼吸，没有不适";
            image = [UIImage imageNamed:@"img_effect_00"];
        }
        if ([self.model.Result isEqualToString:SPORT_Result_01]) {
            resultStr = @"呼吸加快，但可以与人正常交谈";
            image = [UIImage imageNamed:@"img_effect_01"];
        }
        if ([self.model.Result isEqualToString:SPORT_Result_02]) {
            resultStr = @"呼吸急促，还可以交谈，但有困难";
            image = [UIImage imageNamed:@"img_effect_02"];
        }
        if ([self.model.Result isEqualToString:SPORT_Result_03]) {
            resultStr = @"气喘，甚至伴有胸闷等其他不适";
            image = [UIImage imageNamed:@"img_effect_03"];
        }
        [self.resultBtn setTitle:resultStr forState:UIControlStateNormal];
        [self.resultBtn setImage:image forState:UIControlStateNormal];
    };
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField == self.minuteTF) {
        if (textField.text.length >=2) {
            return NO;
        }
    }
    if (textField == self.secondTF) {
        if (textField.text.length >=1) {
            return NO;
        }
    }
    return YES;
}
- (void)chooseCataSport:(UITapGestureRecognizer*)tapGR{
     [self.view endEditing:YES];
    SportCataChooseViewController * choose = [[SportCataChooseViewController alloc]init];
    choose.chooseSportCata = ^(sportCataModel* model){
        self.model.Type = model.sid;
        self.nameLabel.text = model.Name;
        self.energyLabel.text = model.Energy;
    };
    [self.navigationController pushViewController:choose animated:YES];
}

- (void)cancelBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (SportRecordModel *)model{
    if (!_model) {
        _model = [[SportRecordModel alloc]init];
    }
    return _model;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

@end
