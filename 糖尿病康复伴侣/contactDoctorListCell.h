//
//  contactDoctorListCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/15.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "TableViewCell.h"

@interface contactDoctorListCell : TableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLable;//标题

@property (weak, nonatomic) IBOutlet UIImageView *senderImageView;//发送人图片

@property (weak, nonatomic) IBOutlet UILabel *senderName;//发送人名字

@property (weak, nonatomic) IBOutlet UIImageView *isNew;//是否应景读取


@end
