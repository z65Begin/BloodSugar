//
//  CXChooseDateView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/8.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXChooseDateView : UIView

@property (nonatomic, copy) void(^timeChoose)(NSString * timeStr);

+ (instancetype)viewWithXIBWithDate:(NSString*)dateStr;

- (void)viewAddToView:(UIView*)view;

@end
