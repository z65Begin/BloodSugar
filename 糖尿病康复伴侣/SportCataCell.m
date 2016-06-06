//
//  SportCataCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/4.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportCataCell.h"

#import "sportCataModel.h"

@interface SportCataCell ()

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * valueLabel;

@end

@implementation SportCataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.layer.cornerRadius = 8.0f;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state

}
+ (instancetype)cellForTableView:(UITableView*)tableView{
static NSString * cellIdentifier = @"SportCataCell";
    SportCataCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"SportCataCell" owner:self options:nil]firstObject];
    }
    return cell;
}
- (void)cellWithModel:(sportCataModel*)model{
    self.nameLabel.text = model.Name;
    self.valueLabel.text = model.Energy;
    
}


@end
