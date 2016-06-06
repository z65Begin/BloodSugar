//
//  personView.h
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/19.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonView : UIView

+(id)PersonView;


@property (weak, nonatomic) IBOutlet UIButton *personInfo;//个人信息

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *uid;

@property (weak, nonatomic) IBOutlet UIButton *changePassword;//更改密码

@property (weak, nonatomic) IBOutlet UIButton *set;//设置

@property (weak, nonatomic) IBOutlet UIButton *about;//关于



@property (weak, nonatomic) IBOutlet UIButton *exit;//退出


@end
