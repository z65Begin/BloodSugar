//
//  MethodView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MethodView : UIView

@property (nonatomic, strong)  UILabel * nameLabel;
@property (nonatomic, strong)  UILabel * intakeLael;
@property (nonatomic, strong)  UILabel * unitLabel;

+ (instancetype)viewWithXib;

@end
