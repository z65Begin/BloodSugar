//
//  ToolBoxView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/19.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToolBoxView : UIView

+(id)toolBoxView;
@property (weak, nonatomic) IBOutlet UIButton *foodEnergyCalculate;//食物能量计算


@property (weak, nonatomic) IBOutlet UIButton *foodListRecommend;//食谱推荐


@property (weak, nonatomic) IBOutlet UIButton *cleanCache;//清理缓存





@end
