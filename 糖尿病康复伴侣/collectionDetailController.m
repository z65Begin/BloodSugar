//
//  collectionDetailController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/30.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "collectionDetailController.h"
#import "FoodListRecommendModel.h"
#import "TableViewCell.h"
#import "foodDetailController.h"
@interface collectionDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * breakfastArray;
    NSMutableArray * lunchArray;
    NSMutableArray * dinnerArray;
    
}

@end

@implementation collectionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    获取当前时间YYYY-MM-dd格式
//    NSString * currentTime =  [FileUtils getLocalDate];
    //    根据mid去取菜谱
    NSMutableArray * dataArray = [FileUtils getFoodListRecommendUseMID:self.menuID];
    
    breakfastArray = [[NSMutableArray alloc]init];
    lunchArray = [[NSMutableArray alloc]init];
    
    dinnerArray = [[NSMutableArray alloc]init];
    for (int i = 0 ; i < dataArray.count; i ++) {
        
        FoodListRecommendModel * model = dataArray[i];
        
        if ([model.TimePeriod isEqualToString:@"10"]) {
            
            [breakfastArray addObject:model];
            
        }
        else if ([model.TimePeriod isEqualToString:@"20"]) {
            [lunchArray addObject:model];
            
        }else if([model.TimePeriod isEqualToString:@"30"]){
            
            [dinnerArray addObject:model];
            
        }
    }
    //    创建界面
    [self createUI];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
 }

-(void)createUI{
    
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return breakfastArray.count;
    }
    else if (section==1)
    {
        return lunchArray.count;
    }else if (section == 2)
    {
        
        return dinnerArray.count;
    }
    else
        
        return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell== nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    if (indexPath.section == 0) {
        FoodListRecommendModel * model = breakfastArray[indexPath.row];
        //        model.FoodId写个方法用foodid取出食物
        cell.nameLable.text = [FileUtils getFoodNameUseFoodID:model.FoodId];
        cell.intakeLable.text = model.FoodIntake;
        
    }else if (indexPath.section == 1){
        
        FoodListRecommendModel * model = lunchArray[indexPath.row];
        //        model.FoodId写个方法用foodid取出食物
        cell.nameLable.text =   [FileUtils getFoodNameUseFoodID:model.FoodId];
        cell.intakeLable.text = model.FoodIntake;
        
    }else if (indexPath.section == 2){
        FoodListRecommendModel * model = dinnerArray[indexPath.row];
        //        model.FoodId写个方法用foodid取出食物
        cell.nameLable.text =   [FileUtils getFoodNameUseFoodID:model.FoodId];
        cell.intakeLable.text = model.FoodIntake;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    foodDetailController * detail = [[foodDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    
//    detail.eatFoodTime = model.TimePeriod;
//    detail.foodId = model.FoodId;
//    detail.date = self.date;
//    detail.Intaketf = model.FoodIntake;
    if (indexPath.section == 0) {
        detail.eatFoodTime = DIET_TIMEPER_BRFFAST;
        FoodListRecommendModel * RecommendModel = breakfastArray[indexPath.row];
        detail.foodId =RecommendModel.FoodId;
        detail.Intaketf = RecommendModel.FoodIntake;
        
    }else if (indexPath.section == 1){
        detail.eatFoodTime = DIET_TIMEPER_LUNCH;
        FoodListRecommendModel * RecommendModel = lunchArray[indexPath.row];
        detail.foodId =RecommendModel.FoodId;
        detail.Intaketf = RecommendModel.FoodIntake;
        
        
    }else if (indexPath.section == 2){
        detail.eatFoodTime = DIET_TIMEPER_DINNER;
        FoodListRecommendModel * RecommendModel = dinnerArray[indexPath.row];
        detail.foodId =RecommendModel.FoodId;
        detail.Intaketf = RecommendModel.FoodIntake;
    }
    detail.date = self.date;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 30)];
    label1.backgroundColor=[UIColor colorWithRed:37/255.0 green:122/255.0 blue:247/255.0 alpha:1.0];
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:20];
    if (section == 0)
    {
        label1.text=@"早餐";
        return label1 ;
    }
    else if(section == 1)
    {
        label1.text=@"午餐";
        return label1 ;
    }
    else if(section == 2){
        label1.text=@"晚餐";
        return label1 ;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
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
