//
//  FoodCataController.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/25.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "FoodCataController.h"
#import "foodmodel.h"
#import "foodViewController.h"
@interface FoodCataController ()

@property(nonatomic)NSMutableArray * FoodCateArray;//食物分类列表数组
@property(nonatomic)NSMutableArray * FoodArray;//食物列表数组

@end

@implementation FoodCataController
#pragma mark -- 懒加载
-(NSMutableArray *)FoodCateArray{
    if (_FoodCateArray == nil) {
        _FoodCateArray =[[NSMutableArray alloc]init];
    }
    return _FoodCateArray;
}
-(NSMutableArray *)FoodArray{
    if (_FoodArray == nil) {
        _FoodArray = [[NSMutableArray alloc]init];
    }
    return _FoodArray;
}

#pragma mark -- 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNav];
    self.view.backgroundColor = [UIColor whiteColor];
    //    从本地取食物数据
    [self getFood];
    //创建食物分类
    [self createFoodCata];
}
-(void)createNav{
    self.navigationItem.title =@"食物分类";
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getFood{
    //读取食物分类列表
    self.FoodCateArray = [FileUtils readFCid];
    //    读取食物列表
    self.FoodArray = [FileUtils readFid];
}

-(void)createFoodCata
{
    float height = 40;
    float scrollHeight = (height+10) * self.FoodCateArray.count+80;
    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.alwaysBounceVertical = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    //    scrollView.bounces = NO;
    scrollView.contentSize = CGSizeMake(W, scrollHeight);
    UIButton * btnall = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, W-40, height)];
    [btnall addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    [btnall setTitle:@"全部" forState:UIControlStateNormal];
    btnall.layer.cornerRadius = 5;
    btnall.layer.masksToBounds = YES;
    
    [btnall setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnall setBackgroundColor:[UIColor colorWithRed:117/255.0 green:202/255.0 blue:235/255.0 alpha:1.0]];
    
    btnall.tag = 99;
    [scrollView addSubview:btnall];
    if (self.notDiet) {
        foodmodel * model = self.FoodCateArray[self.FoodCateArray.count-1];
        CGRect  frame = btnall.frame;
        btnall.hidden = YES;
        UIButton * btn = [[UIButton alloc]initWithFrame:frame];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:model.CateName forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:117/255.0 green:202/255.0 blue:235/255.0 alpha:1.0]];
        
        btn.tag = 200;
        [scrollView addSubview:btn];
        
    } else {
        btnall.hidden = NO;
        for (int i = 0; i < self.FoodCateArray.count-1; i ++) {
            foodmodel * model = self.FoodCateArray[i];
            UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 70+i*50, W-40, height)];
            [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:model.CateName forState:UIControlStateNormal];
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor colorWithRed:117/255.0 green:202/255.0 blue:235/255.0 alpha:1.0]];
            
            btn.tag = 100+i;
            
            [scrollView addSubview:btn];
        }
    }
    [self.view addSubview:scrollView];
}
-(void)btnclick:(UIButton *)btn{
    foodViewController * food = [[foodViewController alloc]init];
    [self.navigationController pushViewController:food animated:YES];
    food.date = self.date;
    if(btn.tag == 99){
        NSMutableArray * marray  = [[NSMutableArray alloc]init];
        for (foodmodel * model in self.FoodArray) {
                if ([model.DelFlag isEqualToString:@"0"]) {
                    [marray addObject:model];
                }
            }
        food.dataArray = marray;
        food.foodCateName = @"全部";
        
    }else if(btn.tag == 100){NSMutableArray * marray  = [[NSMutableArray alloc]init];
        for (foodmodel * model in self.FoodArray) {
            if ([model.FoodCateID isEqualToString:@"01"]) {
                if ([model.DelFlag isEqualToString:@"0"]) {
                    [marray addObject:model];
                }
            }
        }
        food.dataArray  = marray;
        foodmodel * model = self.FoodCateArray[btn.tag - 100];
        food.foodCateName =model.CateName;
        
    }else if (btn.tag ==101){
        NSMutableArray * marray  = [[NSMutableArray alloc]init];
        
        for (foodmodel * model in self.FoodArray) {
            if ([model.FoodCateID isEqualToString:@"02"]) {
                if ([model.DelFlag isEqualToString:@"0"]) {
                    [marray addObject:model];
                };
            }
        }
        food.dataArray  = marray;
        foodmodel * model = self.FoodCateArray[btn.tag - 100];
        food.foodCateName =model.CateName;}
    else if (btn.tag ==102){
        NSMutableArray * marray  = [[NSMutableArray alloc]init];
        
        for (foodmodel * model in self.FoodArray) {
            if ([model.FoodCateID isEqualToString:@"03"]) {
                if ([model.DelFlag isEqualToString:@"0"]) {
                    [marray addObject:model];
                };
            }
        }
        food.dataArray  = marray;
        foodmodel * model = self.FoodCateArray[btn.tag - 100];
        food.foodCateName =model.CateName;}else if (btn.tag ==103){
            NSMutableArray * marray  = [[NSMutableArray alloc]init];
            
            for (foodmodel * model in self.FoodArray) {
                if ([model.FoodCateID isEqualToString:@"04"]) {
                    if ([model.DelFlag isEqualToString:@"0"]) {
                        [marray addObject:model];
                    };
                }
            }
            food.dataArray  = marray;
            foodmodel * model = self.FoodCateArray[btn.tag - 100];
            food.foodCateName =model.CateName;
        }else if (btn.tag == 104)
        { NSMutableArray * marray  = [[NSMutableArray alloc]init];
            
            for (foodmodel * model in self.FoodArray) {
                if ([model.FoodCateID isEqualToString:@"05"]) {
                    if ([model.DelFlag isEqualToString:@"0"]) {
                        [marray addObject:model];
                    };
                }
            }
            food.dataArray  = marray;
            foodmodel * model = self.FoodCateArray[btn.tag - 100];
            food.foodCateName =model.CateName;
        }else if (btn.tag == 105)
        { NSMutableArray * marray  = [[NSMutableArray alloc]init];
            
            for (foodmodel * model in self.FoodArray) {
                if ([model.FoodCateID isEqualToString:@"06"]) {
                    if ([model.DelFlag isEqualToString:@"0"]) {
                        [marray addObject:model];
                    };
                }
            }
            food.dataArray  = marray;
            foodmodel * model = self.FoodCateArray[btn.tag - 100];
            food.foodCateName =model.CateName;
        }else if (btn.tag == 106)
        { NSMutableArray * marray  = [[NSMutableArray alloc]init];
            foodmodel * modelCate = self.FoodCateArray[btn.tag - 100];
            for (foodmodel * model in self.FoodArray) {
                if ([model.FoodCateID isEqualToString:@"07"]) {
                    if ([model.DelFlag isEqualToString:@"0"]) {
                        [marray addObject:model];
                    };
                }
            }
            food.dataArray  = marray;
            food.foodCateName =modelCate.CateName;
        }else if (btn.tag == 107)
        { NSMutableArray * marray  = [[NSMutableArray alloc]init];
            
            for (foodmodel * model in self.FoodArray) {
                if ([model.FoodCateID isEqualToString:@"08"]) {
                    if ([model.DelFlag isEqualToString:@"0"]) {
                        [marray addObject:model];
                    };
                }
            }
            food.dataArray  = marray;
            foodmodel * model = self.FoodCateArray[btn.tag - 100];
            food.foodCateName =model.CateName;
        }else if (btn.tag == 108)
        { NSMutableArray * marray  = [[NSMutableArray alloc]init];
            
            for (foodmodel * model in self.FoodArray) {
                if ([model.FoodCateID isEqualToString:@"09"]) {
                    if ([model.DelFlag isEqualToString:@"0"]) {
                        [marray addObject:model];
                    };
                }
            }
            food.dataArray  = marray;
            foodmodel * model = self.FoodCateArray[btn.tag - 100];
            food.foodCateName =model.CateName;
        }else if (btn.tag == 200)
        { NSMutableArray * marray  = [[NSMutableArray alloc]init];
            
            for (foodmodel * model in self.FoodArray) {
                if ([model.FoodCateID isEqualToString:@"10"]) {
                    if ([model.DelFlag isEqualToString:@"0"]) {
                        [marray addObject:model];
                    };
                }
            }
            food.dataArray  = marray;
            foodmodel * model = [self.FoodCateArray lastObject];
            food.foodCateName =model.CateName;
        }
    
    food.eatFoodTime = self.eatFoodTime;
    
    food.stateOfPage =self.stateOfPage;
    
}
@end
