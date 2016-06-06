//
//  SignFooterView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignFooterView : UIView

@property (nonatomic, weak) IBOutlet UITextField * weightTF;

@property (nonatomic, weak) IBOutlet UITextField * heightPersureTF;
@property (nonatomic, weak) IBOutlet UITextField * lowPersureTF;

+ (instancetype)viewWithXIB;

@end
