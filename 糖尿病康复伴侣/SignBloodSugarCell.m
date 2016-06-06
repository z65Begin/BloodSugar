//
//  SignBloodSugarCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SignBloodSugarCell.h"

#import "BloodSugarModel.h"

@interface SignBloodSugarCell()<UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UIButton * deleteBtn;

@property (nonatomic, strong) BloodSugarModel * model;
@end

@implementation SignBloodSugarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+ (instancetype)cellOfTableView:(UITableView *)tableView{
static NSString * cellIdentifier = @"SignBloodSugarCell";
    SignBloodSugarCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SignBloodSugarCell" owner:self options:nil] firstObject];
    }
    return cell;
}
- (void)cellWithModel:(BloodSugarModel*)model{
    NSString * contentText = nil;
    if ([model.timeper isEqualToString:SUGAR_timeper_breakfast]) {
        contentText = @"空腹";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_breakfast_after]) {
        contentText = @"早餐后2小时";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_lunch]) {
        contentText = @"午餐";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_lunch_after]) {
        contentText = @"午餐后2小时";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_dinner]) {
        contentText = @"晚餐";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_dinner_after]) {
        contentText = @"晚餐后2小时";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_bedtime]) {
        contentText = @"睡前";
    }
    self.timeLabel.text = contentText;
    self.textField.text = model.Value;
    self.model = model;
}

- (IBAction)deleteButtonClick:(UIButton*)sender{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否要删除%@的血糖记录?",self.timeLabel.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"alert view  buttonIndex %ld",buttonIndex);
    if (buttonIndex == 1) {
        self.delegateCell(self.model);
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (textField.text.length > 3) {
        return NO;
    }
    self.model.Value = [NSString stringWithFormat:@"%@%@",textField.text,string];
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
