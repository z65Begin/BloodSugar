//
//  ChooseUnit.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "ChooseUnit.h"

@interface ChooseUnit ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView * tableView;

@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, weak) IBOutlet UIView * backView;

@end


@implementation ChooseUnit

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backClick:)];
    
    [self.backView addGestureRecognizer:tapGR];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
- (void)backClick:(UITapGestureRecognizer*)tapGR{
    [self removeFromSuperview];
}

+ (id)viewWithXIB{
    ChooseUnit * choose = [[[NSBundle mainBundle]loadNibNamed:@"ChooseUnit" owner:self options:nil]firstObject];
    choose.frame = CGRectMake(0, 0, W, H);
    return choose;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.chooseUnit) {
        self.chooseUnit(self.dataSource[indexPath.row]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self backClick:nil];
    
}


- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"克",@"毫克",@"毫升",@"片",@"颗",@"瓶"];
    }
    return _dataSource;
}

@end
