//
//  homePageController.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageController : UIViewController
@property(nonatomic)NSString * UserID;
//刷新按钮点击事件
- (void)refreshDoctorView;
@end
