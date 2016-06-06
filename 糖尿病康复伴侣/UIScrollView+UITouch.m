//
//  UIScrollView+UITouch.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/1.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView(UITouch)


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}
@end
