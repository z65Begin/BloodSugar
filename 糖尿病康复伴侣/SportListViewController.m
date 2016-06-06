//
//  SportListViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/4.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportListViewController.h"

#import "SportListHeadView.h"

#import "SportListCell.h"

#import "SportRecordModel.h"//模型

#import "SportCataChooseViewController.h"

#import "SportAlertView.h"

#import "CXChooseDateView.h"

#import "SportOtherDayAddViewController.h"

@interface SportListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) SportListHeadView * headerView;

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation SportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    self.tableView.allowsSelection = NO;
    NSArray * sportArray = [FileUtils readSportRecordWithUID:self.userId andDate:self.date];
    
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    NSArray * array = [NSArray arrayWithObject:sort];
    self.dataSource = [sportArray sortedArrayUsingDescriptors:array];
    [self.tableView reloadData];
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
  
}

#pragma mark tableView dataSource && delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SportListCell * cell = [SportListCell cellForTableView:tableView];

    if (indexPath.row == (self.dataSource.count-1)) {
            cell.hiddenView.hidden = YES;
    }else{
        cell.hiddenView.hidden = NO;
    }
    SportRecordModel* model = self.dataSource[indexPath.row];
//    NSLog(@"%@ view",model);
    [cell cellWithSportModel:model];
    NSLog(@"%@",model.Type);
//    删除某一项
    cell.recyleButtonDelete = ^(SportRecordModel * model){
        NSMutableArray * array = [self.dataSource mutableCopy];
        [array removeObject:model];
        self.dataSource = [array copy];
        [self.tableView reloadData];
    };
//    选择运动项目
//    __weak typeof(model) weakModel = model;
    cell.tapViewChoice = ^{
        SportCataChooseViewController * choose = [[SportCataChooseViewController alloc]init];
        [self.navigationController pushViewController:choose animated:YES];
        choose.chooseSportCata = ^(sportCataModel* catamodel){
            model.Type = [catamodel.sid copy];
            [self.tableView reloadData];
        };
    };
//    选择运动结果
    cell.chooseResult = ^(NSString* result){
        UIView * view = [[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor = [UIColor darkGrayColor];
        view.alpha = 0.8;
        [self.view addSubview:view];
        SportAlertView * alert = [SportAlertView viewWithXIB];
        alert.frame = CGRectMake(20, (H-400)/2, W-40, 204);
        [self.view addSubview:alert];
        __weak typeof(alert) weakAlert = alert;
        alert.chooseChildResult = ^(NSString* result){
            [view removeFromSuperview];
            model.Result = result;
            [self.tableView reloadData];
            [weakAlert removeFromSuperview];
            
        };
    };
//    选择时间
    __weak typeof (cell)weakCell = cell;
    cell.timeChooseResult = ^{
        CXChooseDateView * view = [CXChooseDateView viewWithXIBWithDate:model.time];
        [view viewAddToView:self.view];
        
        view.timeChoose = ^(NSString* timeStr){
            model.time = timeStr;
            weakCell.timeLabel.text = [UtilCommon stringData_mm_ssFromStr:timeStr];
        };
    };
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SportListHeadView * view  = [SportListHeadView viewWithXIB];
    [view.addNewButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.headerView = view;
    [view viewHiddenSubView:self.dataSource.count? YES:NO];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark 添加运动记录
- (void)addButtonClick:(UIButton*)sender{
//    NSLog(@"添加成功了");
    SportOtherDayAddViewController * otherDayAdd = [[SportOtherDayAddViewController alloc]init];
    otherDayAdd.date = self.date;
    otherDayAdd.userId = self.userId;
    [self.navigationController pushViewController:otherDayAdd animated:YES];
    otherDayAdd.nameBlock = ^{
        NSArray * sportArray = [FileUtils readSportRecordWithUID:self.userId andDate:self.date];
        NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
        NSArray * array = [NSArray arrayWithObject:sort];
        self.dataSource = [sportArray sortedArrayUsingDescriptors:array];
        [self.tableView reloadData];
    };
    
}

#pragma mark 保存按钮点击事件
- (void)saveBtn:(UIButton*)sender{
 BOOL flag = [SportFileUtils saveSportRecordWitnUID:self.userId andRecordArray:self.dataSource];
    if (flag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)setNavigation{
    self.navigationItem.title = @"运动列表";
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 50, 30);
    button.layer.cornerRadius = 3.0f;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:blueColorWithRGB(61, 172, 225)];
    [button addTarget:self  action:@selector(saveBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;

}
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

@end
