//
//  healthHeadView.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "HealthHeadView.h"

@implementation HealthHeadView

+(id)healthHeadView
{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"HealthHeadView" owner:nil options:nil];
    return [objs lastObject];
}

-(void)awakeFromNib
{

}


@end
