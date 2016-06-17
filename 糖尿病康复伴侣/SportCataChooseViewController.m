//
//  SportCataChooseViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/6.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportCataChooseViewController.h"
#import "SportCataCell.h"

#import "sportCataModel.h"
@interface SportCataChooseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) IBOutlet UIButton * cancelBtn;
@property (nonatomic, weak) IBOutlet UIButton * sureBtn;
@property (nonatomic, strong) NSArray * dataSource;

- (IBAction)cancelBtnClick:(UIButton*)sender;
-(IBAction)sureBtnClick:(UIButton*)sender;
@property (nonatomic, strong)sportCataModel * model;

@end

@implementation SportCataChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     self.dataSource = [[FileUtils readSid] copy];
    self.sureBtn.enabled = NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.navigationController.navigationBarHidden) {
            self.navigationController.navigationBarHidden = YES;
        }
    });
    
}
#pragma mark tableView Datasource&& Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SportCataCell * cell = [SportCataCell cellForTableView:tableView];
    sportCataModel * model = [self.dataSource objectAtIndex:indexPath.row];
    [cell cellWithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.sureBtn.enabled = YES;
    self.sureBtn.backgroundColor = blueColorWithRGB(61, 172, 225);
    sportCataModel * model  = [self.dataSource objectAtIndex:indexPath.row];
    self.model = model;
}
- (void)cancelBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)sureBtnClick:(UIButton *)sender{
    self.chooseSportCata(self.model);
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
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
