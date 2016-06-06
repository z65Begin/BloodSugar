//
//  foodDetailController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/14.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "foodDetailController.h"

#import "FoodRecordModel.h"

#import "foodmodel.h"

@interface foodDetailController ()<UITextFieldDelegate>
@property (nonatomic, strong) foodmodel * model;

@property(nonatomic) UITextField * IntakeText;
@end

@implementation foodDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //    NSLog(@"%@",self.model.FoodName);
    //    NSLog(@"%@",self.eatFoodTime);
    [self createNav];
    [self createUI];
    foodmodel * food =[FileUtils getFoodModelWithFoodId:self.foodId];
    self.model = food;
    
}
-(void)createNav{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.title = @"饮食录入";
    UIButton * button  = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.layer.cornerRadius = 3.0f;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:blueColorWithRGB(61,172,223)];
    [button addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem =item;
    
}
-(void)createUI{
    UILabel * lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 40)];
    //    根据id取食物名字
    lbTitle.text =[FileUtils getFoodNameUseFoodID:self.foodId];
    lbTitle.textColor = [UIColor whiteColor];
    lbTitle.backgroundColor = [UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0];
    
    [self.view addSubview:lbTitle];
    UILabel * tLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 60, 30)];
    [self.view addSubview:tLable];
    tLable.text = @"时段";
    [tLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10) ;
        make.top.equalTo(lbTitle.mas_bottom).offset(20);
        
    }];
    UILabel * tLable2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 80, 60, 30)];
    NSString * label1;
    if ([self.eatFoodTime isEqualToString:DIET_TIMEPER_BRFFAST]){
        label1=@"早餐";
    }
    else if([self.eatFoodTime isEqualToString:DIET_TIMEPER_EXTRA1]){
        label1=@"早餐加餐";
    }
    else if([self.eatFoodTime isEqualToString:DIET_TIMEPER_LUNCH]){
        label1=@"午餐";
    }else if([self.eatFoodTime isEqualToString:DIET_TIMEPER_EXTRA2]){
        label1=@"午餐加餐";
    }else if([self.eatFoodTime isEqualToString:DIET_TIMEPER_DINNER]){
        label1=@"晚餐";
    }else if([self.eatFoodTime isEqualToString:DIET_TIMEPER_NTSAKE]){
        label1=@"宵夜";
    }
    tLable2.text = label1;
    [self.view addSubview:tLable2];
    [tLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-10) ;
        make.top.equalTo(lbTitle.mas_bottom).offset(20);
    }];
    UILabel * lbEatMonment = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, 60, 30)];
    lbEatMonment.text = @"摄入量";
    [self.view addSubview:lbEatMonment];
    
    [lbEatMonment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10) ;
        make.top.equalTo(tLable.mas_bottom).offset(20);
        
    }];
    UILabel * unitLable = [[UILabel alloc]initWithFrame:CGRectMake(170, 170, 40, 30)];
    
   
foodmodel * model = [FileUtils getFoodModelWithFoodId:self.foodId];
    
    if ([model.UnitName isEqualToString:@"g"]) {
       unitLable.text = @"克";
    }else{
        unitLable.text = model.UnitName;
    }
    
//    unitLable.text = self.model.UnitName;
    unitLable.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:unitLable];
    [unitLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(tLable2.mas_bottom).offset(20);
        make.top.mas_equalTo(lbEatMonment.mas_top);
        
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    self.IntakeText = [[UITextField alloc]initWithFrame:CGRectMake(100, 170, 60, 30)];
    //    tf.backgroundColor = [UIColor redColor];
    self.IntakeText.layer.cornerRadius = 5;
    self.IntakeText.layer.masksToBounds = YES;
    self.IntakeText.layer.borderWidth = 1.0;
    self.IntakeText.textAlignment = NSTextAlignmentRight;
    self.IntakeText.keyboardType = UIKeyboardTypeNumberPad;
    self.IntakeText.delegate = self;
    self.IntakeText.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0]CGColor];
    [self.view addSubview:self.IntakeText];
    if (self.Intaketf.length) {
        self.IntakeText.text = self.Intaketf;
    }
    [self.IntakeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(unitLable.mas_left).offset(-10) ;
        make.left.equalTo(unitLable.mas_left).offset(-70);
        make.top.mas_equalTo(lbEatMonment.mas_top);
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length > 2 &&![string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.IntakeText resignFirstResponder];
    [self.view endEditing:YES];
}
-(void)save{
    //    NSLog(@"_____%@______",self.Intaketf.text);
    [self.IntakeText resignFirstResponder];
    if (!self.IntakeText.text.length) {
        [UtilCommon alertView:@"提示" andMessage:@"请输入摄入量"];
        return;
    }
    //    保存食物记录
    NSDate * currentDate = [NSDate date];
//    NSLog(@"%@currentDate食物记录",currentDate);
    NSString * str = [NSString stringWithFormat:@"%@",currentDate];
    NSArray * arr = [str componentsSeparatedByString:@"+0000"];
    NSArray * arr2 = [arr[0] componentsSeparatedByString:@" "];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    
    NSString * username = [user objectForKey:USER_ID];
    NSString * time = nil;

    if ([self.eatFoodTime isEqualToString:DIET_TIMEPER_BRFFAST]) {
        time  =[SingleManager sharedSingleManager].timeArray[0];
    }else if ([self.eatFoodTime isEqualToString:DIET_TIMEPER_EXTRA1 ]){
        time  =[SingleManager sharedSingleManager].timeArray[1];
    }else if ([self.eatFoodTime isEqualToString: DIET_TIMEPER_LUNCH]){
        time  =[SingleManager sharedSingleManager].timeArray[2];
    }else if ([self.eatFoodTime isEqualToString: DIET_TIMEPER_EXTRA2]){
        time =[SingleManager sharedSingleManager].timeArray[3];
    }else if ([self.eatFoodTime isEqualToString: DIET_TIMEPER_DINNER]){
        time  =[SingleManager sharedSingleManager].timeArray[4];
    }else if ([self.eatFoodTime isEqualToString: DIET_TIMEPER_NOTFOOD]){
        time =[SingleManager sharedSingleManager].timeArray[5];
    }
   
//    NSString * date = nil;
    
//    if (!(self.date == nil || [self.date isEqualToString:@""])) {
//        date  = self.date;
//    }else{
//        date  = arr2[0];
//    }
    
    [ FileUtils writefoodRecordUserID:username FoodID:self.foodId Intake:self.IntakeText.text timeperiod:self.eatFoodTime time:time UpdTime:[FileUtils getNowUpdTime] RecordDay:self.date];
    FoodRecordModel * model = [[FoodRecordModel alloc]init];
    model.foodId = self.foodId;
    model.intake = self.IntakeText.text;
    model.timeperiod = self.eatFoodTime;
    model.time = time;
    model.updtime = arr[0];
    model.date = arr2[0];
//  BOOL flag = [WebUtilsCommon sendDietRecordWithUID:username andModel:model];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)back{
// UserInfoModel *  infoModel = [FileUtils readUserInfo:name];
//    if () {
//        <#statements#>
//    }
//    
    [self.navigationController popViewControllerAnimated:YES];
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
