//
//  SportOtherDayAddViewController.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/8.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportOtherDayAddViewController : UIViewController

@property (nonatomic, copy) NSString * date;

@property (nonatomic, copy) NSString * userId;

@property (nonatomic, copy) void(^nameBlock)(void);

@end
