//
//  ShareChooseView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/12.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareChooseView : UIView

@property (nonatomic, copy) void(^shareChoice)(NSInteger) ;

+ (instancetype)viewWithXIB;

@end
