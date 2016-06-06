//
//  AppDelegate.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/1.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"
#import "WXApi.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;
//用户信息
@property(nonatomic,strong)UserInfoModel *userInfo;
@property(nonatomic,assign)BOOL connect;

@end

