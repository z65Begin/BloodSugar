//
//  MedicineChooseController.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class medicineListModel;

@interface MedicineChooseController : UIViewController

@property (nonatomic, copy) void(^chooseMedicine)(medicineListModel * model);

@end
