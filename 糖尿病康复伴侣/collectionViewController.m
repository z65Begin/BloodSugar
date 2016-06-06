//
//  collectionViewController.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/29.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "collectionViewController.h"
#import "collectionTableViewCell.h"
#import "collectionModel.h"
#import "collectionDetailController.h"
@interface collectionViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
 CAGradientLayer *_gradientLayer;
    UITableView * collectiontableView;
    long int rowNum;//行数（用来确定哪个删除按钮被点击）
}
@property(nonatomic)NSMutableArray * dataSouceMArray;

@end

@implementation collectionViewController
-(NSMutableArray *)dataSouceMArray{
    if (_dataSouceMArray == nil) {
        _dataSouceMArray = [[NSMutableArray alloc]init];
    }
    return _dataSouceMArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    

   
//    NSLog(@"%@dataSouceMArray",self.dataSouceMArray);
//    创建UI
    [self createUI];
    
}
-(void)createNav{
 UILabel *   titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor blackColor];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"收藏夹";
    self.navigationItem.titleView = titleLabel;
    
}
-(void)viewWillAppear:(BOOL)animated{
    //    去userId
    NSString * userId = [SingleManager sharedSingleManager].InfoModel.UID;
    //    取数据
    self.dataSouceMArray = [FileUtils getFoodMenuOfFavoriteUserID:userId];


}
-(void)createUI{
    UIView * uv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 60)];
    _gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    _gradientLayer.bounds = uv.bounds;
    _gradientLayer.borderWidth = 0;
    
    _gradientLayer.frame = uv.bounds;
    _gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[[UIColor colorWithRed:49/255.0 green:118/255.0 blue:191/255.0 alpha:1.0] CGColor],
                             (id)[[UIColor colorWithRed:108/255.0 green:170/255.0 blue:231/255.0 alpha:1.0] CGColor], nil];
    _gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    _gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    
    [uv.layer insertSublayer:_gradientLayer atIndex:0];
    [self.view addSubview:uv];
    
    NSArray * LableNameArray = @[@"序号",@"备注",@"收藏时间"];
    for (int i = 0; i < 3; i ++) {
        UILabel* lb = [[UILabel alloc]initWithFrame:CGRectMake(0+W/3*i, 0, W/3, 60)];
        lb.text = LableNameArray[i];
        lb.textAlignment =NSTextAlignmentLeft;
        lb.textColor = [UIColor whiteColor];
        lb.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:lb];
    }

    collectiontableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, W, H-60) style:UITableViewStylePlain];
    collectiontableView.delegate = self;
    collectiontableView.dataSource = self;
    [self.view addSubview:collectiontableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataSouceMArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    collectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"collectionViewCell"];
    if (cell == nil) {
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"collectionTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
//    *serialNumber;//序号
// remarks;//备注
//collectTime;//收藏时间
    cell.serialNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    collectionModel * model = self.dataSouceMArray[indexPath.row];
    
    cell.remarks.text =model.Comment;

    cell.collectTime.text = model.CrtTime;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"ico_recycle"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(280, 10, 30, 30)];
    
    [button addTarget:self action:@selector(del:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cell.contentView.mas_right).offset(-5);
        make.top.equalTo(cell.contentView.mas_top).offset(10);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
        
    }];


    cell.tag = [indexPath row];

   NSArray *subviews = [cell.contentView subviews];
  for(id view in subviews)
 {
    if([view isKindOfClass:[UIButton class]])
    {
        [view setTag:[indexPath row]];
        [cell.contentView bringSubviewToFront:view];
    }
}
    return cell;

}
-(void)del:(UIButton *)button
{UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要删除当前项？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
    alert.delegate = self;
    [alert show];
    
    
    NSArray *visiblecells = [collectiontableView visibleCells];
    for(UITableViewCell *cell in visiblecells)
    {
        if(cell.tag == button.tag)
        { NSLog(@"%ld",cell.tag);
            rowNum = cell.tag;
            
//            [array removeObjectAtIndex:[cell tag]];
//            [table reloadData];
            break;
        }
    }
}

#pragma mark  -- alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
if(buttonIndex == 1)
{
//删除当前这条数据
    collectionModel * model = self.dataSouceMArray[rowNum];
      NSString * userId = [SingleManager sharedSingleManager].InfoModel.UID;
    [FileUtils deleteNodeUseMID:model.mid andUID:userId];
 
    //    取数据
    self.dataSouceMArray = [FileUtils getFoodMenuOfFavoriteUserID:userId];
    [collectiontableView reloadData];
    
}


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"style:UIBarButtonItemStylePlain target:nil action:nil];
    
    collectionDetailController * detail = [[collectionDetailController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
  
  collectionModel * model =   self.dataSouceMArray[indexPath.row];

    detail.menuID =model.mid;


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
