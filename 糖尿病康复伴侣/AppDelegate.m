//
//  AppDelegate.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/1.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "RootNavigationController.h"
#import "HomePageController.h"
#import "Reachability.h"

@interface AppDelegate ()
@property (nonatomic, strong) Reachability * internetReachability;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     [WXApi registerApp:@"wx96d89fec71d2708c"];
    self.window.backgroundColor = [UIColor whiteColor];
    LoginViewController * login = [[LoginViewController alloc]init];

    IQKeyboardManager * manager = [IQKeyboardManager sharedManager];
//    manager.canGoNext = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    
    
//    //获取UserDefault
//     NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
//    NSString* name = [user objectForKey:USER_ID];
    
//    NSString * pass = [user objectForKey:USER_PWD];
//    if (name!= nil && pass!=nil) {
//       
//        RootNavigationController * rootNav = [[RootNavigationController alloc]initWithRootViewController:login];
//        self.window.rootViewController = rootNav;
//    }else{
    //添加一个系统通知
    //初始化
    self.internetReachability=[Reachability reachabilityForInternetConnection];
    //通知添加到Run Loop
    [self.internetReachability startNotifier];
  
    
    RootNavigationController * rootNav = [[RootNavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController = rootNav;
    NSLog(@"%@",NSHomeDirectory());
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

-  (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}


@end
