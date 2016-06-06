//
//  SignBloodSugarView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SignBloodSugarView.h"

@implementation SignBloodSugarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)viewWithXIB{

    
    return [[[NSBundle mainBundle] loadNibNamed:@"SignBloodSugarView" owner:self options:nil]lastObject];

}
@end
