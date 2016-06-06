//
//  FoodEvaluateViewController.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/10.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsModel : NSObject

@property (nonatomic, copy) NSString * energy;
@property (nonatomic, copy) NSString * timepierod;
@property (nonatomic, copy) NSString * protein;
@property (nonatomic, copy) NSString * fat;
@property (nonatomic, copy) NSString * carbs;

@end

@interface FoodEvaluateViewController : UIViewController

@property (nonatomic, copy) NSString * date;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, assign) float baseIntake; 
@end
