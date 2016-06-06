//
//  SportListHeadView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/4.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportListHeadView.h"

@implementation SportListHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    self.hintLabel.layer.borderWidth = 0.5f;
    self.hintLabel.layer.borderColor = blueColorWithRGB(61, 172, 225).CGColor;
    self.hintLabel.layer.cornerRadius = 3.0f;
}

- (void)viewHiddenSubView:(BOOL)hidden{
    self.hintLabel.hidden = hidden;
    self.hiddenView1.hidden = hidden;
    self.hiddenView.hidden = !hidden;
}

+ (instancetype)viewWithXIB{
    return [[[NSBundle mainBundle]loadNibNamed:@"SportListHeadView" owner:self options:nil]firstObject];
}


@end
