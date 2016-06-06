//
//  CXChooseDateView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/8.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "CXChooseDateView.h"

@interface CXChooseDateView ()

@property (nonatomic, weak) IBOutlet UIDatePicker * datePickker;

@property (nonatomic, weak) IBOutlet UIButton * chooseBtn;

@property (nonatomic, strong) UIView * backView;

- (IBAction)timeChoose:(UIButton*)sender;


@end






@implementation CXChooseDateView

+ (instancetype)viewWithXIBWithDate:(NSString*)dateStr{
    CXChooseDateView * view = [[[NSBundle mainBundle]loadNibNamed:@"CXChooseDateView" owner:self options:nil] firstObject];
    view.datePickker.date = [UtilCommon strFormateDate:dateStr];
    view.datePickker.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*60*60];
    view.frame = CGRectMake(20, (H-460)/2, W-40, 280);
    return view;
}
- (void)timeChoose:(UIButton *)sender{
    //  NSString * dateStr = [UtilCommon stringData_mm_ssFromStr:[UtilCommon dateStr:self.datePickker.date]];
    NSString* date1 =[UtilCommon dateStr:self.datePickker.date];
    self.timeChoose(date1);
    [self removeFromSuperview];
    [self.backView removeFromSuperview];
}
- (void)viewAddToView:(UIView*)view{
    UIView * backView = [[UIView alloc]init];
    backView.frame = view.bounds;
    backView.backgroundColor = [UIColor darkGrayColor];
    backView.alpha = 0.8f;
    
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewTap:)];
    [view addGestureRecognizer:tapGR];
    [view addSubview:backView];
    [view addSubview:self];
    self.backView = backView;
}
- (void)backViewTap:(UITapGestureRecognizer*)tapGR{
    [self.backView removeFromSuperview];
    [self removeFromSuperview];
}


@end
