//
//  BloodSugarHomeView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/13.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BloodSugarModel;
@interface BloodSugarHomeView : UIView

@property (nonatomic, strong) UIButton * button;

+ (id)viewCreat;
- (void)viewWithModel:(BloodSugarModel*)model;
//体征
- (void)viewForBodySign:(NSString*)name andValue:(NSString*)value;
@end
