//
//  MoreSignVIew.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreSignVIew : UIView

@property (nonatomic, weak) IBOutlet UITextField * temperatureTF;

@property (nonatomic, weak) IBOutlet UITextField * blood1TF;

@property (nonatomic, weak) IBOutlet UITextField * blood2TF;

@property (nonatomic, weak) IBOutlet UITextField * blood3TF;

@property (nonatomic, weak) IBOutlet UITextField * blood4TF;

@property (nonatomic, weak) IBOutlet UITextField * Synthesis1TF;

@property (nonatomic, weak) IBOutlet UITextField * Synthesis2TF;

@property (nonatomic, weak) IBOutlet UITextField * Synthesis3TF;

@property (nonatomic, weak) IBOutlet UITextField * Synthesis4TF;

@property (nonatomic, weak) IBOutlet UITextField * Synthesis5TF;

@property (nonatomic, weak) IBOutlet UITextField * Synthesis6TF;

@property (nonatomic, weak) IBOutlet UIButton * ear1Btn;
@property (nonatomic, weak) IBOutlet UIButton * ear2Btn;
@property (nonatomic, weak) IBOutlet UIButton * ear3Btn;
@property (nonatomic, weak) IBOutlet UIButton * ear4Btn;
@property (nonatomic, weak) IBOutlet UIButton * ear5Btn;
@property (nonatomic, weak) IBOutlet UIButton * ear6Btn;

@property (nonatomic, weak) IBOutlet UIButton * footer1Btn;
@property (nonatomic, weak) IBOutlet UIButton * footer2Btn;
@property (nonatomic, weak) IBOutlet UIButton * footer3Btn;

@property (nonatomic, weak) IBOutlet UIView * earView;
@property (nonatomic, weak) IBOutlet UIView * footerView;


+ (instancetype)viewWithXIB;



@end
