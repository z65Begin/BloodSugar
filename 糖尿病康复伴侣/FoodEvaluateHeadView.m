//
//  FoodEvaluateHeadView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/10.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FoodEvaluateHeadView.h"

@implementation FoodEvaluateHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    self.bigView.layer.cornerRadius = 50.0f;
    self.littleView.layer.cornerRadius = 40.0f;
    self.bigView.layer.borderColor = [UIColor grayColor].CGColor;
    self.bigView.layer.borderWidth = 1.0f;
    self.littleView.layer.borderWidth = 0.5f;
    self.littleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    CALayer * protein = [self layerFromView];
    [self.proteinView.layer addSublayer:protein];
    self.protein = protein;
    CALayer * fat = [self layerFromView];
    [self.fatView.layer addSublayer:fat];
    self.fat = fat;
    CALayer * carbs = [self layerFromView];
    [self.carbohydrateView.layer addSublayer:carbs];
    self.carbs = carbs;
    
    self.proteinView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.proteinView.layer.borderWidth = 0.5f;
    self.fatView.layer.borderWidth = 0.5f;
    self.fatView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.carbohydrateView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.carbohydrateView.layer.borderWidth = 0.5f;
    
    
}
+ (instancetype)viewWithXIB{
 FoodEvaluateHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"FoodEvaluateHeadView" owner:self options:nil]firstObject];
    return headView;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSString * heightProtein = [FileUtils getValueUsingcode:@"002"];
    NSString * lowProtein = [FileUtils getValueUsingcode:@"003"];
    CALayer * layerProtein = [self layerFromView];
    CGRect frame = self.proteinView.bounds;
    frame.origin.x = frame.size.width * (lowProtein.floatValue/100.0);
    frame.size.width = 1;
    layerProtein.frame = frame;
    [self.proteinView.layer addSublayer:layerProtein];
    frame.origin.x = self.proteinView.frame.size.width * (heightProtein.floatValue/100.0);
    CALayer * layerProteinHigh = [self layerFromView];
    layerProteinHigh.frame = frame;
    [self.proteinView.layer addSublayer:layerProteinHigh];
   
    NSString * highFat = [FileUtils getValueUsingcode:@"004"];
    NSString * lowFat = [FileUtils getValueUsingcode:@"005"];
    CALayer * layerFatLow = [self layerFromView];
    frame.origin.x = self.fatView.bounds.size.width * (lowFat.floatValue/100.0);
    layerFatLow.frame = frame;
    [self.fatView.layer addSublayer:layerFatLow];
    CALayer * layerFatHigh = [self layerFromView];
    frame.origin.x = self.fatView.bounds.size.width * (highFat.floatValue/100.0);
    layerFatHigh.frame = frame;
    [self.fatView.layer addSublayer:layerFatHigh];
    
//    self.fatView
    NSString * highCarbohydrate = [FileUtils getValueUsingcode:@"006"];
    NSString * lowCarbohydrate = [FileUtils getValueUsingcode:@"007"];
    CALayer * layerCarbohydrateLow = [self layerFromView];
    frame.origin.x = self.carbohydrateView.bounds.size.width * (lowCarbohydrate.floatValue/100.0);
    layerCarbohydrateLow.frame = frame;
    [self.carbohydrateView.layer addSublayer:layerCarbohydrateLow];
    CALayer * layerCarbohydrateHigh = [self layerFromView];
    frame.origin.x = self.carbohydrateView.bounds.size.width * (highCarbohydrate.floatValue/100.0);
    layerCarbohydrateHigh.frame = frame;
    [self.carbohydrateView.layer addSublayer:layerCarbohydrateHigh];
//self.carbohydrateView
    

}
- (CALayer*)layerFromView{
    CALayer * layer = [[CALayer alloc]init];
    layer.backgroundColor = blueColorWithRGB(61, 172, 225).CGColor;
    return layer;
}


@end
