//
//  ShareChooseView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/12.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "ShareChooseView.h"

@interface ShareChooseView ()

- (IBAction)shareToFriend:(UIButton*)sender;
- (IBAction)shareToTimeLine:(UIButton*)sender;



@end

@implementation ShareChooseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick:)];

    [self addGestureRecognizer:tapGR];
    
}
- (void)backClick:(UITapGestureRecognizer*)tapGR{
    self.shareChoice(10);
    
    [self removeFromSuperview];
}
- (void)shareToFriend:(UIButton *)sender{
    self.shareChoice(0);
    [self removeFromSuperview];
}
- (void)shareToTimeLine:(UIButton *)sender{
    self.shareChoice(1);
    [self removeFromSuperview];
}


+ (instancetype)viewWithXIB{
    CGRect frame = CGRectMake(0, 0, W, H);
    ShareChooseView * view = [[[NSBundle mainBundle]loadNibNamed:@"ShareChooseView" owner:self options:nil] firstObject];
    view.frame = frame;
    return view;
}


@end
