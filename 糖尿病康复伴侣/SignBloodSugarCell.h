//
//  SignBloodSugarCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BloodSugarModel;
@interface SignBloodSugarCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UITextField * textField;

@property (nonatomic, copy) void(^delegateCell)(BloodSugarModel * model);

+ (instancetype)cellOfTableView:(UITableView *)tableView;
- (void)cellWithModel:(BloodSugarModel*)model;
@end
