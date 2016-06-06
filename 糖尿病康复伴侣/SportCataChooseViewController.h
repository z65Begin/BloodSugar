//
//  SportCataChooseViewController.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportCataChooseViewController : UIViewController

@property (nonatomic, copy) void(^chooseSportCata)(sportCataModel* model) ;

@end
