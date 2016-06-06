//
//  personInfoView.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/16.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "personInfoView.h"

@implementation personInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    self.clinicalDiagnosisTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.clinicalDiagnosisTV.layer.borderWidth = 0.5f;
}

+(id)PersonInfoView
{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"personInfoView" owner:self options:nil];
    return [objs lastObject];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
