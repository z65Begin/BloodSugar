//
//  SignFooterView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SignFooterView.h"

@interface SignFooterView ()<UITextFieldDelegate>

@end

@implementation SignFooterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)awakeFromNib{
    self.heightPersureTF.delegate = self;
    self.lowPersureTF.delegate = self;
    self.weightTF.delegate = self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
//    if ( self.weightTF.text.floatValue > 1000) {
//        [UtilCommon alertView:@"提示" andMessage:@"请参照99.9输入"];
//    }
//    if (self.heightPersureTF.text.floatValue < self.lowPersureTF.text.floatValue) {
//        [UtilCommon alertView:@"提示" andMessage:@"低压必须小于高压"];
//    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length >= 3) {
//        return YES;
        textField.text = [textField.text substringToIndex:2];
    }
    return YES;
}

+ (instancetype)viewWithXIB{
    return[[[NSBundle mainBundle]loadNibNamed:@"SignFooterView" owner:self options:nil] firstObject];
}


@end
