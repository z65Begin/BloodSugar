//
//  SignBloodSugarViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SignBloodSugarViewController.h"

#import "BloodSugarModel.h"

@interface SignBloodSugarViewController ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIButton * button1;
@property (nonatomic, weak) IBOutlet UIButton * button2;
@property (nonatomic, weak) IBOutlet UIButton * button3;
@property (nonatomic, weak) IBOutlet UIButton * button4;
@property (nonatomic, weak) IBOutlet UIButton * button5;
@property (nonatomic, weak) IBOutlet UIButton * button6;
@property (nonatomic, weak) IBOutlet UIButton * button7;

@property (nonatomic, weak) IBOutlet UITextField * valueTextFiled;

@property (nonatomic, strong) NSArray * datasource;

@property (nonatomic, strong) BloodSugarModel* modelBloodS;

@end

@implementation SignBloodSugarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigation];
    [self setButtonBord];
    self.modelBloodS = [[BloodSugarModel alloc]init];
    
  NSArray * bloodSugarArray = [FileUtils readBloodSugarWithUID:self.userId andDate:self.date];
    NSMutableArray * array = [NSMutableArray array];
//    self.date = @"2016-04-27";
    for (BloodSugarModel * model in bloodSugarArray) {
        if( [model.date isEqualToString:self.date]){
        [array addObject:model];
        }
    }
    self.datasource = [array copy];
    
    [self categoryButtonClick:self.button1];
}
#pragma  mark 保存用户血糖值
- (void)saveBtn:(UIButton *)sender{
    if ([self.valueTextFiled.text floatValue] >= 100) {
        [UtilCommon alertView:@"提示" andMessage:@"血糖值格式不正确，请参照99.9"];
        return;
    }
    
    self.modelBloodS.date = self.date;
    self.modelBloodS.Value = [NSString stringWithFormat:@"%.1f",[self.valueTextFiled.text floatValue]];
    self.modelBloodS.UpdTime = [FileUtils getNowUpdTime];
    [FileUtils saveBloodSugarWithUID:self.userId andModel:self.modelBloodS];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length >= 3) {
        return NO;
//        textField.text = [textField.text substringWithRange:range];
    }
    return YES;
}


- (IBAction)categoryButtonClick:(UIButton*)sender{
    for (UIView * view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)view;
            button.selected = NO;
            button.backgroundColor = [UIColor whiteColor];
        }
    }
    sender.selected = YES;
    sender.backgroundColor = blueColorWithRGB(61, 172, 225);
    NSString * sugar_timeper = nil;
    NSString * sugar_timespan = nil;
    
    if (sender == self.button1) {
        sugar_timeper = SUGAR_timeper_breakfast;
    }
    if (sender == self.button2) {
        sugar_timeper = SUGAR_timeper_breakfast_after;
        sugar_timespan = @"2";
    }
    if (sender == self.button3) {
        sugar_timeper = SUGAR_timeper_lunch;
    }
    if (sender == self.button4) {
        sugar_timeper = SUGAR_timeper_lunch_after;
        sugar_timespan = @"2";
    }
    if (sender == self.button5) {
        sugar_timeper = SUGAR_timeper_dinner;
    }
    if (sender == self.button6) {
        sugar_timeper = SUGAR_timeper_dinner_after;
        sugar_timespan = @"2";
    }
    if (sender == self.button7) {
        sugar_timeper = SUGAR_timeper_bedtime;
    }
    for (BloodSugarModel * model in self.datasource) {
        if ([model.timeper isEqualToString:sugar_timeper]) {
            self.valueTextFiled.text = model.Value;
            self.modelBloodS.timeper = sugar_timeper;
            self.modelBloodS.timespan = sugar_timespan;
            return;
        }else{
            self.valueTextFiled.text = nil;
        }
    }
    self.modelBloodS.timeper = sugar_timeper;
    self.modelBloodS.timespan = sugar_timespan;
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)setNavigation{
    self.navigationItem.title = @"血糖录入";
    
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

- (void)setButtonBord{
    [self cx_setBordWidthForView:self.button1];
    [self cx_setBordWidthForView:self.button2];
    [self cx_setBordWidthForView:self.button3];
    [self cx_setBordWidthForView:self.button4];
    [self cx_setBordWidthForView:self.button5];
    [self cx_setBordWidthForView:self.button6];
    [self cx_setBordWidthForView:self.button7];
}
- (void)cx_setBordWidthForView:(UIView*)view{
    view.layer.borderWidth = 1.0f;
    view.layer.borderColor = blueColorWithRGB(61, 172, 225).CGColor;
    view.layer.cornerRadius = 8.0f;
    
}
- (NSArray *)datasource{
    if (!_datasource) {
        _datasource = [NSArray array];
    }
    return _datasource;
}

@end
