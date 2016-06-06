//
//  SportHomeView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/11.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportHomeView.h"

#import "sportCataModel.h"
#import "SportRecordModel.h"

@interface SportHomeView ()

@property (nonatomic, strong)  UILabel * timeLabel;
@property (nonatomic, strong)  UILabel * cataNameLabel;
@property (nonatomic, strong)  UILabel * timeLengthLabel;
@property (nonatomic, strong)  UILabel * energy;

@end


@implementation SportHomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)viewWithXIB{

//    return [[[NSBundle mainBundle]loadNibNamed:@"SportHomeView" owner:self options:nil]firstObject];
    SportHomeView * view = [[self alloc]init];
    return view;
    
}
- (void)viweWithSportRecordModel:(SportRecordModel*)model{
    self.timeLabel.text = [UtilCommon stringData_mm_ssFromStr:model.time];    //1
    sportCataModel * cataM = [SportFileUtils readSportCataWith:model.Type];   //2
    self.cataNameLabel.text = cataM.Name;
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
    self.timeLengthLabel.text = timeStr;                                     //3
    self.energy.text = [NSString stringWithFormat:@"%d",(int)(model.TimeLength.floatValue/60*cataM.Energy.floatValue)];
    
}
- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, W-10, 24);
        UILabel * timeLabel = [self buildLabelWithTextAlignment:NSTextAlignmentCenter];
        timeLabel.frame = CGRectMake(10, 0, 35, 24);
      
        self.timeLabel = timeLabel;
        
        UILabel * unitLabel = [self buildLabelWithTextAlignment:NSTextAlignmentLeft];
        unitLabel.frame = CGRectMake(self.frame.size.width - 5-25, 0, 25, 24);
        
        unitLabel.text = @"千卡";
        UILabel* energyLabel = [self buildLabelWithTextAlignment:NSTextAlignmentRight];
        energyLabel.frame = CGRectMake(CGRectGetMinX(unitLabel.frame)-40, 0, 40, 24);
        energyLabel.textColor = blueColorWithRGB(61, 172, 225);
        self.energy = energyLabel;
        
        UILabel * timeLengthLabel = [self buildLabelWithTextAlignment:NSTextAlignmentRight];
       float width = CGRectGetMinX(energyLabel.frame)-CGRectGetMaxX(timeLabel.frame)-10;
        timeLengthLabel.frame = CGRectMake(CGRectGetMinX(energyLabel.frame)-  width/2 -5, 0, width/2 , 24);
        timeLengthLabel.textColor = blueColorWithRGB(61, 172, 225);
        self.timeLengthLabel = timeLengthLabel;
        
        UILabel * cataNameLabel = [self buildLabelWithTextAlignment:NSTextAlignmentLeft];
        cataNameLabel.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+5, 0, 120, 24);
        self.cataNameLabel = cataNameLabel;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0, 0, W-10, 24);
        self.button = btn;
        
        [self addSubview:timeLabel];
        [self addSubview:unitLabel];
        [self addSubview:energyLabel];
        [self addSubview:timeLengthLabel];
        [self addSubview:cataNameLabel];
        [self addSubview:btn];
    }
    
    return self;
}

- (UILabel*)buildLabelWithTextAlignment:(NSTextAlignment)textAlignment{
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textAlignment = textAlignment;
    return label;
}


@end
