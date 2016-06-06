//
//  SignViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SignViewController.h"

#import "SignBloodSugarView.h"

#import "SignFooterView.h"

#import "SignBloodSugarViewController.h"

#import "MoreSignViewController.h"

#import "SignBloodSugarCell.h"

#import "BodySignModel.h"

#import "BloodSugarModel.h"

@interface SignViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;

@property (nonatomic, weak) IBOutlet UIView * bottomView;

@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) BodySignModel* bodySignModel;

@property (nonatomic, strong) SignFooterView * footView;


@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigation];
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bottomViewClick)];
    [self.bottomView addGestureRecognizer:tapGR];
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.allowsSelection = NO;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   BodySignModel * model= [FileUtils readBodySignWithUID:self.userId withDate:self.date];
    self.bodySignModel = model;
  NSArray * bloodArray = [FileUtils readBloodSugarWithUID:self.userId andDate:self.date];
  
    self.dataSource = [bloodArray copy];
    [self.tableView reloadData];
}
//MARK: 保存操作 保存修改后的数据
- (void)saveBtn:(UIButton *)sender{
    [self.view endEditing:YES];
    for (BloodSugarModel * model in self.dataSource) {
        if ([model.Value floatValue] >= 100) {
            [UtilCommon alertView:@"提示" andMessage:@"血糖值格式不正确，请参照99.9"];
            return;
        }
        model.UpdTime = [FileUtils getNowUpdTime];
    }
    if (self.footView.weightTF.text.floatValue >= 1000) {
        [UtilCommon alertView:@"提示" andMessage:@"体重值格式不正确，请参照999.9"];
        return;
    }
    if (self.footView.heightPersureTF.text.floatValue < self.footView.lowPersureTF.text.floatValue) {
        [UtilCommon alertView:@"提示" andMessage:@"低压必须小于高压"];
        return;
    }
//    保存血糖
    [FileUtils saveBloodSugarWithUID:self.userId withModelArray:self.dataSource andDate:self.date];
//    修改体重
    [FileUtils saveBodySignWith:self.userId andWeight:self.footView.weightTF.text DBP:self.footView.lowPersureTF.text SBP:self.footView.heightPersureTF.text andDate:self.date];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma  mark tableView Datasource && Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SignBloodSugarCell * cell = [SignBloodSugarCell cellOfTableView:tableView];
    BloodSugarModel * model = [self.dataSource objectAtIndex:indexPath.row];
    [cell cellWithModel:model];
    cell.delegateCell = ^( BloodSugarModel * model){
        NSMutableArray * array = [self.dataSource mutableCopy];
        [array removeObject:model];
        self.dataSource = [array copy];
        [self.tableView reloadData];
    };
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   SignBloodSugarView * view = [SignBloodSugarView viewWithXIB];
    [view.addBloodSugar addTarget:self action:@selector(addBloodSugarClcik:) forControlEvents:UIControlEventTouchUpInside];
    return view;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SignFooterView * footerView = [SignFooterView viewWithXIB];
    self.footView = footerView;
    self.footView.weightTF.text = self.bodySignModel.Weight;
    self.footView.heightPersureTF.text = self.bodySignModel.SBP;
    self.footView.lowPersureTF.text = self.bodySignModel.DBP;
    return footerView;
}

- (void)addBloodSugarClcik:(UIButton*)sender{
     self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    SignBloodSugarViewController * bloodSugar = [[SignBloodSugarViewController alloc]init];
    bloodSugar.userId = self.userId;
    bloodSugar.date = self.date;
    [self.navigationController pushViewController:bloodSugar animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//MARK: 更多体征
- (void)bottomViewClick{
//    NSLog(@"更多体征按钮点击");
     self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    MoreSignViewController * moreSign = [[MoreSignViewController alloc]init];
    
    moreSign.date =  self.date;
    moreSign.userId = self.userId;
    [self.navigationController pushViewController:moreSign animated:YES];
}

- (void)setNavigation{
    self.navigationItem.title = @"体征录入";
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
//MARK: 初始化  getter
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}



@end
