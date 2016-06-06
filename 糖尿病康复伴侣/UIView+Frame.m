//
//  UIView+Frame.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView(Frame)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setX:(CGFloat)x
{
         CGRect frame = self.frame;
         frame.origin.x = x;
         self.frame = frame;
}

-(CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
}
-(CGFloat)y{
return self.frame.origin.y;
 }
-(void)setOrigin:(CGPoint)origin{
         CGRect frame = self.frame;
         frame.origin = origin;
         self.frame = frame;
     }
-(CGPoint)origin
{
         return self.frame.origin;
 }
-(void)setWidth:(CGFloat)width{
        CGRect frame = self.frame;
        frame.size.width = width;
        self.frame = frame;
}
-(CGFloat)width{
return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)height{
  return self.frame.size.height;
}

-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGSize)size{
       return self.frame.size;
}

@end
