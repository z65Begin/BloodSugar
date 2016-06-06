//
//  collectionTableViewCell.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface collectionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *serialNumber;//序号

@property (weak, nonatomic) IBOutlet UILabel *remarks;//备注
@property (weak, nonatomic) IBOutlet UILabel *collectTime;//收藏时间


@end
