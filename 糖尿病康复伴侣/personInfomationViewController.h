//
//  personInfomationViewController.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/15.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface personInfomationViewController : UIViewController

@property (nonatomic, copy) void (^changeViewController)(NSString * userID) ;

@end
