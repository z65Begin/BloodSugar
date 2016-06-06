//
//  MethodView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MethodView.h"

@implementation MethodView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)viewWithXib{
//   MethodView * view = [[[NSBundle mainBundle]loadNibNamed:@"MethodView" owner:self options:nil]firstObject];
    MethodView * view = [[MethodView alloc]init];
    view.frame = CGRectMake(0, 0, W-61, 24);
    return view;
}
- (id)init{
    if (self = [super init]) {
       
        UILabel * label1 = [[UILabel alloc]init];
        label1.frame  = CGRectMake(W-61-10-30, 0, 30, 24);
        label1.font = [UIFont systemFontOfSize:12.0f];
        label1.textAlignment = NSTextAlignmentLeft;
        self.unitLabel = label1;
        UILabel * intakeLabel = [[UILabel alloc]init];
        intakeLabel.textAlignment = NSTextAlignmentRight;
        intakeLabel.font = [UIFont systemFontOfSize:12.0f];
        intakeLabel.textColor = blueColorWithRGB(61, 172, 225);
      
        intakeLabel.frame = CGRectMake(CGRectGetMinX(label1.frame) - 60, 0, 60, 24);
        self.intakeLael = intakeLabel;
        UILabel * label = [[UILabel alloc]init];
        label.frame = CGRectMake(10, 0, CGRectGetMinX(intakeLabel.frame), 24);
        //        label.text = @"damajiaoyu";
        label.font = [UIFont systemFontOfSize:12.0f];
        self.nameLabel = label;
//          NSLog(@"CGRectGetMaxX(label.frame)==%f  ==== %f",CGRectGetMaxX(label.frame),CGRectGetMinX(label1.frame));
        [self addSubview:label];
        [self addSubview:label1];
        [self addSubview:intakeLabel];
        
    }
    return self;
}

- (void)layoutSubviews{
}

@end
