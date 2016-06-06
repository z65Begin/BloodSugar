//
//  MoreSignVIew.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MoreSignVIew.h"

@interface MoreSignVIew ()<UITextFieldDelegate>

@end

@implementation MoreSignVIew

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{


}

- (IBAction)buttonOfFundusClick:(UIButton*)sender{
    for (UIView * view in self.earView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)view;
            button.selected = NO;
        }
    }
    sender.selected = YES;
}
- (IBAction)buttonPlantarClick:(UIButton*)sender{
    sender.selected = !sender.selected;
    sender.showsTouchWhenHighlighted = YES;
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    
    return YES;
}


+ (instancetype)viewWithXIB{
    MoreSignVIew * view = [[[NSBundle mainBundle]loadNibNamed:@"MoreSignView" owner:self options:nil] firstObject];
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height = 720;
    view.frame = frame;
    return view;
}
@end
