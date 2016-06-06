//
//  TableViewDoctorCell.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "TableViewDoctorCell.h"

#import "cx_Advisory.h"

@interface TableViewDoctorCell ()

@property (nonatomic, weak) IBOutlet UIImageView * headImage;

@property (nonatomic, weak) IBOutlet UILabel * titleLabel;

@property (nonatomic, weak) IBOutlet UILabel * authorLabel;

@property (nonatomic, weak) IBOutlet UILabel * upTimeLabel;

@property (nonatomic, weak) IBOutlet UILabel * rplTimeLabel;

@property (nonatomic, weak) IBOutlet UILabel * readLabel;

@end


@implementation TableViewDoctorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.readLabel.layer.cornerRadius = 5*0.5f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)cellWithModel:(cx_Advisory*)model{
    if ([model.isNew isEqualToString:@"true"]) {
        self.readLabel.hidden = NO;
    }else{
        self.readLabel.hidden = YES;
    }
    self.titleLabel.text = model.title;
    if (model.docID.length||model.docName.length) {
        self.authorLabel.text = [NSString stringWithFormat:@"(%@)",model.docName];
        self.headImage.image = [UIImage imageNamed:@"img_mdc_head"];
        
    }else{
        self.authorLabel.text = @"(自己)";
        self.headImage.image = [UIImage imageNamed:@"img_mdc_head1"];
    }
    self.upTimeLabel.text = [UtilCommon dateStrFormStr:model.updtime];
    if (![model.rpltime isEqualToString:@""]) {
      NSDate * date = [UtilCommon strFormateDate:model.rpltime];
      NSString * timeStr = [UtilCommon dateFormateStr:date DATEFORMAT:@"HH:mm"];
        self.rplTimeLabel.text = timeStr;
    }else{
        self.rplTimeLabel.text = @"-";
    }
    
    
    
    
}


@end
