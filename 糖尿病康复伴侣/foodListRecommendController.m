//
//  foodListRecommendController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/23.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "foodListRecommendController.h"
#import "baseLineModel.h"
#import "FoodListRecommendModel.h"
#import "TableViewCell.h"
#import "foodDetailController.h"

#import "FoodRecommendheaderView.h"

#import "collectionViewController.h"
@interface foodListRecommendController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSMutableArray * breakfastArray;
    NSMutableArray * breakfastAddArr;
    
    NSMutableArray * lunchArray;
    NSMutableArray * lunchAddArr;
    NSMutableArray * dinnerArray;
    NSMutableArray * dinnerAddArr;
    
    NSMutableArray * allArray;
    NSString * standardE;//标准热量等级
}

@end

@implementation foodListRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    float hegiht =   [SingleManager sharedSingleManager].InfoModel.Height.floatValue;
    float weight = [SingleManager sharedSingleManager].InfoModel.Weight.floatValue;
    float BMI = weight/((hegiht/100)*(hegiht/100));
    //    先算BMI 四舍五入
    //    NSString *BMIstr = [self roundUp:BMI afterPoint:0];
    NSString * straaa = [self getValueFromBMI:BMI];
    float energy = straaa.floatValue;
    float standardWeight =(hegiht/100)*(hegiht/100)* 22;
    int standardEnergy =[[self roundUp:energy * standardWeight afterPoint:0]intValue] ;
    int a = [self getEnergyLevel:standardEnergy];
    standardE = [NSString stringWithFormat:@"%.d",a];
    //下载并写入数据
    NSData * data =  [WebUtilsCommon getfoodListRecommendFromServerUID:[SingleManager sharedSingleManager].InfoModel.UID EnergyLevel:standardE];
    [FileUtils writeFoodListRecommend:data];
    self.navigationItem.title = @"食谱推荐";
}

-(void)viewWillAppear:(BOOL)animated{
    //    获取当前时间YYYY-MM-dd格式
    NSString * currentTime =  [FileUtils getLocalDate];
    
    NSMutableArray * dataArray = [FileUtils getFoodListRecommendUseDate:currentTime andenergylv:standardE];
    breakfastArray = [[NSMutableArray alloc]init];
    breakfastAddArr = [[NSMutableArray alloc]init];
    lunchArray = [[NSMutableArray alloc]init];
    lunchAddArr = [[NSMutableArray alloc]init];
    dinnerArray = [[NSMutableArray alloc]init];
    dinnerAddArr = [[NSMutableArray alloc]init];
    allArray= [[NSMutableArray alloc]init];
    
    for (int i = 0 ; i < dataArray.count; i ++) {
        FoodListRecommendModel * model = dataArray[i];
        
        if ([model.TimePeriod isEqualToString:DIET_TIMEPER_BRFFAST]) {
            [breakfastArray addObject:model];
        }else if([model.TimePeriod isEqualToString:DIET_TIMEPER_EXTRA1]){
            [breakfastAddArr addObject:model];
        }else if ([model.TimePeriod isEqualToString:DIET_TIMEPER_LUNCH]) {
            [lunchArray addObject:model];
        }else if([model.TimePeriod isEqualToString:DIET_TIMEPER_EXTRA2]){
            [lunchAddArr addObject:model];
        }else if([model.TimePeriod isEqualToString:DIET_TIMEPER_DINNER]){
            [dinnerArray addObject:model];
        }else if([model.TimePeriod isEqualToString:DIET_TIMEPER_NTSAKE]){
            [dinnerAddArr addObject:model];
        }
    }
    [self addArray:breakfastArray];
    [self addArray:breakfastAddArr];
    [self addArray:lunchArray];
    [self addArray:lunchAddArr];
    [self addArray:dinnerArray];
    [self addArray:dinnerAddArr];
    
    //    创建界面
    [self createUI];
}
- (void)addArray:(NSArray *)array{
    if (array.count) {
        [allArray addObject:array];
    }
}

