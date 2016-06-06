//
//  ChangeViewTextField.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "ChangeViewTextField.h"

@interface ChangeViewTextField ()

@property (nonatomic, weak) IBOutlet UILabel * nameLabel ;
@property (nonatomic, weak) IBOutlet UITextField * nameTF;

@property (nonatomic, weak) IBOutlet UIButton * cancelBtn;
@property (nonatomic, weak) IBOutlet UIButton * sureBrn;

@property (nonatomic, weak) IBOutlet UIView * backView;

- (IBAction)cancelBtnClick:(id)sender;
- (IBAction)sureBtnClick:(id)sender;
@end

@implementation ChangeViewTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.sureBrn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sureBrn.layer.borderWidth = 0.5f;
    self.cancelBtn.layer.borderWidth = 0.5f;
    self.cancelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;

    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick:)];
    
    [self.backView addGestureRecognizer:tapGR];
    
}
- (void)backClick:(UITapGestureRecognizer*)tapGR{
    [self removeFromSuperview];
}
- (void)sureBtnClick:(id)sender{
    if (self.changeName) {
        if (self.nameTF.text) {
            self.changeName(self.nameTF.text);
        }
    }
    [self backClick:nil];
}

- (void)cancelBtnClick:(id)sender{
    [self backClick:nil];
}

+ (id)viewWithXibWithName:(NSString*)name andContent:(NSString*)content{
   ChangeViewTextField* view  = [[[NSBundle mainBundle]loadNibNamed:@"ChangeViewTextField" owner:self options:nil]firstObject];
    view.nameLabel.text = name;
    view.nameTF.text = content;
    view.frame = CGRectMake(0, 0, W, H);
    return view;
}


@end
