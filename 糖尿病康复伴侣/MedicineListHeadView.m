//
//  MedicineListHeadView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MedicineListHeadView.h"

@implementation MedicineListHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (id)viewWithXIB{
   MedicineListHeadView * view = [[[NSBundle mainBundle]loadNibNamed:@"MedicineListHeadView" owner:self options:nil] firstObject];
    view.frame = CGRectMake(0, 0, W, 42);
    
    return  view;
}


@end
