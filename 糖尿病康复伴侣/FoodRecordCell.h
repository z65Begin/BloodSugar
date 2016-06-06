//
//  FoodRecordCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodRecordModel;
@interface FoodRecordCell : UITableViewCell

@property (nonatomic, copy) void(^cellBlock)(FoodRecordModel * model);

+ (instancetype)cellForTableView:(UITableView *)tableView;
- (void)cellContentWitnModel:(FoodRecordModel*)model;
@end
