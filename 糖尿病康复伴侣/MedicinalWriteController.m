//
//  MedicinalWriteController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/2.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "MedicinalWriteController.h"
#import "MedicalWriteView.h"
#import "medicineListModel.h"

#import "MedicineChooseController.h"

#import "MedicineRecordModel.h"

//排序用头文件
//#import "ChineseString.h"
@interface MedicinalWriteController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>{
    NSMutableArray *_sectionHeadsKeys;//存放索引的数组
    NSMutableArray *_AbcSort;   //排序整理后的数组
    MedicalWriteView * medicinalView;//药物视图
    UISearchBar * searchbar;
}

//药物集合
@property(nonatomic)NSMutableArray * medicinallistArray;
//单位数组
@property(nonatomic)NSArray * unitArray;
//需要保存的药品id
@property(nonatomic)NSString * MedicineID;
@property(nonatomic)NSString * MedName;
@property(nonatomic)NSString * AmountTimes;
@property(nonatomic)NSString * AMountUnit;
@property(nonatomic)NSString * UnitName;
@property(nonatomic)NSString * Notes;

@property(nonatomic)NSString * UpdTime;

@property (nonatomic, strong) MedicineRecordModel * model;


@end

@implementation MedicinalWriteController

#pragma mark --  懒加载
-(NSMutableArray *)medicinallistArray{
    if (_medicinalArrays == nil) {
        _medicinalArrays = [FileUtils readYid];
    }
    return _medicinalArrays;
}
- (MedicineRecordModel *)model{
    if (!_model) {
        _model = [[MedicineRecordModel alloc]init];
    }
    return _model;
}

#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"用药录入";
    
    self.unitArray = @[@"克",@"毫克",@"毫升",@"片",@"颗",@"瓶"];
    //    创建状态栏
    [self createNav];
    
    //    创建用药视图
    [self createMedicinalView];
    
    //    NSLog(@"medicineNameArr%@",self.medicineNameArr);
//    NSArray *  array = [FileUtils readMedicineRecordWithUID:self.userID];
   }
#pragma mark --createSearchBar

-(void)createSearchBar{
    searchbar = [[UISearchBar alloc]initWithFrame:CGRectMake(-10, 0, [UIScreen mainScreen].bounds.size.width+20, 30)];
    
    searchbar.placeholder = @"输入药品名称";
    
    searchbar.keyboardType = UIKeyboardAppearanceDefault;
    
    searchbar.delegate = self;
    
    [medicinalView addSubview:searchbar];
}

#pragma mark --createMedicinalView
-(void)createMedicinalView{
    medicinalView = [MedicalWriteView medicinalWriteView];
    medicinalView.frame = CGRectMake(0, 0,W, H);
    medicinalView.medicinalNameTF.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0]CGColor];
    medicinalView.medicinalNameTF.layer.borderWidth= 1.0f;
    medicinalView.everyTimesunit.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0]CGColor];
    medicinalView.everyTimesunit.layer.borderWidth = 1.0f;
    medicinalView.eatTimesEveryDay.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0]CGColor];
    medicinalView.eatTimesEveryDay.layer.borderWidth = 1.0f;
    //    61 172 223
    medicinalView.everyTimesUsed.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0]CGColor];
    medicinalView.everyTimesUsed.layer.borderWidth = 1.0f;
    [medicinalView.chooseMedicinalBtn1 addTarget:self action:@selector(chooseMedicinalBtn) forControlEvents:UIControlEventTouchUpInside];
    [medicinalView.uiitChooseBtn addTarget:self action:@selector(chooseUnitBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:medicinalView];
    
}
#pragma mark --chooseMedicinalBtn
-(void)chooseMedicinalBtn{

    MedicineChooseController * chooseMedicine = [[MedicineChooseController alloc]init];
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationController pushViewController:chooseMedicine animated:YES];
    chooseMedicine.chooseMedicine = ^(medicineListModel * model){
        medicinalView.medicinalNameTF.text = model.Name;
        /*medicineID 药品id
         *MedName 药品名字
         *AmountTimes用量-服用次数
         *AMountUnit用量-单次服用量
         *UnitName药品单位
         *Notes备注
         *date记录日期
         *UpdTime更新时间
         */
        self.model.MedName = model.Name;
//        self.MedicineID = model.sid;
//        self.MedName = model.Name;
//        self.AmountTimes = medicinalView.eatTimesEveryDay.text;
//        self.AMountUnit = medicinalView.everyTimesUsed.text;
//        self.UnitName = medicinalView.everyTimesunit.text;
//        self.Notes = medicinalView.explain.text;
        
    };

}
#pragma mark --选择单位按钮
//选择单位按钮
-(void)chooseUnitBtn{
    //    遮盖层
    UIView * uv = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    uv.tag = 100;
    uv.backgroundColor = [UIColor grayColor];
    
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height/2) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tag = 1001;
    tableview.alpha = 1.0;
    tableview.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    
    tableview.backgroundColor = [UIColor grayColor];
    //    [uv addSubview:tableview];
    //    [uv bringSubviewToFront:tableview];
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundViewClick:)];
    [uv addGestureRecognizer:tapGR];
    [medicinalView addSubview:uv];
    [medicinalView addSubview:tableview];
    
}
- (void)backgroundViewClick:(UITapGestureRecognizer *)tapGR{
    UIView * view = tapGR.view;
    [view removeFromSuperview];
    
    UITableView * tableView = [self.view viewWithTag:1001];
    [tableView removeFromSuperview];
    
}

