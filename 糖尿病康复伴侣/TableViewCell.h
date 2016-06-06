//
//  TableViewCell.h
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLable;//名字
@property (weak, nonatomic) IBOutlet UILabel *intakeLable;//摄入量

@end
