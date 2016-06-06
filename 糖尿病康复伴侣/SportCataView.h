//
//  SportCataView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/23.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sportCataModel.h"

@interface SportCataView : UIView

@property(nonatomic,strong)NSArray * objs;
@property(nonatomic,strong)sportCataModel * sportModel;
@property (weak, nonatomic) IBOutlet UILabel *taijiLab;
@property (weak, nonatomic) IBOutlet UILabel *taijiHotLab;

@property (weak, nonatomic) IBOutlet UILabel *gcwLab;//广场舞
@property (weak, nonatomic) IBOutlet UILabel *gcwHotLab;

@property (weak, nonatomic) IBOutlet UILabel *kzLab;//快走
@property (weak, nonatomic) IBOutlet UILabel *kzHotLab;

@property (weak, nonatomic) IBOutlet UILabel *kbLab;//快速骑行
@property (weak, nonatomic) IBOutlet UILabel *kbHotLab;

@property (weak, nonatomic) IBOutlet UILabel *mzLab;//慢走
@property (weak, nonatomic) IBOutlet UILabel *mzHotLab;

@property (weak, nonatomic) IBOutlet UILabel *mbLab;//慢速骑行
@property (weak, nonatomic) IBOutlet UILabel *mbHotLab;

@property (weak, nonatomic) IBOutlet UILabel *pbLab;//打篮球
@property (weak, nonatomic) IBOutlet UILabel *pbHotLab;

@property (weak, nonatomic) IBOutlet UILabel *ptbLab;//普通骑行
@property (weak, nonatomic) IBOutlet UILabel *ptbHotLab;

@property (weak, nonatomic) IBOutlet UILabel *mlqLab;//木兰拳
@property (weak, nonatomic) IBOutlet UILabel *mlqHotLab;

@property (weak, nonatomic) IBOutlet UILabel *swingLab;//游泳
@property (weak, nonatomic) IBOutlet UILabel *swHotLab;

@property (weak, nonatomic) IBOutlet UILabel *runLab;//跑步
@property (weak, nonatomic) IBOutlet UILabel *runHotLab;

@property (weak, nonatomic) IBOutlet UILabel *tsLab;//跳绳
@property (weak, nonatomic) IBOutlet UILabel *tsHotLab;

+(id)sportCataView;
@end
