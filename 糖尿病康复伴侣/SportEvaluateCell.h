//
//  SportEvaluateCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/10.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportEvaluateCell : UITableViewCell
+ (instancetype)cellWithXIBForTableView:(UITableView*)tableView andSportEnergy:(float) sportEnergy;
- (void)cellWithSportModel:(SportRecordModel*)model;

@end
