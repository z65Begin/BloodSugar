//
//  SportCataCell.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/4.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportCataCell : UITableViewCell

+ (instancetype)cellForTableView:(UITableView*)tableView;

- (void)cellWithModel:(sportCataModel*)model;

@end
