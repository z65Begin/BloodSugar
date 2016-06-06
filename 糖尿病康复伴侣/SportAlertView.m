//
//  SportAlertView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportAlertView.h"

@interface SportAlertView ()

@property (nonatomic, weak) IBOutlet UIButton * button1;
@property (nonatomic, weak) IBOutlet UIButton * button2;
@property (nonatomic, weak) IBOutlet UIButton * button3;
@property (nonatomic, weak) IBOutlet UIButton * button4;
@property (nonatomic, weak) IBOutlet UIButton * chooseButton;

- (IBAction)buttonClick:(UIButton*)sender;
- (IBAction)chooseButtonClick:(UIButton*)sender;

@end


@implementation SportAlertView

- (void)awakeFromNib{
    self.button1.selected = YES;
    self.button1.backgroundColor = blueColorWithRGB(61, 172, 225);
}

- (void)buttonClick:(UIButton *)sender{
    for (UIView* view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton*)view;
            button.selected = NO;
            button.backgroundColor = [UIColor clearColor];
        }
    }
    sender.selected = YES;
    sender.backgroundColor = blueColorWithRGB(61, 172, 225);
}
- (void)chooseButtonClick:(UIButton *)sender{
            if (self.button1.selected) {
                self.chooseChildResult(SPORT_Result_00);
                return;
            }
            if ( self.button2.selected) {
                self.chooseChildResult(SPORT_Result_01);
                return;
            }
            if (self.button3.selected) {
                self.chooseChildResult(SPORT_Result_02);
                return;
            }
            if (self.button4.selected) {
                self.chooseChildResult(SPORT_Result_03);
                return;
            }

    
}

+ (instancetype)viewWithXIB{
   return [[[NSBundle mainBundle]loadNibNamed:@"SportAlertView" owner:self options:nil]firstObject];
}


@end
