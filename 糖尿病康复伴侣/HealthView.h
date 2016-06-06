//
//  HealthView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "healthHeadView.h"
#import "HealthBodyView.h"
@interface HealthView : UIView<UIScrollViewDelegate>

@property(nonatomic,strong)HealthHeadView * healthHeadView;

@property(nonatomic,weak)UIScrollView * healthScrollView;

@property(nonatomic,strong)HealthBodyView * healthBodyView;


//食物点击事件的回传
@property (nonatomic, copy) void(^changeFoodRecord)(NSInteger integer,NSArray * foodArray);
//运动点击事件的回传
@property (nonatomic, copy) void(^changeSportRecord)(void);
//血糖和体征点击事件的回传
@property (nonatomic, copy) void(^changeBloodSugarAndBodySign)(void);

@property (nonatomic, copy) void(^changeMedicineRecord)(void);

+(instancetype)healthView;
//改变食物记录的高度
- (CGFloat)changeWithFoodRecordArray:(NSArray *)foodRecordArray;
//改变运动记录的高度
- (CGFloat)changeWithSportRecord:(NSArray*)sportRecordArray;
//改变体征和血糖的高度 根据数据改变
- (CGFloat)changeWithBodySignWithBloodSugarArray:(NSArray*)bloodSugarArray andBodySignModel:(BodySignModel*)bodySignM;
//改变用药的高度 根据数据改变 
- (CGFloat)changeWithMedicineArray:(NSArray*)medicineArray;
/**
 *隐藏食物栏
 */
- (void)hiddenFoodView:(BOOL)hidden;
@end
