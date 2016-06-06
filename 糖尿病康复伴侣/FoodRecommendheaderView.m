//
//  FoodRecommendheaderView.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FoodRecommendheaderView.h"

@implementation FoodRecommendheaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(id)FoodRecommendheaderView{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"FoodRecommendheaderView" owner:self options:nil];
    return [objs lastObject];
}
@end
