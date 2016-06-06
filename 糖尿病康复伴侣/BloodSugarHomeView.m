//
//  BloodSugarHomeView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/13.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "BloodSugarHomeView.h"

#import "BloodSugarModel.h"

#import "BodySignModel.h"

@interface BloodSugarHomeView ()

@property (nonatomic, strong) UILabel * timePeriodLabel;
@property (nonatomic, strong) UILabel * valueLabel;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * unitLabel;
@end

@implementation BloodSugarHomeView


+ (id)viewCreat{
    BloodSugarHomeView * view = [[self alloc]init];
    view.frame = CGRectMake(0, 0, W-10,24);
    view.userInteractionEnabled = YES;
    return view;
}
- (instancetype)init{
    if (self = [super init]) {
        float width = W - 10;
        UILabel * timePeriodLabel = [self buildLabelWithTextAlight:NSTextAlignmentLeft];
        timePeriodLabel.frame = CGRectMake(10, 0, 100, 24);
        self.timePeriodLabel = timePeriodLabel;
        
        UILabel * unitLabel = [self buildLabelWithTextAlight:NSTextAlignmentLeft];
        unitLabel.frame = CGRectMake(width-70, 0, 70, 24);
        self.unitLabel = unitLabel;
        
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(CGRectGetMinX(unitLabel.frame)-13, 3, 13, 18);
        self.imageView = imageView;
        imageView.userInteractionEnabled = YES;
        
        UILabel * valueLabel = [self buildLabelWithTextAlight:NSTextAlignmentRight];
        valueLabel.textColor = blueColorWithRGB(61, 172, 225);
        valueLabel.frame = CGRectMake(CGRectGetMinX(unitLabel.frame)-113, 0, 100, 24);
        self.valueLabel = valueLabel;
        self.userInteractionEnabled = YES;
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(0, 0, width, 24);
        self.button = btn;
        
        [self addSubview:timePeriodLabel];
        [self addSubview:unitLabel];
        [self addSubview:imageView];
        [self addSubview:valueLabel];
        [self addSubview:btn];
    }
    return self;
}
- (UILabel*)buildLabelWithTextAlight:(NSTextAlignment)textAlight{
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textAlignment = textAlight;
    return label;
}

- (void)viewWithModel:(BloodSugarModel*)model{
    NSString * timeStr = nil;
    if ([model.timeper isEqualToString:SUGAR_timeper_breakfast]) {
        timeStr = @"空腹";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_breakfast_after]) {
        timeStr = @"早餐后2小时";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_lunch]) {
        timeStr = @"午餐前";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_lunch_after]) {
        timeStr = @"午餐后2小时";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_dinner]) {
        timeStr = @"晚餐前";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_dinner_after]) {
        timeStr = @"晚餐后2小时";
    }
    if ([model.timeper isEqualToString:SUGAR_timeper_bedtime]) {
        timeStr = @"睡前";
    }
    self.timePeriodLabel.text = timeStr;
    self.valueLabel.text = model.Value;
    float highEmputy = [[FileUtils getValueUsingcode:@"012"] floatValue];
    float lowEmputy = [[FileUtils getValueUsingcode:@"013"]floatValue];
    float highTwoHour = [[FileUtils getValueUsingcode:@"015"]floatValue];
    
    NSString * imageName = nil;
    if ([model.timeper isEqualToString:@"2"]) {
        if (model.Value.floatValue > highTwoHour) {
            imageName = @"img_arrow_up_red.png";
        }else if(model.Value.floatValue < lowEmputy){
            imageName = @"img_arrow_down_blue.png";
        }else{
            imageName = @"img_circle_green.png";
        }
    }else{
        if (model.Value.floatValue > highEmputy) {
            imageName = @"img_arrow_up_red.png";
        }else if(model.Value.floatValue < lowEmputy){
            imageName = @"img_arrow_down_blue.png";
        }else{
            imageName = @"img_circle_green.png";
        }
    }
    self.imageView.image = [UIImage imageNamed:imageName];
    self.unitLabel.text = @"mmol/L";
}

