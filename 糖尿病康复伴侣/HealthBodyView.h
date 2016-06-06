//
//  HealthBodyView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthBodyView : UIView

@property (nonatomic, weak) IBOutlet UIButton * topButton1;
@property (nonatomic, weak) IBOutlet UIButton * topButton2;
@property (nonatomic, weak) IBOutlet UIButton * topButton3;
@property (nonatomic, weak) IBOutlet UIButton * topButton4;
@property (nonatomic, weak) IBOutlet UIButton * topButton5;

@property (nonatomic, weak) IBOutlet UILabel * topLabel;
@property (nonatomic, weak) IBOutlet UIImageView * proteinIV;
@property (nonatomic, weak) IBOutlet UIImageView * fatIV;
@property (nonatomic, weak) IBOutlet UIImageView * carbsIV;


@property (nonatomic, weak) IBOutlet UIButton * sportEvaluate;//运动评价

@property (nonatomic, weak) IBOutlet UIButton * evaluate;

@property (weak, nonatomic) IBOutlet UIButton *sportCataBtn; //运动种类

@property (weak, nonatomic) IBOutlet UIButton *breakfastBtn;//早餐

@property (weak, nonatomic) IBOutlet UIButton *addBreakBtn;//上午加餐

@property (weak, nonatomic) IBOutlet UIButton *lunchBtn;//午餐
@property (weak, nonatomic) IBOutlet UIButton *addLunchBtn;//下午加餐

@property (weak, nonatomic) IBOutlet UIButton *dinnerBtn;//晚餐
@property (weak, nonatomic) IBOutlet UIButton *addDinnerBtn;//夜宵
@property (weak, nonatomic) IBOutlet UIButton *signBtn;//体征按钮
@property (weak, nonatomic) IBOutlet UIButton *medicinalBtn;//用药按钮
@property(weak,nonatomic)IBOutlet UIButton * smokeBtn;//非饮食（抽烟）

/**************** 时间 *********************/
@property (weak, nonatomic) IBOutlet UILabel *breakfastTime;//早餐时间
@property (weak, nonatomic) IBOutlet UILabel *morningAddFoodTime;//上午加餐时间

@property (weak, nonatomic) IBOutlet UILabel *lunchTime;//午餐时间

@property(weak,nonatomic)IBOutlet UILabel * afternoonAddFoodTime;//下午加餐时间
@property(weak,nonatomic)IBOutlet UILabel * dinnerTime;//晚餐时间
@property (weak, nonatomic) IBOutlet UILabel *afterDinnerEatFoodTime;//夜宵时间

@property (weak, nonatomic) IBOutlet UILabel *smokeTime;//非饮食（抽烟时间）

/**************** 食物 *********************/

@property (nonatomic, weak) IBOutlet UIView * foodView1;
@property (nonatomic, weak) IBOutlet UIView * foodView2;
@property (nonatomic, weak) IBOutlet UIView * foodView3;
@property (nonatomic, weak) IBOutlet UIView * foodView4;
@property (nonatomic, weak) IBOutlet UIView * foodView5;
@property (nonatomic, weak) IBOutlet UIView * foodView6;
@property (nonatomic, weak) IBOutlet UIView * foodView7;

//@property (nonatomic, weak) IBOutlet UIView * foodView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *breakHeight;    // 早餐的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *breakAddHeight; // 早餐加餐的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lunchHeight;    // 午餐的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lunchAddHeight; // 午餐加餐的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dinnerHeight;   // 晚餐的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dinnerAddHeight;// 夜宵的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *smokeHeight;    // 非饮食的高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foodHeight;    //总的高度  食物


+(id)healthBodyView;


@property (weak, nonatomic) IBOutlet UIView *foodView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *foodTop;

/*********************** 运动 *************************/
@property (nonatomic, weak) IBOutlet UIView * sportView;
@property (nonatomic, weak) IBOutlet UILabel * sportTotalLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * sportHeight;

/*********************** 体征 *************************/
@property (nonatomic, weak) IBOutlet UIView * bodySignView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * bodySignHeight;

/*********************** 用药 *************************/
@property (nonatomic, weak) IBOutlet UIView * medicineView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * medicineHeight;


@end
