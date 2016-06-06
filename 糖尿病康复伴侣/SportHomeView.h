//
//  SportHomeView.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/11.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SportHomeView : UIView

@property(nonatomic, strong)UIButton * button;

+ (instancetype)viewWithXIB;

- (void)viweWithSportRecordModel:(SportRecordModel*)model;
@end
