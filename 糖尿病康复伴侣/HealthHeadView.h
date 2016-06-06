//
//  healthHeadView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthHeadView : UIView


+(id)healthHeadView;

@property (nonatomic, weak) IBOutlet UIButton * leftBtn;
@property (nonatomic, weak) IBOutlet UIButton * rightBtn;

@property (nonatomic, weak) IBOutlet UILabel * intakeLabel;

@property (nonatomic, weak) IBOutlet UILabel * movementLabel;
@property (nonatomic, weak) IBOutlet UILabel * bloodLabel;
@property (nonatomic, weak) IBOutlet UILabel * medicineLabel;

@end
