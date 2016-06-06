//
//  MedicineHomeView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/16.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MedicineHomeView.h"

#import "MedicineRecordModel.h"
@interface MedicineHomeView ()

@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * unitLabel;
@property (nonatomic, strong) UILabel * valueLabel;
@property (nonatomic, strong) UILabel * secondLabel;
@property (nonatomic, strong) UILabel * computerLabel;

@end

@implementation MedicineHomeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init{
    if (self = [super init]) {
        CGFloat  height = 24.0f;
        CGFloat width = W - 10;
        UILabel * nameLabel = [self buildLabelWithTextAlight:NSTextAlignmentLeft];
        nameLabel.frame = CGRectMake(5, -4, 150, height+8);
        self.nameLabel = nameLabel;
        
        UILabel * unitLabel = [self buildLabelWithTextAlight:NSTextAlignmentLeft];
        unitLabel.frame = CGRectMake(width - 25 - 5, 0, 25, height);
        self.unitLabel = unitLabel;
        unitLabel.text = @"次";
        
        UILabel * secondLabel = [self buildLabelWithTextAlight:NSTextAlignmentRight];
        secondLabel.textColor = blueColorWithRGB(61, 172, 225);
        secondLabel.frame = CGRectMake(CGRectGetMinX(unitLabel.frame) - 50, 0, 50, height);
        self.secondLabel = secondLabel;
        
        UILabel * computerLabel = [self buildLabelWithTextAlight:NSTextAlignmentCenter];
        computerLabel.frame = CGRectMake(CGRectGetMinX(secondLabel.frame) - 8-2 , 0, 8, height);
        computerLabel.text = @"×";
        self.computerLabel = computerLabel;
        
        UILabel * valueLabel = [self buildLabelWithTextAlight:NSTextAlignmentRight];
        valueLabel.textColor = blueColorWithRGB(61, 172, 225);
        valueLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame), -3, CGRectGetMinX(computerLabel.frame)- CGRectGetMaxX(nameLabel.frame), height+6);
        self.valueLabel = valueLabel;
        
        [self addSubview:nameLabel];
        [self addSubview:unitLabel];
        [self addSubview:secondLabel];
        [self addSubview:computerLabel];
        [self addSubview:valueLabel];
    }
    return self;
}
+(id)viewCreat{
    MedicineHomeView * view = [[MedicineHomeView alloc]init];
    view.frame = CGRectMake(0, 0, W-10,24);
    view.userInteractionEnabled = YES;
    return view;
}
- (void)viewWithMedicineModel:(MedicineRecordModel*)model{
    self.nameLabel.text = model.MedName;
    self.valueLabel.text = [NSString stringWithFormat:@"%@%@",model.AMountUnit,model.UnitName];
    self.secondLabel.text = model.AmountTimes;
}


- (UILabel*)buildLabelWithTextAlight:(NSTextAlignment)textAlight{
    UILabel * label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textAlignment = textAlight;
    return label;
}
@end
