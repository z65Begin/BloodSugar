//
//  SportEvaluateCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/10.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportEvaluateCell.h"

#import "sportCataModel.h"
#import "SportRecordModel.h"

@interface SportEvaluateCell ()

@property (nonatomic, weak) IBOutlet UILabel * cataLabel;
@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UIView * valueView;
@property (nonatomic, weak) IBOutlet UILabel * valueLabel;
@property (nonatomic, weak) IBOutlet UIImageView * imageV;
@property (nonatomic, weak) IBOutlet UILabel * energyLabel;

@property (nonatomic, assign) float sportEnergy;

@property (nonatomic, assign) float scale;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *valueViewRight;

@end

@implementation SportEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.cornerRadius = 8.0f;
    self.layer.borderColor = blueColorWithRGB(61, 172, 225).CGColor;
    self.layer.borderWidth = 1.0f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithXIBForTableView:(UITableView*)tableView andSportEnergy:(float) sportEnergy{
    static NSString * cellIdentifier = @"SportEvaluateCell";
    SportEvaluateCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SportEvaluateCell" owner:self options:nil]firstObject];
    }
    cell.sportEnergy = sportEnergy;
    return cell;
}
- (void)cellWithSportModel:(SportRecordModel*)model{
//运动分类
    sportCataModel* cataModel = [SportFileUtils readSportCataWith:model.Type];
    self.cataLabel.text = cataModel.Name;
//    运动时间
    int timeLength = model.TimeLength.intValue;
    int hour = 0;
    int minute = 0;
    int second = 0;
    if (timeLength/60/60) {
        hour = timeLength/60/60;
    }
    if ((timeLength%(60*60))/60) {
        minute = timeLength%(60*60)/60;
    }
    if ((timeLength%(60*60))%60) {
        second = (timeLength%(60*60))%60;
    }
    NSString * timeStr = [[NSString alloc]init];
    if (hour) {
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d时",hour]];
    }
    if (minute) {
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d分",minute]];
    }
    if (second) {
        timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d秒",second]];
    }
    if (!hour && !minute && !second) {
        timeStr = [timeStr stringByAppendingString:@"0秒"];
    }
    self.timeLabel.text = timeStr;
    
    float scale = 1;
    if (self.sportEnergy) {
        scale  = model.TimeLength.floatValue/60.0 * cataModel.Energy.floatValue/self.sportEnergy;
    }
  
    self.valueLabel.text = [NSString stringWithFormat:@"%.1f%%",scale];
    self.scale = scale;

//    extern NSString * const SPORT_Result_00;//正常呼吸没有不适
//    extern NSString * const SPORT_Result_01;//呼吸加快但可以与人正常交谈
//    extern NSString * const SPORT_Result_02;//呼吸急促 还可以交谈 但有困难
//    extern NSString * const SPORT_Result_03;//气喘 甚至伴有胸闷等其他不适
    self.imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_effect_%@",model.Result]];
    NSString* stepBase = [FileUtils getValueUsingcode:@"001"];
    float energyNeed = (float)model.TimeLength.floatValue/60.0 * cataModel.Energy.floatValue;
    int stepNeed = (int)stepBase.floatValue *model.TimeLength.intValue/60 * cataModel.Energy.floatValue;
    self.energyLabel.text = [NSString stringWithFormat:@"%d步/%.2f千卡",stepNeed,energyNeed];
}
- (void)layoutSubviews{
    self.valueViewRight.constant = 15 +(1 - self.scale)*(W-100);
}


@end
