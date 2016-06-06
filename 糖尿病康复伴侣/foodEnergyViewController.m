//
//  foodEnergyViewController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/21.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "foodEnergyViewController.h"
#import "LXMPieView.h"
#import "FoodCataController.h"
#import "foodmodel.h"
@interface foodEnergyViewController ()<LXMPieViewDelegate,UITextFieldDelegate>{

    UILabel * every100SumEnergyData;
    UILabel * every100SumEnergyTitle;
    FoodCataController * food;
    foodmodel * model;
  
}
@property (nonatomic, strong) LXMPieView *pieView;
@property (nonatomic, weak) IBOutlet LXMPieView * roundView;
@property (nonatomic, weak) IBOutlet UIView * whiteView;


@end

@implementation foodEnergyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"食物能量计算器";
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.chooseFoodLable addGestureRecognizer:tap];
    self.chooseFoodLable.layer.cornerRadius =2;
    self.chooseFoodLable.layer.masksToBounds = YES;
    self.chooseFoodLable.layer.borderColor = [[UIColor colorWithRed:61/255.0 green:172/255.0 blue:223/255.0 alpha:1.0]CGColor];
    self.chooseFoodLable.layer.borderWidth =1;
    self.chooseFoodLable.text = @"点击选择食物";
    food = [[FoodCataController alloc]init];
    self.proteinEvery100.text = @"0";
    self.protein.text = @"0";
    self.FatEvery100.text = @"0";
    self.fat.text =@"0";
    self.carbohydrateEvery100.text =@"0";
    self.carbohydrate.text =@"0";
    self.sumEnergy.text =@"0";

    every100SumEnergyTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 100, 20)];
    every100SumEnergyTitle.textAlignment = NSTextAlignmentCenter;
    every100SumEnergyTitle.text = @"总热量";
    every100SumEnergyData = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 20)];
      every100SumEnergyData.text =@"0";
    every100SumEnergyData.textAlignment = NSTextAlignmentCenter;
    every100SumEnergyData.textColor = blueColorWithRGB(61, 172, 225);
    
    self.roundView.layer.cornerRadius = 60.0f;
    self.roundView.layer.borderWidth = 1.0f;
    self.roundView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    self.whiteView.layer.cornerRadius = 50.0f;
    self.whiteView.layer.borderWidth = 1.0f;
    self.whiteView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.whiteView addSubview:every100SumEnergyTitle];
    [self.whiteView addSubview:every100SumEnergyData];
    self.calculate.layer.cornerRadius = 4.0f;
    
    if (food.stateOfPage !=nil) {
        self.chooseFoodLable.text = [SingleManager sharedSingleManager].foodModel.FoodName;
        
    }
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.calculate.enabled = model? YES:NO;
    if (self.calculate.enabled) {
        self.calculate.backgroundColor = blueColorWithRGB(61, 172, 225);
    }else{
        self.calculate.backgroundColor = [UIColor lightGrayColor];
    }
    
    
}
-(void)tap{
     self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self.navigationController pushViewController:food animated:YES];
    food.stateOfPage =@"123";
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData:) name:@"foodmodel" object:nil];
    
}
-(void)reloadData:(NSNotification *)noti{
   
    model = noti.userInfo[@"foodmodel"];
    
    self.chooseFoodLable.text =model.FoodName;
    every100SumEnergyData.text = model.UnitEnergy;
    self.FatEvery100.text = model.UnitFat;
    self.proteinEvery100.text  = model.UnitProtein;
    self.carbohydrateEvery100.text = model.UnitCarbs;

    NSNumber * fat = (NSNumber *)model.UnitFat;
    NSNumber * protein = (NSNumber *)model.UnitProtein;
    NSNumber * carbohydrate = (NSNumber *)model.UnitCarbs;
    NSMutableArray *modelArray = [NSMutableArray array];
 
    NSArray *valueArray = @[protein, fat, carbohydrate];
    NSArray *colorArray = @[[UIColor greenColor],[UIColor redColor],
                            blueColorWithRGB(61, 172, 225)
                            ];
    for (int i = 0 ; i <valueArray.count ; i++) {
        LXMPieModel *model1 = [[LXMPieModel alloc] initWithColor:colorArray[i] value:[valueArray[i] floatValue] text:nil];
        [modelArray addObject:model1];
    }
//    UIView * buttomview = [self.view viewWithTag:400];
    
    self.pieView.frame = self.roundView.frame;
    self.pieView.valueArray = [modelArray copy];
    [self.pieView reloadData];
    
    self.pieView.delegate = self;
   self.pieView.center =self.roundView.center;
    [self.view addSubview:self.pieView];

    
     every100SumEnergyData.text = model.UnitEnergy;
    [self.calculate addTarget:self action:@selector(calculat) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.whiteView];

}
//计算
-(void)calculat{
    float fat  = [model.UnitFat floatValue];
    float protein = [model.UnitProtein floatValue];
    float carbohydrate = [model.UnitCarbs floatValue];
    float unitenergy = [model.UnitEnergy floatValue];
    float inTake = [self.Intake.text floatValue];

    self.fat.text =[NSString stringWithFormat:@"%.1f", (fat/100*inTake) ] ;
    self.protein.text = [NSString stringWithFormat:@"%.1f",(protein/100*inTake)];
    self.carbohydrate.text = [NSString stringWithFormat:@"%.1f",(carbohydrate/100*inTake)];
    self.sumEnergy.text = [NSString stringWithFormat:@"%.1f",(unitenergy/100*inTake) ];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.Intake resignFirstResponder];

}

#pragma mark - LXMPieViewDelegate

- (void)lxmPieView:(LXMPieView *)pieView didSelectSectionAtIndex:(NSInteger)index {
//    NSLog(@"didSelectSectionAtIndex : %@", @(index));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (LXMPieView *)pieView{
    if (!_pieView) {
        _pieView =  [[LXMPieView alloc] initWithFrame:self.roundView.frame values:nil];
    }
    return _pieView;
}



@end