- (void)viewForBodySign:(NSString*)name andValue:(NSString*)value{
    CGRect frame = self.valueLabel.frame;
    frame.size.width = 113;
    self.valueLabel.frame = frame;
//    CGRect imageFrame = self.imageView.frame;
    self.imageView.hidden = YES;
//    imageFrame.size.height
    self.valueLabel.text = value;
    if ([name isEqualToString:@"Weight"]) {
        self.timePeriodLabel.text = @"体重";
        self.unitLabel.text = @"kg";
    }
    
    if ([name isEqualToString:@"DBP"]) {
        self.timePeriodLabel.text = @"血压";
        self.unitLabel.text = @"mmHg";
    }
    if ([name isEqualToString:@"Temperature"]) {
        self.timePeriodLabel.text = @"体温";
        self.unitLabel.text = @"℃";
    }
    if ([name isEqualToString:@"BlipidChol"]) {
        self.timePeriodLabel.text = @"总胆固醇";
        self.unitLabel.text = @"mmol/L";
    }
    if ([name isEqualToString:@"BlipidTG"]) {
        self.timePeriodLabel.text = @"甘油三酯";
        self.unitLabel.text = @"mmol/L";
    }
    if ([name isEqualToString:@"BlipidHDLIP"]) {
        self.timePeriodLabel.text = @"高密度脂蛋白";
        self.unitLabel.text = @"mmol/L";
    }
    if ([name isEqualToString:@"BlipidLDLIP"]) {
        self.timePeriodLabel.text = @"低密度脂蛋白";
        self.unitLabel.text = @"mmol/L";
    }
    if ([name isEqualToString:@"GlyHemoglobin"]) {
        self.timePeriodLabel.text = @"糖化血红蛋白";
        self.unitLabel.text = @"%";
    }
    if ([name isEqualToString:@"TotalBilirubin"]) {
        self.timePeriodLabel.text = @"总胆红素";
        self.unitLabel.text = @"umol/L";
    }
    if ([name isEqualToString:@"DirectBilirubin"]) {
        self.timePeriodLabel.text = @"直接胆红素";
        self.unitLabel.text = @"umol/L";

    }
    if ([name isEqualToString:@"SerumCreatinine"]) {
        self.timePeriodLabel.text = @"血清肌酐";
        self.unitLabel.text = @"umol/L";

    }
    if ([name isEqualToString:@"UricAcid"]) {
        self.timePeriodLabel.text = @"尿酸";
        self.unitLabel.text = @"umol/L";
    }
    if ([name isEqualToString:@"MiAlbuminuria"]) {
        self.timePeriodLabel.text = @"微蛋白尿检";
        self.unitLabel.text = @"mg/mmol/L·Cr";
    }
    if ([name isEqualToString:@"Fundus"]) {
        self.timePeriodLabel.text = @"眼底";
        self.unitLabel.text = nil;
        if ([value isEqualToString:@"0"]) {
            self.valueLabel.text = @"正常";
        }
        if ([value isEqualToString:@"1"]) {
            self.valueLabel.text = @"轻度非增殖性DR";
        }
        if ([value isEqualToString:@"2"]) {
            self.valueLabel.text = @"中度非增殖性DR";
        }
        if ([value isEqualToString:@"3"]) {
            self.valueLabel.text = @"重度非增殖性DR";
        }
        if ([value isEqualToString:@"4"]) {
            self.valueLabel.text = @"增殖性DR";
        }
        if ([value isEqualToString:@"5"]) {
            self.valueLabel.text = @"未测";
        }
    }
    if ([name isEqualToString:@"Plantar"]) {
        self.timePeriodLabel.text = @"足底";
        self.unitLabel.text = nil;
        int a = value.intValue;
        
        NSString * str1 = nil;
        NSString * str2 = nil;
        NSString * str3 = nil;
        int row = 0;
        
        if (a%2) {
            str1 = @"皮肤完整性异常";
            row ++;
        }
        a = a >>1;
        if (a%2) {
//            BloodSugarHomeView* view = [[BloodSugarHomeView alloc]init];
//            view.valueLabel.frame = frame;
//            view.timePeriodLabel.text = nil;
//            view.unitLabel.text = nil;
//            view.valueLabel.text = @"触觉异常";
//            view.frame = self.frame;
//            [self addSubview:view];
            str2 = @"触觉异常";
            row ++;
//            a = a>>1;
//            if (a%2) {
//                BloodSugarHomeView* view = [[BloodSugarHomeView alloc]init];
//                view.timePeriodLabel.text = nil;
//                view.unitLabel.text = nil;
//                view.valueLabel.text = @"温度感异常";
//                view.valueLabel.frame = frame;
//                [self addSubview:view];
//                str3 = @"温度感异常";
//                row++;
//            }
        }
        
        a = a>>1;
        if (a%2) {
            str3 = @"温度感异常";
            row++;
        }
        CGRect newFrame = self.frame;
        float height = newFrame.size.height;
        newFrame.size.height *= row;
//        self.unitLabel.text =
        self.frame = newFrame;
        
        if (str1) {
            self.valueLabel.text = str1;
            if (str2) {
                UILabel * label = [self buildLabelWithTextAlight:NSTextAlignmentRight];
                label.frame = CGRectMake(CGRectGetMinX(self.valueLabel.frame), height , CGRectGetWidth(self.valueLabel.frame), height);
                label.text = str2;
                label.textColor = blueColorWithRGB(61, 172, 225);
                [self addSubview:label];
                if (str3) {
                    UILabel * label = [self buildLabelWithTextAlight:NSTextAlignmentRight];
                    label.frame = CGRectMake(CGRectGetMinX(self.valueLabel.frame), height*2 , CGRectGetWidth(self.valueLabel.frame), height);
                    label.text = str3;
                    label.textColor = blueColorWithRGB(61, 172, 225);
                    [self addSubview:label];
                }
                
                
            }else if(str3){
                UILabel * label = [self buildLabelWithTextAlight:NSTextAlignmentRight];
                label.frame = CGRectMake(CGRectGetMinX(self.valueLabel.frame), height , CGRectGetWidth(self.valueLabel.frame), height);
                label.text = str3;
                label.textColor = blueColorWithRGB(61, 172, 225);
                [self addSubview:label];
            }
        }else if(str2){
            self.unitLabel.text = str2;
            if (str3) {
                UILabel * label = [self buildLabelWithTextAlight:NSTextAlignmentRight];
                label.frame = CGRectMake(CGRectGetMinX(self.valueLabel.frame), height , CGRectGetWidth(self.valueLabel.frame), height);
                label.text = str3;
                label.textColor = blueColorWithRGB(61, 172, 225);
                [self addSubview:label];
            }
            
        }else if(str3){
            self.unitLabel.text = str3;
            return;
        }
        
        
        
        
        
        
    }
}

@end
