//
//  foodDetailController.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/14.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "foodmodel.h"
@interface foodDetailController : UIViewController
@property(nonatomic)NSString * foodId;
@property(nonatomic) NSString * eatFoodTime;
@property(nonatomic) NSString * Intaketf;

@property (nonatomic, strong) NSString * date;

@end
