//
//  ChooseUnit.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseUnit : UIView

@property (nonatomic, copy) void(^chooseUnit)(NSString* name);

+ (id)viewWithXIB;


@end
