//
//  SportDayAddViewController.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/5.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class sportCataModel;
@interface SportDayAddViewController : UIViewController

@property (nonatomic, strong) sportCataModel * cataModel;

@property (nonatomic, copy) NSString * date;

@property (nonatomic, copy) NSString * userId;


@end
