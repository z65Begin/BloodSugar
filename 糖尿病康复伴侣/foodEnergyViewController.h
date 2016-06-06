//
//  foodEnergyViewController.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface foodEnergyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *chooseFoodLable;//选择食物标签
@property (weak, nonatomic) IBOutlet UILabel *chengfenLable;//成分标签

@property (weak, nonatomic) IBOutlet UILabel *proteinEvery100;//100克含有的蛋白质

@property (weak, nonatomic) IBOutlet UILabel *FatEvery100;//100克含有的脂肪

@property (weak, nonatomic) IBOutlet UILabel *carbohydrateEvery100;//100克含有的碳水化合物

@property (weak, nonatomic) IBOutlet UILabel *sumEnergy;//总热量

@property (weak, nonatomic) IBOutlet UILabel *protein;//蛋白质

@property (weak, nonatomic) IBOutlet UILabel *fat;//脂肪

@property (weak, nonatomic) IBOutlet UILabel *carbohydrate;//碳水化合物

@property (weak, nonatomic) IBOutlet UITextField *Intake;//摄入量

@property (weak, nonatomic) IBOutlet UIButton *calculate;//计算

@end
