//
//  innerMailCell.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/11.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface innerMailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *readEmailState;

@property (weak, nonatomic) IBOutlet UILabel *senderName;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIImageView *addFiles;//附件

@property (weak, nonatomic) IBOutlet UILabel *emailDescription;

@end
