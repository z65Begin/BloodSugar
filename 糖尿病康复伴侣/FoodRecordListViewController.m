//
//  FoodRecordListViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/28.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FoodRecordListViewController.h"

#import "FoodCataController.h"

#import "FoodRecordCell.h"

#import "FoodRecordModel.h"

@interface FoodRecordListViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, copy) NSString * eatFoodTime;

@property (nonatomic, weak) IBOutlet UITableView * tableView;

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;

@property (nonatomic, weak) IBOutlet UIButton * addButton;

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation FoodRecordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //饮食时间段
    //    extern NSString * const DIET_TIMEPER_BRFFAST;
    //    extern NSString * const DIET_TIMEPER_EXTRA1;
    //    extern NSString * const DIET_TIMEPER_LUNCH;
    //    extern NSString * const DIET_TIMEPER_EXTRA2;
    //    extern NSString * const DIET_TIMEPER_DINNER;
    //    extern NSString * const DIET_TIMEPER_NTSAKE;
    //    extern NSString * const DIET_TIMEPER_NOTFOOD;
    
    switch (self.integer) {
        case 10010:
            //            NSLog(@"早餐");
            self.eatFoodTime = DIET_TIMEPER_BRFFAST;
            self.nameLabel.text = @"早餐";
            break;
        case 10020:
//            NSLog(@"上午加餐");
            self.eatFoodTime = DIET_TIMEPER_EXTRA1;
            self.nameLabel.text = @"上午加餐";
            break;
        case 10030:
//            NSLog(@"午餐");
            self.eatFoodTime = DIET_TIMEPER_LUNCH;
            self.nameLabel.text = @"午餐";
            break;
            
        case 10040:
//            NSLog(@"下午加餐");
            self.eatFoodTime = DIET_TIMEPER_EXTRA2;
            self.nameLabel.text = @"下午加餐";
            break;
            
        case 10050:
//            NSLog(@"晚餐");
            self.eatFoodTime = DIET_TIMEPER_DINNER;
            self.nameLabel.text = @"晚餐";
            break;
            
        case 10060:
//            NSLog(@"夜宵");
            self.eatFoodTime = DIET_TIMEPER_NTSAKE;
            self.nameLabel.text = @"夜宵";
            break;
            
        case 10070:
//            NSLog(@"非饮食");
            self.eatFoodTime = DIET_TIMEPER_NOTFOOD;
            self.nameLabel.text = @"非饮食";
            break;
        default:
            break;
    }
    [self setNavigationItem];
    self.tableView.allowsSelection = NO;
    self.tableView.multipleTouchEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self cx_ChangeList];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)cx_ChangeList{
    NSArray * foodRecordArray = [FileUtils readFoodRecordWithUserID:self.userID andDate:self.date];
    NSMutableArray * foodRecordList = [NSMutableArray array];
    for (FoodRecordModel * foodRecord in foodRecordArray) {
        if ([foodRecord.timeperiod isEqualToString:self.eatFoodTime]) {
            [foodRecordList addObject:foodRecord];
        }
    }
    self.dataSource = [foodRecordList copy];
    [self.tableView reloadData];
}
//MARK: 保存按钮点击事件
- (void)saveButtonClick:(UIButton*)sender{
     BOOL flag = [FileUtils writefoodRecordWithUID:self.userID andFoodRecordArray:self.dataSource andDate:self.date];
    if (flag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//MARK:添加按钮
- (IBAction)changeButtonClick:(UIButton *)sender{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    FoodCataController * foodCataController = [[FoodCataController alloc]init];
    
    if ( self.eatFoodTime == DIET_TIMEPER_NOTFOOD) {
        foodCataController.notDiet = YES;
    }
    
    foodCataController.date = self.date;
    foodCataController.eatFoodTime = self.eatFoodTime;
    [self.navigationController pushViewController:foodCataController animated:YES];
    
}
#pragma mark  tableView dataSource && delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodRecordCell * cell = [FoodRecordCell cellForTableView:tableView];
    
    FoodRecordModel * model = [self.dataSource objectAtIndex:indexPath.row];
    
    [cell cellContentWitnModel:model];
    
    __weak typeof (self) weakSelf = self;
    cell.cellBlock = ^(FoodRecordModel * model){
        NSLog(@"删除 这一行记录");
        [FileUtils  deleteFoodRecordWitnUserID:weakSelf.userID andModel:model];
        NSMutableArray * array = [weakSelf.dataSource mutableCopy];
        [array removeObject:model];
        self.dataSource = [array copy];
        NSArray * indexArr = [NSArray arrayWithObjects:indexPath, nil];
        [self.tableView deleteRowsAtIndexPaths:indexArr withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (void)setNavigationItem{
    self.navigationItem.title = @"饮食列表";
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:blueColorWithRGB(61, 172, 225)];
    button.layer.cornerRadius = 8.0f;
    
    [button addTarget:self action:@selector(saveButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
