//
//  MedicalWriteView.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MedicalWriteView.h"

@implementation MedicalWriteView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(id)medicinalWriteView
{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"MedicalWriteView" owner:nil options:nil];
    return [objs lastObject];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

@end
