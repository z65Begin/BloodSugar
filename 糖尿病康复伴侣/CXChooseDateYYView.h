//
//  CXChooseDateYYView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/18.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXChooseDateYYView : UIView

@property (nonatomic, copy) void(^chooseDate)(NSString * dateStr);

+ (id)viewWithXIBWithDate:(NSString*)dateStr;

@end
