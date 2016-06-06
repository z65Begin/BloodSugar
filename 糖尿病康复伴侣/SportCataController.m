//
//  SportCataController.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/23.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportCataController.h"
#import "SportCataView.h"
#import "SportDayAddViewController.h"
#import "SportCataCell.h"
#import "sportCataModel.h"

@interface SportCataController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SportCataView * sportCataView;

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UIButton * startButton;

@property (nonatomic, strong) sportCataModel * model ;
@end

@implementation SportCataController


-(NSMutableArray *)sportArrays{
    if (_sportArrays == nil) {
        self.sportArrays = [NSMutableArray array];
    }
    return _sportArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    self.sportArrays = [[FileUtils readSid] copy];
    
    [self.view addSubview:self.tableView];
    //创建运动种类是图
//    [self createSportCataView];
    //创建底部功能按钮
    [self createToolBtn];
}

-(void)createSportCataView{
    UIScrollView * sportScrollView = [[UIScrollView alloc]init];
    [self.view addSubview:sportScrollView];
    sportScrollView.frame = CGRectMake(0, 0, W, H-49);
    sportScrollView.contentSize = CGSizeMake(0,1050);
    
     SportCataView * sportCataView = [SportCataView sportCataView];
    [sportScrollView addSubview:sportCataView];
    sportCataView.frame = CGRectMake(0, 0, W, 1050);
    self.sportCataView = sportCataView;
    self.sportCataView.objs = self.sportArrays;
    
}
#pragma mark tableView Datasource&& Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sportArrays.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SportCataCell * cell = [SportCataCell cellForTableView:tableView];
    sportCataModel * model = [self.sportArrays objectAtIndex:indexPath.row];
    [cell cellWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.startButton.enabled = YES;
    self.startButton.backgroundColor = blueColorWithRGB(61, 172, 225);
    sportCataModel * model  = [self.sportArrays objectAtIndex:indexPath.row];
    self.model = model;
}

-(void)createToolBtn{
    UIView * toolView = [[UIView alloc]init];
    toolView.frame = CGRectMake(0, H-44, W, 44);
    //    toolView.backgroundColor = [UIColor redColor];
    UIButton * quxiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    quxiaoBtn.frame = CGRectMake(0, 0, W/2, 44);
    [quxiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
    [quxiaoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [quxiaoBtn setBackgroundColor:[UIColor redColor]];
    [quxiaoBtn addTarget:self action:@selector(backHomeClick) forControlEvents:UIControlEventTouchUpInside];
    UIButton * startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(W/2, 0, W/2, 44);
    [startBtn setTitle:@"开始计时" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.enabled = NO;
    [startBtn setBackgroundColor:[UIColor lightGrayColor]];
    [toolView addSubview:quxiaoBtn];
    [toolView addSubview:startBtn];
    [self.view addSubview:toolView];
    self.startButton = startBtn;
}
-(void)timeAction:(UIButton * )btn{

    SportDayAddViewController * detail = [[SportDayAddViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
//    传值
    detail.cataModel = self.model;
    detail.date = self.date;
    detail.userId = self.userId;
}

- (void)backHomeClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)tableView{
    if (!_tableView) {
        CGRect frame = self.view.bounds;
        frame.size.height -=44;
        
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
    }
    return _tableView;
}


@end
