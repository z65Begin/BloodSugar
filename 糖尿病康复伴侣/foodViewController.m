//
//  foodViewController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/10.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "foodViewController.h"
#import "foodmodel.h"
#import "ZDSearchBar.h"
#import "FileUtils.h"
#import "YDDPaiXu.h"
#import "NSObject+Index.h"
#import "ChineseString.h"
#import "foodDetailController.h"
#import "foodEnergyViewController.h"

@interface foodViewController ()<UITextFieldDelegate,UISearchBarDelegate>{
    NSMutableArray * _listArray; //源数据
    NSMutableArray *_AbcSort;   //排序整理后的数组
    NSMutableArray *_sectionHeadsKeys;//存放索引的数组
    ZDSearchBar * searchbar;//搜索框
}
//筛选后数组
@property(nonatomic)NSMutableArray * AfterSiftMArray;
//排序后数组
@property(nonatomic)NSMutableArray * sortMArray;
//排序后数组
@property(nonatomic)NSMutableArray * paixuArray;
//最后的数组
@property(nonatomic) NSMutableArray * finalArray;

@property (nonatomic, strong)NSMutableArray * searchArray;

@end

@implementation foodViewController
-(NSMutableArray *)AfterSiftMArray{
    if (_AfterSiftMArray == nil) {
        _AfterSiftMArray = [[NSMutableArray alloc]init];
    }
    return _AfterSiftMArray;
}
-(NSMutableArray *)sortMArray{
    if (_sortMArray == nil) {
        _sortMArray = [[NSMutableArray alloc]init];
    }
    return  _sortMArray;
}
-(NSMutableArray *)paixuArray{
    if (_paixuArray == nil) {
        _paixuArray = [[NSMutableArray alloc]init];
    }
    return _paixuArray;

}
-(NSMutableArray *)finalArray{
    if (_finalArray == nil) {
        _finalArray = [[NSMutableArray alloc]init];
    }
    return _finalArray;
}
#pragma mark  -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    _AbcSort=[[NSMutableArray alloc]init];
    [self createNav];
       _sectionHeadsKeys=[[NSMutableArray alloc]init];
    [self siftData];
   self.finalArray =   [YDDPaiXu zhongWenPaiXu:self.paixuArray];
    _listArray = [[NSMutableArray alloc]initWithArray:self.finalArray];
    _AbcSort = [ self getChineseStringArr : _listArray andSck:_sectionHeadsKeys ];
    [self.searchArray addObjectsFromArray:_AbcSort];

    [self createSearchBar];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor whiteColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(1, 5, 1, 5);

}
-(void)createNav{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
 self.navigationItem.title = self.foodCateName;
}
-(void)back{
 [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -- 筛选数据
-(void)siftData{
    for (foodmodel * model in self.dataArray) {
        if ([model.DelFlag isEqualToString:@"0"]) {
            [self.AfterSiftMArray addObject:model];
            [self.paixuArray addObject:model.FoodName];//中文名称
        }
    }

}
-(void)createSearchBar{
//    searchbar = [[ZDSearchBar alloc]initWithFrame:CGRectMake(0, 0, W, 35)];
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, W, 44)];
    searchBar.placeholder = @"请输入食物名称";
    searchBar.tintColor = [UIColor lightGrayColor];
    searchBar.delegate = self;
    self.tableView.tableHeaderView = searchBar;
}
#pragma mark  查找 searchBar 代理方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self.searchArray removeAllObjects];
    if (searchText.length == 0) {
        [self.searchArray addObjectsFromArray:_AbcSort];
    }

    
    NSMutableArray * searchArr = [NSMutableArray array];
    for (NSArray * nameArray in _AbcSort) {
        for (ChineseString * model in nameArray) {
            NSRange chinese = [model.string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange letter = [model.pinYin rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (chinese.location != NSNotFound) {
                [searchArr addObject:model];
            }else if(letter.location != NSNotFound){
                [searchArr addObject:model];
            }
        }
    }
    [self.searchArray addObject:searchArr];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ self.searchArray objectAtIndex :section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"cellfood"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellfood"];
        
    }
    cell.contentView.backgroundColor  = [UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0];
    cell.textLabel.textColor = [UIColor whiteColor];
    if ([ self.searchArray count ] > indexPath. section ){
        NSArray *arr = [ self.searchArray objectAtIndex :indexPath. section ];
        if ([arr count ] > indexPath. row ){
            // 之后 , 将数组的元素取出 , 赋值给数据模型
            ChineseString *str = ( ChineseString *) [arr objectAtIndex :indexPath. row ];
            // 给 cell 赋给相应地值 , 从数据模型处获得
            cell.textLabel.text = str. string ;
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
- ( NSString *)tableView:( UITableView *)tableView titleForHeaderInSection:( NSInteger )section{
    return [_sectionHeadsKeys objectAtIndex :section];
}

- (NSArray*)sectionIndexTitlesForTableView:( UITableView *)tableView{
    return _sectionHeadsKeys ;
}
- (NSInteger)numberOfSectionsInTableView:( UITableView *)tableView{
    return [ self.searchArray count];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [searchbar resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    for (NSString * str in self.paixuArray) {
        if ([textField.text isEqualToString:str]) {
        }
    }
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.stateOfPage !=nil) {
        NSString * finalStr;
        if ([ self.searchArray count ] > indexPath. section ){
            NSArray *arr = [ self.searchArray objectAtIndex :indexPath. section ];
            if ([arr count ] > indexPath. row ){
                // 之后 , 将数组的元素取出 , 赋值给数据模型
                ChineseString *str = ( ChineseString *) [arr objectAtIndex :indexPath. row ];
                // 给 cell 赋给相应地值 , 从数据模型处获得
                finalStr = str. string ;
            }
        }
        for (foodmodel * model in self.dataArray) {
            if ([finalStr isEqualToString:model.FoodName]) {
                NSDictionary * dict = [[NSDictionary alloc]initWithObjectsAndKeys:model,@"foodmodel", nil];
                NSNotification * notic = [NSNotification notificationWithName:@"foodmodel" object:nil userInfo:dict];
                [[NSNotificationCenter defaultCenter]postNotification:notic];
            }
        }
        foodEnergyViewController *energy = nil;
        for (UIViewController * VC in self.navigationController.viewControllers) {
            if ([VC isKindOfClass:[foodEnergyViewController class]]) {
                energy = (foodEnergyViewController *)VC;
            }
        }
        [self.navigationController popToViewController:energy animated:YES];
    }else{
        foodDetailController * detail =  [[foodDetailController alloc]init];
        detail.date = self.date;
        [self.navigationController pushViewController:detail animated:YES];
        NSString * finalStr;
        if ([ self.searchArray count ] > indexPath. section ){
            NSArray *arr = [ self.searchArray objectAtIndex :indexPath. section ];
            if ([arr count ] > indexPath. row ){
                // 之后 , 将数组的元素取出 , 赋值给数据模型
                ChineseString *str = ( ChineseString *) [arr objectAtIndex :indexPath. row ];
                // 给 cell 赋给相应地值 , 从数据模型处获得
                finalStr = str. string ;
            }
        }
        for (foodmodel * model in self.dataArray) {
            if ([finalStr isEqualToString:model.FoodName]) {
                detail.foodId = model.foodID;
            }
        }
        detail.eatFoodTime = self.eatFoodTime;
    }
}
- (NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}


@end
