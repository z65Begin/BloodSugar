//
//  FoodEvaluateCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/11.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StatisticsModel;
@interface FoodEvaluateCell : UITableViewCell

+ (instancetype)cellWithXIBForTableView:(UITableView*)tableView;

- (void)cellWithModel:(StatisticsModel*)model;
@end
