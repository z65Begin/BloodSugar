//
//  SportListCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportListCell.h"

#import "SportRecordModel.h"
#import "sportCataModel.h"


@interface SportListCell ()<UIAlertViewDelegate,UITextFieldDelegate>


@property (nonatomic, weak) IBOutlet UILabel * cataLabel;

@property (nonatomic, weak) IBOutlet UIView * chooseSportCate;

@property (nonatomic, weak) IBOutlet UIButton * recyleButton;

@property (nonatomic, weak) IBOutlet UITextField * minuteTextField;
@property (nonatomic, weak) IBOutlet UITextField * secondTextField;

@property (nonatomic, strong) SportRecordModel * model;


- (IBAction)resultButtonClick:(UIButton*)sender;

- (IBAction)recyleButtonClick:(UIButton*)sender;
@end

@implementation SportListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.timeLabel.layer.borderColor = blueColorWithRGB(61, 172, 225).CGColor;
    self.timeLabel.layer.borderWidth = 0.5f;
    
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [self.chooseSportCate addGestureRecognizer:tapGR];
    UITapGestureRecognizer * timeGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTimeLabel:)];
    self.timeLabel.userInteractionEnabled = YES;
    [self.timeLabel addGestureRecognizer:timeGR];
}
+ (instancetype)cellForTableView:(UITableView*)tableView{
    static NSString * cellIdentifier = @"SportListCell";
    SportListCell * cell = [tableView  dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SportListCell" owner:self options:nil]firstObject];
    }
    return cell;
    
}
- (void)cellWithSportModel:(SportRecordModel*)model{
    sportCataModel* cataModel = [SportFileUtils readSportCataWith:model.Type];
    self.cataLabel.text = cataModel.Name;
    NSString * nameStr = [UtilCommon stringData_mm_ssFromStr:model.time];
    
    self.timeLabel.text = nameStr;
    int minute = [model.TimeLength intValue]/60;
    int second = [model.TimeLength intValue]%60;
    self.minuteTextField.text = [NSString stringWithFormat:@"%d",minute];
    self.secondTextField.text = [NSString stringWithFormat:@"%d",second];
    
    NSString * resultStr = nil;
    UIImage * image = nil;
    if ([model.Result isEqualToString:SPORT_Result_00]) {
        resultStr = @"正常呼吸，没有不适";
        image = [UIImage imageNamed:@"img_effect_00"];
    }
    if ([model.Result isEqualToString:SPORT_Result_01]) {
        resultStr = @"呼吸加快，但可以与人正常交谈";
        image = [UIImage imageNamed:@"img_effect_01"];
    }
    if ([model.Result isEqualToString:SPORT_Result_02]) {
        resultStr = @"呼吸急促，还可以交谈，但有困难";
        image = [UIImage imageNamed:@"img_effect_02"];
    }
    if ([model.Result isEqualToString:SPORT_Result_03]) {
        resultStr = @"气喘，甚至伴有胸闷等其他不适";
        image = [UIImage imageNamed:@"img_effect_03"];
    }
    [self.resultButton setTitle:resultStr forState:UIControlStateNormal];
    [self.resultButton setImage:image forState:UIControlStateNormal];
    
    self.model = model;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if ([string isEqualToString:@""]) {
        if(textField == self.secondTextField){
            self.model.TimeLength = [NSString stringWithFormat:@"%d",(self.minuteTextField.text.intValue* 60+self.secondTextField.text.intValue/10)];
        }
        if (textField == self.minuteTextField) {
            //        NSLog(@"2");
            self.model.TimeLength = [NSString stringWithFormat:@"%d",((self.minuteTextField.text.intValue/10)* 60+self.secondTextField.text.intValue)];
        }
//         NSLog(@"%@==%@",self.model.TimeLength,self.model);
        
        return YES;
    }else{
    if (textField.text.length >= 3 && string  ) {
        return NO;
        string = nil;
        NSRange range = NSMakeRange(0,3);
        textField.text = [textField.text substringWithRange:range];
        
    }
        if(textField == self.secondTextField){
            self.model.TimeLength = [NSString stringWithFormat:@"%d",(self.minuteTextField.text.intValue* 60+self.secondTextField.text.intValue*10+string.intValue)];
        }
        if (textField == self.minuteTextField) {
            //        NSLog(@"2");
            self.model.TimeLength = [NSString stringWithFormat:@"%d",((self.minuteTextField.text.intValue*10+string.intValue)* 60+self.secondTextField.text.intValue)];
        }
        
    }
    NSLog(@"%@==%@",self.model.TimeLength,self.model);
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}
- (void)recyleButtonClick:(UIButton *)sender{
    NSLog(@"%s",__func__);
    sportCataModel* cataModel = [SportFileUtils readSportCataWith:self.model.Type];
    NSString * messageStr = [NSString stringWithFormat:@"是否确定删除这条%@记录",cataModel.Name];
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
    
    
}
- (void)resultButtonClick:(UIButton *)sender{
//    NSLog(@"%s",__func__);
    self.chooseResult(nil);
    
    
}
- (void)tapView:(UITapGestureRecognizer*)tapGR{
//    NSLog(@"点击了view");
    self.tapViewChoice();
}
- (void)tapTimeLabel:(UITapGestureRecognizer*)tapGR{
//    NSLog(@"点击了时间");
    self.timeChooseResult();
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        self.recyleButtonDelete(self.model);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
