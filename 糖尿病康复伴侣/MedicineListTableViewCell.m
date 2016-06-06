//
//  MedicineListTableViewCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MedicineListTableViewCell.h"

#import "MedicineRecordModel.h"

@interface MedicineListTableViewCell()<UIAlertViewDelegate,UITextFieldDelegate,UITextInputDelegate>

@property (nonatomic, weak) IBOutlet UIView * backView;

- (IBAction)deleteBtnClick:(id)sender;
- (IBAction)chooseMedicineBtn:(id)sender;

- (IBAction)noteBtnClick:(id)sender;

- (IBAction)chooseUnitName:(id)sender;

@property (nonatomic, strong) MedicineRecordModel * model;



@end

@implementation MedicineListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backView.layer.borderColor = blueColorWithRGB(61, 172, 225).CGColor;
    self.backView.layer.borderWidth = 1.0f;
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(numLabelTap)];
    self.nameLabel.userInteractionEnabled = YES;
    [self.nameLabel addGestureRecognizer:tapGR];
    self.numTF.delegate = self;
    self.unitTF.delegate = self;
    self.timesTF.delegate = self;
//    self.numTF.inputDelegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (id)cellForTableView:(UITableView*)tableView{
    static NSString * cellIdentifier = @"MedicineListTableViewCell";
    MedicineListTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MedicineListTableViewCell" owner:self options:nil]firstObject];
    }
    return cell;
}

- (void)cellWithModel:(MedicineRecordModel*)model{
    self.nameLabel.text = model.MedName;
    self.unitTF.text = model.UnitName;
    self.numTF.text = model.AMountUnit;
    self.timesTF.text = model.AmountTimes;
    self.noteLabel.text = model.Notes;
    self.model = model;
}
//更改药物名称
- (void)numLabelTap{
//    NSLog(@"adadasd");
    if (self.inputMedicineName) {
        self.inputMedicineName();
    }
}
//更改药物详情
- (void)noteBtnClick:(id)sender{
    if (self.changeNote) {
        self.changeNote();
    }
}


// 选择药品按钮
- (void)chooseMedicineBtn:(id)sender{
    if (self.chooseMedicine) {
        self.chooseMedicine();
    }
}
- (void)chooseUnitName:(id)sender{
    if (self.chooseUnit) {
        self.chooseUnit();
    }
}

- (void)deleteBtnClick:(id)sender{
    NSString * messageStr = [NSString stringWithFormat:@"是否确定删除该条%@记录",self.model.MedName];
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:messageStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (self.deleteBtnClick) {
            self.deleteBtnClick(self.model);
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length > 2 && ![string isEqualToString:@""]) {
        return NO;
    }
    if (textField == self.unitTF) {
        self.model.UnitName = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    if (textField == self.numTF) {
        self.model.AMountUnit = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    if (textField == self.timesTF) {
        self.model.AmountTimes = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
//    NSLog(@"%s==%@",__func__,textField.text);
    
    
    
    return YES;
}



//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    NSLog(@"%s==%@",__func__,textField.text);
//    return YES;
//}
//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//NSLog(@"%s==%@",__func__,textField.text);
//}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//NSLog(@"%s==%@",__func__,textField.text);
//    return YES;
//}
//- (void)textFieldDidEndEditing:(UITextField *)textField{
//NSLog(@"%s==%@",__func__,textField.text);
//}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSLog(@"%s==%@",__func__,textField.text);
//    return YES;
//}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
//- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
//- (void)textFieldDidEndEditing:(UITextField *)textField;             // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;   // return NO to not change text
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
//- (BOOL)textFieldShouldReturn:(UITextField *)textField;


@end
