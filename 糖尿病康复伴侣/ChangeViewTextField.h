//
//  ChangeViewTextField.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeViewTextField : UIView

@property (nonatomic, copy) void(^changeName)(NSString * name);

+ (id)viewWithXibWithName:(NSString*)name andContent:(NSString*)content;

@end
