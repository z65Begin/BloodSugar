//
//  KeyChainHelper.h
//  KeyChainDemo
//
//  Created by 倪敏杰 on 12-7-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainHelper : NSObject
///保存用户名
+ (void) saveUserName:(NSString*)userName 
      userNameService:(NSString*)userNameService 
             psaaword:(NSString*)pwd 
      psaawordService:(NSString*)pwdService;
///删除用户吗
+ (void) deleteWithUserNameService:(NSString*)userNameService 
                   psaawordService:(NSString*)pwdService;
///获取用户名
+ (NSString*) getUserNameWithService:(NSString*)userNameService;
///获取密码
+ (NSString*) getPasswordWithService:(NSString*)pwdService;

@end
