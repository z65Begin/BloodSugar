//
//  DoctorView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/19.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorView : UIView

+(id)doctorView ;

@property (weak, nonatomic) IBOutlet UIButton *consultButton;

@property (weak, nonatomic) IBOutlet UIButton *refreshButton;

@property (weak, nonatomic) IBOutlet UILabel *dataLable;

@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end
