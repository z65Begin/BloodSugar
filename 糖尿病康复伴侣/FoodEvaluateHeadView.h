//
//  FoodEvaluateHeadView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/10.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodEvaluateHeadView : UIView

@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UIButton * shareBtn;
@property (nonatomic, weak) IBOutlet UILabel * standIntakeLabel;
@property (nonatomic, weak) IBOutlet UILabel * realityLabel;
@property (nonatomic, weak) IBOutlet UILabel * proteinScaleLabel;
@property (nonatomic, weak) IBOutlet UILabel * proteinIntakeLabel;
@property (nonatomic, weak) IBOutlet UILabel * proteinNeedLabel;
@property (nonatomic, weak) IBOutlet UILabel * fatScaleLaebl;
@property (nonatomic, weak) IBOutlet UILabel * fatIntakeLabel;
@property (nonatomic, weak) IBOutlet UILabel * fatNeedLabel;
@property (nonatomic, weak) IBOutlet UILabel * carbohydrateScaleLabel;
@property (nonatomic, weak) IBOutlet UILabel * carbohydrateIntakeLabel;
@property (nonatomic, weak) IBOutlet UILabel * carbohydrateNeedLabel;

@property (nonatomic, weak) IBOutlet UIView * proteinView;
@property (nonatomic, weak) IBOutlet UIView * fatView;
@property (nonatomic, weak) IBOutlet UIView * carbohydrateView;

@property (nonatomic, weak) IBOutlet UIView * bigView;
@property (nonatomic, weak) IBOutlet UIView * littleView;

@property (nonatomic, strong) CALayer * protein;
@property (nonatomic, strong) CALayer * fat;
@property (nonatomic, strong) CALayer * carbs;

+ (instancetype)viewWithXIB;

@end
