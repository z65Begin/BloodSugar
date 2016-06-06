//
//  MedicineChooseController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MedicineChooseController.h"

#import "medicineListModel.h"

#import "ChineseString.h"
#import "pinyin.h"

#import "NSObject+Index.h"
#import "YDDPaiXu.h"

@interface MedicineChooseController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>{
    NSMutableArray * _nameArray;
    NSMutableArray * _sectionHeadsKeys;
    NSArray * _AbcSort;
    
}
@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) IBOutlet UISearchBar * searchBar;

@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, strong) NSMutableArray * searchArray;

@end

@implementation MedicineChooseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"药品选择";
    _nameArray = [NSMutableArray array];
    for (medicineListModel * model in self.dataSource) {
        [_nameArray addObject:model.Name];
    }
     _sectionHeadsKeys=[[NSMutableArray alloc]init];
     _AbcSort = [ self getChineseStringArr : _nameArray andSck:_sectionHeadsKeys ];
    self.searchBar.delegate = self;
    
    [self.searchArray addObjectsFromArray:_AbcSort];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return [[ self.searchArray objectAtIndex :section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.searchArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.contentView.backgroundColor = blueColorWithRGB(61, 172, 225);
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor = [UIColor whiteColor];
//    medicineListModel * model = [self.dataSource objectAtIndex:indexPath.row];
//        cell.textLabel.text = model.Name;
    if ([ self.searchArray count ] > indexPath. section ){
        NSArray *arr = [ self.searchArray objectAtIndex :indexPath. section ];
        if ([arr count ] > indexPath. row ){
            // 之后 , 将数组的元素取出 , 赋值给数据模型
            ChineseString *str = ( ChineseString *) [arr objectAtIndex :indexPath. row ];
            // 给 cell 赋给相应地值 , 从数据模型处获得
            cell.textLabel.text = str.string ;
        }
    }
    return cell;
}
- (NSArray*)sectionIndexTitlesForTableView:( UITableView *)tableView{
    return _sectionHeadsKeys ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChineseString * str = [[self.searchArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    for (medicineListModel * model in self.dataSource) {
        if ( [model.Name isEqualToString:str.string]) {
            self.chooseMedicine(model);
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self.searchArray removeAllObjects];
    if (searchText.length == 0) {
        [self.searchArray addObjectsFromArray:_AbcSort];
    }
    NSMutableArray * searchArray = [NSMutableArray array];
    for (NSArray * nameArray in _AbcSort) {
        for (ChineseString* model in nameArray) {
            NSRange chinese = [model.pinYin rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange letter = [model.string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (chinese.location != NSNotFound) {
                [searchArray addObject:model];
            }else if(letter.location != NSNotFound){
                [searchArray addObject:model];
            }
        }
    }
    [self.searchArray addObject:searchArray];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [FileUtils readYid];
    }
    return _dataSource;
}
- (NSMutableArray *)searchArray{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}


@end