-(void)createUI{
    FoodRecommendheaderView * foodheaderView = [FoodRecommendheaderView FoodRecommendheaderView];
    [foodheaderView.addCollect addTarget:self action:@selector(addcolle) forControlEvents:UIControlEventTouchUpInside];
    
    [foodheaderView.collectFile addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    foodheaderView.frame = CGRectMake(0, 0, W, 35);
    
    [self.view addSubview:foodheaderView];
    UITableView * table = [[UITableView alloc]initWithFrame:CGRectMake(0, 35, W, H-35-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
}
#pragma mark -- 添加收藏
-(void)addcolle{
    FoodListRecommendModel * model =breakfastArray[0];
    if (![FileUtils saveRecommendFoodListUsingUID:self.userID AndMID:model.MenuId]) {
        [UtilCommon alertView:@"您已添加过该食谱" andMessage:@""];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入备注名" message:@" " delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        alert.delegate = self;
        alert.alertViewStyle  =UIAlertViewStylePlainTextInput;
        [alert show];
    }
}

-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框获得备注名
    UITextField *FoodListname=[alertView textFieldAtIndex:0];
    //    存储菜谱（CrtTime）Comment  mid
    //    时间
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateformatter setTimeZone:localzone];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    FoodListRecommendModel * model =breakfastArray[0];
    //菜谱id
    NSString * mid =model.MenuId;
    //    NSLog(@"%@",mid);
    NSString * userId = [SingleManager sharedSingleManager].InfoModel.UID;
    //    写到本地
    [FileUtils writeFoodMenuToLocalFoodMenuID:mid Comment:FoodListname.text CrtTime:locationString UserID:userId];
    [UtilCommon alertView:@"添加收藏成功" andMessage:@""];
}
#pragma mark -- 跳转收藏夹
-(void)collect{
    collectionViewController * collection = [[collectionViewController alloc]init];
    collection.date = self.date;
    [self.navigationController pushViewController:collection animated:YES];
}

///通过BMI获取Value
-(NSString *)getValueFromBMI:(float)Bmi{
    NSString * finalstr;
    NSMutableArray * marray = [[NSMutableArray alloc]init];
    NSArray * codeArray = @[@"B01",@"B02",@"B03",@"B04",@"B05",@"B06",@"B07",@"B08"];
    for (int i = 0; i < codeArray.count; i ++) {
        baseLineModel * model  =  [FileUtils getNodeDataUseCodeAttribute:codeArray[i]];
        [marray addObject:model];
    }
    NSMutableArray * backupArray = [[NSMutableArray alloc]init];

    for (baseLineModel * model in marray) {
        [backupArray addObject:model.Backup];
    }
    for (int i = 0 ; i < backupArray.count; i ++) {
        NSString * str = backupArray[i];
        NSArray * array = [str componentsSeparatedByString:@","];
        NSString * datastr1 = array[0];
        NSString * datastr2 = array[1];
        if (datastr1==nil && datastr2.floatValue>Bmi) {
            //            用str作为关键字检索取model 返回model的value
            finalstr = [FileUtils getValueUsingcode:codeArray[i]];
        }else if (datastr1.floatValue>=Bmi && datastr2 == nil){
            finalstr = [FileUtils getValueUsingcode:codeArray[i]];
        }else if (datastr1.floatValue<=Bmi && datastr2.floatValue>Bmi){
            finalstr = [FileUtils getValueUsingcode:codeArray[i]];
        }
    }
    return finalstr;
}
//四舍五入
-(NSString *)roundUp:(float)number afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundUp scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:number];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    
    return [NSString stringWithFormat:@"%@",roundedOunces];
}
//获得食物等级
-(int)getEnergyLevel:(int)energy {
    int levels[24] = { 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000, 2100,
        2200, 2300, 2400, 2500, 2600, 2700, 2800, 2900, 3000, 3100, 3200, 3300, 3400, 3500 };
    for (int i = 0; i < 24; i++) {
        if (i == 0) {
            int min = levels[i];
            int max = levels[i + 1];
            if (energy <= min) {
                return min;
            } else if (energy > min && energy <= max) {
                return max;
            }
        } else if (i == 24 - 1) {
            int max = levels[i];
            if (energy > max) {
                return max;
            }
        } else {
            int min = levels[i];
            int max = levels[i + 1];
            if (energy > min && energy <= max) {
                return max;
            }
        }
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)dealloc{
//    NSLog(@"____%s____",__func__);
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return allArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [allArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (cell== nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    FoodListRecommendModel * model = [allArray[indexPath.section] objectAtIndex:indexPath.row];
    cell.nameLable.text = [FileUtils getFoodNameUseFoodID:model.FoodId];
    cell.intakeLable.text = model.FoodIntake;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 30)];
    label1.backgroundColor=[UIColor colorWithRed:37/255.0 green:122/255.0 blue:247/255.0 alpha:1.0];
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:18];
    FoodListRecommendModel * model = [allArray[section] firstObject];
    if ([model.TimePeriod isEqualToString:DIET_TIMEPER_BRFFAST]){
        label1.text=@"早餐";
    }
    else if([model.TimePeriod isEqualToString:DIET_TIMEPER_EXTRA1]){
        label1.text=@"早餐加餐";
    }
    else if([model.TimePeriod isEqualToString:DIET_TIMEPER_LUNCH]){
        label1.text=@"午餐";
    }else if([model.TimePeriod isEqualToString:DIET_TIMEPER_EXTRA2]){
        label1.text=@"午餐加餐";
    }else if([model.TimePeriod isEqualToString:DIET_TIMEPER_DINNER]){
        label1.text=@"晚餐";
    }else if([model.TimePeriod isEqualToString:DIET_TIMEPER_NTSAKE]){
        label1.text=@"宵夜";
    }
    return label1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    foodDetailController * detail = [[foodDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    FoodListRecommendModel * model = [allArray[indexPath.section]objectAtIndex:indexPath.row];
    detail.eatFoodTime = model.TimePeriod;
    detail.foodId = model.FoodId;
    detail.date = self.date;
    detail.Intaketf = model.FoodIntake;
}

@end
