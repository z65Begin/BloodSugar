//
//  SportListHeadView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/4.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportListHeadView : UIView

@property (nonatomic, weak) IBOutlet UILabel * hintLabel;
@property (nonatomic, weak) IBOutlet UIButton * addNewButton;
@property (nonatomic, weak) IBOutlet UIView * hiddenView;
@property (nonatomic, weak) IBOutlet UIView * hiddenView1;
+ (instancetype)viewWithXIB;
- (void)viewHiddenSubView:(BOOL)hidden;
@end
