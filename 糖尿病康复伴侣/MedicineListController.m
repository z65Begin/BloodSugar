//
//  MedicineListController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/17.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MedicineListController.h"

#import "MedicineListHeadView.h"

#import "MedicineListTableViewCell.h"

#import "MedicinalWriteController.h"

#import "MedicineRecordModel.h"

#import "MedicineChooseController.h"

#import "medicineListModel.h"

#import "ChangeViewTextField.h"

#import "ChooseUnit.h"

@interface MedicineListController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, strong) NSArray * dataSource;
@end

@implementation MedicineListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self buildNavigation];
    self.tableView.allowsSelection = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    NSArray * fileArray = [FileUtils readMedicineRecordWithUID:self.userId AndDate:self.date];
    self.dataSource = [fileArray copy];
    [self.tableView reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

- (void)buildNavigation{
    self.navigationItem.title = @"用药列表";
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

//保存 用药
- (void)saveButtonClick:(UIButton*)sender{
  BOOL flag = [FileUtils writeMedicineRecordWithUID:self.userId AndModelArray:self.dataSource andDate:self.date];
    if (flag) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark tableView delegate && datasouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MedicineListTableViewCell* cell = [MedicineListTableViewCell cellForTableView:tableView];
    if (indexPath.row == self.dataSource.count -1) {
        cell.endView.hidden = YES;
    }else{
        cell.endView.hidden = NO;
    }
    MedicineRecordModel* model = self.dataSource[indexPath.row];
    [cell cellWithModel:model];
    __weak typeof (self)weakSelf = self;
    
//   删除
    cell.deleteBtnClick = ^(MedicineRecordModel * model){
        NSMutableArray * array = [self.dataSource mutableCopy];
        [array removeObject:model];
        weakSelf.dataSource = [array copy];
        [weakSelf.tableView reloadData];
    };
//选择药物
    __weak typeof (cell) weakCell = cell;
    cell.chooseMedicine = ^{
        MedicineChooseController * chooseMedicine = [[MedicineChooseController alloc]init];
        weakSelf.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
        [weakSelf.navigationController pushViewController:chooseMedicine animated:YES];
        chooseMedicine.chooseMedicine = ^(medicineListModel * modelList){
            weakCell.nameLabel.text = modelList.Name;
            model.MedName = modelList.Name;
        };
    };
//    手动输入药品名称
    cell.inputMedicineName = ^{
        ChangeViewTextField * change = [ChangeViewTextField viewWithXibWithName:@"药名" andContent:model.MedName];
        [weakSelf.view addSubview:change];
        change.changeName = ^(NSString* name){
            weakCell.nameLabel.text = name;
            model.MedName = name;
        };
        
        
    };
//    修改说明文字
    cell.changeNote = ^{
        ChangeViewTextField * change = [ChangeViewTextField viewWithXibWithName:@"说明" andContent:model.Notes];
        [weakSelf.view addSubview:change];
        change.changeName = ^(NSString* name){
            weakCell.noteLabel.text = name;
            model.Notes = name;
        };

    
    };
//    选择单位
    cell.chooseUnit = ^{
        ChooseUnit * unit = [ChooseUnit viewWithXIB];
        [weakSelf.view addSubview:unit];
        unit.chooseUnit = ^(NSString* name){
            weakCell.unitTF.text = name;
            model.UnitName = name;
        };
    };
    return cell;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MedicineListHeadView * view = [MedicineListHeadView viewWithXIB];
    [view.addButton addTarget:self action:@selector(goToChooseMediicine) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

//跳转到 选择药品记录页面
- (void)goToChooseMediicine{
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    MedicinalWriteController * medicineWrite = [[MedicinalWriteController alloc]init];
    medicineWrite.date = self.date;
    medicineWrite.userID = self.userId;
    medicineWrite.chooseMedicine = ^{
        NSArray * fileArray = [FileUtils readMedicineRecordWithUID:self.userId AndDate:self.date];
        self.dataSource = [fileArray copy];
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:medicineWrite animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
