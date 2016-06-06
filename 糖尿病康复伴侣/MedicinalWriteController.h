//
//  MedicinalWriteController.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicinalWriteController : UIViewController
@property(nonatomic,strong)NSMutableArray * medicinalArrays;

@property (nonatomic, copy) NSString * userID;

@property (nonatomic, copy) NSString * date;

@property (nonatomic, copy) void(^chooseMedicine)(void);

@end
