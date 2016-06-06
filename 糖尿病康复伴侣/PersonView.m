//
//  personView.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/19.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "PersonView.h"

@implementation PersonView

+(id)PersonView
{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"PersonView" owner:nil options:nil];
    return [objs lastObject];
}

@end
