//
//  FoodEvaluateCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/11.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FoodEvaluateCell.h"
#import "FoodEvaluateViewController.h"

//#import "StatisticsModel"

@interface FoodEvaluateCell ()

@property (nonatomic, weak) IBOutlet UILabel* timeperiodLabel;
@property (nonatomic, weak) IBOutlet UILabel* proteinLabel;
@property (nonatomic, weak) IBOutlet UILabel* fatLabel;
@property (nonatomic, weak) IBOutlet UILabel* carbsLabel;
@property (nonatomic, weak) IBOutlet UILabel * valueLabel;

@end

@implementation FoodEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithXIBForTableView:(UITableView*)tableView{
    static NSString * cellIdentifier = @"FoodEvaluateCell";
    
    FoodEvaluateCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FoodEvaluateCell" owner:self options:nil]firstObject];
    }
    return cell;
}
- (void)cellWithModel:(StatisticsModel*)model{
    self.timeperiodLabel.text = model.timepierod;
    self.proteinLabel.text = model.protein;
    self.fatLabel.text = model.fat;
    self.carbsLabel.text = model.carbs;
    self.valueLabel.text = model.energy;
    
    
}


@end
