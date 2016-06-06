//
//  SetViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/4.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController ()

//@property (nonatomic, weak) IBOutlet UISwitch * willC;

@property (nonatomic, weak) IBOutlet UISwitch * switch1;
@property (nonatomic, weak) IBOutlet UISwitch * switch2;
@property (nonatomic, weak) IBOutlet UISwitch * switch3;
@property (nonatomic, weak) IBOutlet UISwitch * switch4;
@property (nonatomic, weak) IBOutlet UISwitch * switch5;
@property (nonatomic, weak) IBOutlet UISwitch * switch6;
@property (nonatomic, weak) IBOutlet UISwitch * switch7;
@property (nonatomic, weak) IBOutlet UIButton * setButton;
@property (nonatomic, weak) IBOutlet UIView * view1;
@property (nonatomic, weak) IBOutlet UIView * view2;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.view1.layer.cornerRadius = 8.0f;
    self.view2.layer.cornerRadius = 8.0f;
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary * newDic = [userDefault objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    if (!newDic) {
        newDic = [NSMutableDictionary dictionary];
        [newDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_Sync];
        [newDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_ONLYWIFI];
        [newDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_WARNING];
        [newDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_DIETHIDDEN];
        [newDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_SPORTHIDDEN];
        [newDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_BODYSIGNHIDDEN];
        [newDic setObject:[NSNumber numberWithBool:YES] forKey:SETTING_MEDICINEHIDDEN];
        [userDefault setObject:newDic forKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
        [userDefault synchronize];
    }
    self.switch1.on = [[newDic objectForKey:SETTING_Sync] boolValue];
    self.switch2.on = [[newDic objectForKey:SETTING_ONLYWIFI] boolValue];
    self.switch3.on = [[newDic objectForKey:SETTING_WARNING] boolValue];
    self.switch4.on = [[newDic objectForKey:SETTING_DIETHIDDEN] boolValue];
    self.switch5.on = [[newDic objectForKey:SETTING_SPORTHIDDEN] boolValue];
    self.switch6.on = [[newDic objectForKey:SETTING_BODYSIGNHIDDEN] boolValue];
    self.switch7.on = [[newDic objectForKey:SETTING_MEDICINEHIDDEN] boolValue];
    
    if (!self.switch1.on) {
        self.viewTop.constant = 0;
        self.viewHeight.constant = 0;
        
    }else{
        self.viewTop.constant = 5;
        self.viewHeight.constant = 56;
    }
    self.view1.hidden = !self.switch1.on;
}

- (IBAction)syncSwith:(UISwitch*)sender{
    if (sender == self.switch1) {
        if (!self.switch1.on) {
            [UIView animateWithDuration:1.0 animations:^{
                self.viewTop.constant = 0;
                self.viewHeight.constant = 0;
            }];
        }else{
            [UIView animateWithDuration:1.0 animations:^{
                self.viewTop.constant = 5;
                self.viewHeight.constant = 56;
 
            }];
        }
        self.view1.hidden = !self.switch1.on;
    }
    [self saveSettingInformationInFile];
}

- (IBAction)setButtonClick:(UIButton*)sender{
    self.switch4.on = YES;
    self.switch5.on = YES;
    self.switch6.on = YES;
    self.switch7.on = YES;
    [self saveSettingInformationInFile];
}
- (IBAction)changeSwitch:(UISwitch*)sender{
    BOOL flag = NO;
    for (UIView * view in self.view2.subviews) {
        if ([view isKindOfClass:[UISwitch class]]) {
            UISwitch * childSwitch = (UISwitch*)view;
            if (sender == childSwitch) {
                continue;
            }
            if (childSwitch.on) {
                flag = YES;
                break;
            }
        }
    }
    if (!flag) {
        UISwitch * nextSwitch = (UISwitch*)[self.view viewWithTag:(sender.tag + 10)];
        if (nextSwitch != nil) {
            nextSwitch.on = YES;
        }else{
            self.switch4.on = YES;
        }
    }
    [self saveSettingInformationInFile];
}
- (void)saveSettingInformationInFile{
  NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary * dic = [userDefault objectForKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    
    NSMutableDictionary * setDic = [NSMutableDictionary dictionary];
    [setDic setValue:[NSNumber numberWithBool:self.switch1.on] forKey:SETTING_Sync];
    [setDic setValue:[NSNumber numberWithBool:self.switch2.on] forKey:SETTING_ONLYWIFI];
    [setDic setValue:[NSNumber numberWithBool:self.switch3.on] forKey:SETTING_WARNING];
    [setDic setValue:[NSNumber numberWithBool:self.switch4.on] forKey:SETTING_DIETHIDDEN];
    [setDic setValue:[NSNumber numberWithBool:self.switch5.on] forKey:SETTING_SPORTHIDDEN];
    [setDic setValue:[NSNumber numberWithBool:self.switch6.on] forKey:SETTING_BODYSIGNHIDDEN];
    [setDic setValue:[NSNumber numberWithBool:self.switch7.on] forKey:SETTING_MEDICINEHIDDEN];
    dic = [setDic copy];
    [userDefault setObject:dic forKey:[NSString stringWithFormat:@"%@%@",SETTING_DICTIONARY,[SingleManager sharedSingleManager].InfoModel.UID]];
    [userDefault synchronize];
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
