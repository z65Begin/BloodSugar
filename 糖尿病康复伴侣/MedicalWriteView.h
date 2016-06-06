//
//  MedicalWriteView.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MedicalWriteView : UIView
@property (weak, nonatomic) IBOutlet UITextField *medicinalNameTF;//药名textfield
@property (weak, nonatomic) IBOutlet UIButton *chooseMedicinalBtn1;//选择药名按钮

@property (weak, nonatomic) IBOutlet UITextField *eatTimesEveryDay;//每日吃几次
@property (weak, nonatomic) IBOutlet UITextField *everyTimesUsed;//每次吃多少
@property (weak, nonatomic) IBOutlet UITextField *everyTimesunit;//单位
@property (weak, nonatomic) IBOutlet UIButton *uiitChooseBtn;//单位选择按钮

@property (weak, nonatomic) IBOutlet UITextView *explain;//说明内容


+(id)medicinalWriteView;
@end
