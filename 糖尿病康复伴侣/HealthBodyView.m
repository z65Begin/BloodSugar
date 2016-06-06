//
//  HealthBodyView.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "HealthBodyView.h"
#import "MedicinalWriteController.h"


@interface HealthBodyView ()


@end



@implementation HealthBodyView

+(id)healthBodyView{
    NSArray * objs = [[NSBundle mainBundle]loadNibNamed:@"HealthBodyView" owner:nil options:nil];
    return [objs lastObject];
}
- (void)awakeFromNib{
    [self cx_layerOfView:self.topButton1 WithColor:[UIColor redColor]];
    [self cx_layerOfView:self.topButton2 WithColor:blueColorWithRGB(61, 172, 225)];
    [self cx_layerOfView:self.topButton3 WithColor:[UIColor greenColor]];
    [self cx_layerOfView:self.topButton4 WithColor:[UIColor  orangeColor]];
    [self cx_layerOfView:self.topButton5 WithColor:blueColorWithRGB(210, 0, 0)];
    
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.foodView1];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.foodView2];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.foodView3];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.foodView4];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.foodView5];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.foodView6];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.foodView7];
    
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.sportView];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.bodySignView];
    [self cx_layerOfBlueColorAndConstentWidthOfWithView:self.medicineView];
    
}
- (void)cx_layerOfBlueColorAndConstentWidthOfWithView:(UIView*)view{
    view.layer.cornerRadius = 8.0f;
    view.layer.borderColor = blueColorWithRGB(61, 172, 225).CGColor;
    view.layer.borderWidth = 1.0f;
}

- (void)cx_layerOfView:(UIView*)view WithColor:(UIColor*)color{
    view.layer.cornerRadius = 8.0f;
    view.layer.borderColor = color.CGColor;
    view.layer.borderWidth = 2.0f;
}

@end
