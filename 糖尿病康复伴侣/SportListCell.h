//
//  SportListCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SportRecordModel;
@interface SportListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView * hiddenView;
@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UIButton * resultButton;
//  删除按钮
@property (nonatomic, copy) void(^recyleButtonDelete)(SportRecordModel* model);

@property (nonatomic, copy) void(^tapViewChoice)(void);

@property (nonatomic, copy) void(^chooseResult)(NSString* result);
//选择时间
@property (nonatomic, copy) void(^timeChooseResult)(void);



+ (instancetype)cellForTableView:(UITableView*)tableView;

- (void)cellWithSportModel:(SportRecordModel*)model;



@end
