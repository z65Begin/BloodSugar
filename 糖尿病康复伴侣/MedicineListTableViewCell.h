//
//  MedicineListTableViewCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicineListTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIView * endView;

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UIButton * chooseBtn;

@property (nonatomic, weak) IBOutlet UITextField * timesTF;
@property (nonatomic, weak) IBOutlet UITextField * numTF;
@property (nonatomic, weak) IBOutlet UITextField * unitTF;
@property (nonatomic, weak) IBOutlet UIButton * noteBtn;
@property (nonatomic, weak) IBOutlet UIButton * deleteBtn;

@property (nonatomic, weak) IBOutlet UILabel * noteLabel;

//删除
@property (nonatomic, copy) void(^deleteBtnClick)(MedicineRecordModel * model);
//选择
@property (nonatomic, copy) void(^chooseMedicine)(void);
//改变药品名称
@property (nonatomic, copy) void(^inputMedicineName)(void);
//改变说明
@property (nonatomic, copy) void(^changeNote)(void) ;
//选择单位
@property (nonatomic, copy) void(^chooseUnit)(void);

+ (id)cellForTableView:(UITableView*)tableView;

- (void)cellWithModel:(MedicineRecordModel*)model;

@end