//#pragma mark --deldgate -- tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.unitArray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        UITableViewCell * cell1  = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
        }
        cell1.textLabel.text =self.unitArray[indexPath.row];
        cell1.textLabel.font = [UIFont systemFontOfSize:14.0];
        return cell1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView removeFromSuperview];
    [searchbar removeFromSuperview];
           medicinalView.everyTimesunit.text = self.unitArray[indexPath.row];
    
    UIView * uv = [self.view viewWithTag:100];
    [uv removeFromSuperview];
}
#pragma mark -- searchbar --delegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
}

#pragma mark --createNav
-(void)createNav{
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

#pragma mark --保存返回并存储
//保存返回并存储
-(void)saveBtn:(UIBarButtonItem *)btn{
    /*medicineID 药品id
     *MedName 药品名字
     *AmountTimes用量-服用次数
     *AMountUnit用量-单次服用量
     *UnitName药品单位
     *Notes备注
     *date记录日期
     *UpdTime更新时间
     */
//    medicinalView.medicinalNameTF
//    medicinalView.everyTimesunit
    if (!medicinalView.medicinalNameTF.text||[medicinalView.medicinalNameTF.text isEqualToString:@""]) {
        [UtilCommon alertView:@"提示" andMessage:@"请输入药名"];
        return;
    }
    if (!medicinalView.eatTimesEveryDay.text||[medicinalView.eatTimesEveryDay.text isEqualToString:@""]) {
        [UtilCommon alertView:@"提示" andMessage:@"请输入服用次数"];
        return;
    }
    if (!medicinalView.everyTimesUsed.text||[medicinalView.everyTimesUsed.text isEqualToString:@""]) {
        [UtilCommon alertView:@"提示" andMessage:@"请输入用量"];
        return;
    }
    if (!medicinalView.everyTimesunit.text||[medicinalView.everyTimesunit.text isEqualToString:@""]) {
        [UtilCommon alertView:@"提示" andMessage:@"请输入单位"];
        return;
    }
//    @property (nonatomic, copy) NSString * recid;
//    //记录时间
//    @property (nonatomic, copy) NSString * date;
//    //药品名
//    @property (nonatomic, copy) NSString * MedName;
//    //用量-服用次数
//    @property (nonatomic, copy) NSString * AmountTimes;
//    //用量-单次服用量
//    @property (nonatomic, copy) NSString * AMountUnit;
//    //单位  毫升
//    @property (nonatomic, copy) NSString * UnitName;
//    //说明
//    @property (nonatomic, copy) NSString * Notes;
//    //更新时间
//    @property (nonatomic, copy) NSString * updtime;
    
//    self.model.MedName = medicinalView.medicinalNameTF.text;
//    NSDate *currentDate = [NSDate date];//获取当前时间，日期
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSString *dateString = [dateFormatter stringFromDate:currentDate];
//        self.UpdTime=dateString;
//    self.model.updtime = dateString;
//    self.model.AmountTimes = medicinalView.eatTimesEveryDay.text;
//    self.model.date = self.date;
//    self.model.AMountUnit = medicinalView.everyTimesUsed.text;
//    self.model.UnitName = medicinalView.everyTimesunit.text;
//    self.model.Notes = medicinalView.explain.text;
    
    self.model.date = self.date;
    self.model.updtime = [FileUtils getNowUpdTime];
    self.model.MedName = medicinalView.medicinalNameTF.text;
    self.model.AmountTimes = medicinalView.eatTimesEveryDay.text;
    self.model.AMountUnit = medicinalView.everyTimesUsed.text;
    self.model.UnitName = medicinalView.everyTimesunit.text;
    self.model.Notes = medicinalView.explain.text;
    
   BOOL flag = [FileUtils writeMedicineRecordWithUID:self.userID AndModel:self.model];
    if (flag) {
        [self.navigationController popViewControllerAnimated:YES];
        if (self.chooseMedicine) {
            self.chooseMedicine();
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UIView * uv = [self.view viewWithTag:100];
    [medicinalView.medicinalNameTF resignFirstResponder];
    [medicinalView.eatTimesEveryDay resignFirstResponder];
    [medicinalView.everyTimesUsed resignFirstResponder];
    [medicinalView.everyTimesunit resignFirstResponder];
    [medicinalView.explain resignFirstResponder];
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

@end
