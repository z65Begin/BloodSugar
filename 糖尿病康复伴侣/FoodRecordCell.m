//
//  FoodRecordCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FoodRecordCell.h"

#import "FoodRecordModel.h"

#import "foodmodel.h"

@interface FoodRecordCell ()<UIAlertViewDelegate,UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UITextField * textField;
@property (nonatomic, weak) IBOutlet UILabel * unitLabel;
@property (nonatomic, weak) IBOutlet UIButton * recycleBtn;


@property (nonatomic, strong) foodmodel * model;

@property (nonatomic, strong) FoodRecordModel * foodRecord;
@end

@implementation FoodRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellForTableView:(UITableView *)tableView{
    static NSString * cellIdentifier = @"FoodRecordCell";
    
    FoodRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FoodRecordCell" owner:self options:nil]firstObject];
    }
    return  cell;
}

- (void)cellContentWitnModel:(FoodRecordModel*)model{
 foodmodel * food = [FileUtils getFoodModelWithFoodId:model.foodId];
    self.nameLabel.text = food.FoodName;
    self.textField.text = model.intake;
    if ([food.UnitName isEqualToString:@"g"]) {
        self.unitLabel.text = @"克";
    }else{
        self.unitLabel.text = food.UnitName;
    }
    self.model = food;
    [self.recycleBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    self.foodRecord = model;
}
- (void)deleteClick{
    NSString * message = [NSString stringWithFormat:@"是否确定删除%@",self.model.FoodName];
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    NSLog(@"%ld",buttonIndex);
    if (buttonIndex == 1) {
        self.cellBlock(self.foodRecord);
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if (textField.text.length > 3 && ![string isEqualToString:@""]) {
        return NO;
    }
    self.foodRecord.intake = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    return YES;
}


@end
