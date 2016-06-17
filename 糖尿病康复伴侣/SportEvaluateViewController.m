//
//  SportEvaluateViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/9.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportEvaluateViewController.h"

#import "SportRecordModel.h"

#import "LXMPieView.h"

#import "SportEvaluateCell.h"

#import "ShareChooseView.h"
#import "WXApi.h"
@interface SportEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource,MBProgressHUDDelegate>

@property (nonatomic, weak) IBOutlet UILabel * dateLabel;
@property (nonatomic, weak) IBOutlet UIButton * shareButton;
@property (nonatomic, weak) IBOutlet UIView * animationView;
@property (nonatomic, weak) IBOutlet UILabel * hotEnergyLabel;
@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UILabel * countLabel;
@property (nonatomic, weak) IBOutlet UITableView * tableView;

@property (nonatomic, weak) IBOutlet UILabel * baseLineStep;
@property (nonatomic, weak) IBOutlet UILabel * stepCurrent;
@property (nonatomic, weak) IBOutlet UIView * littleView;

@property (nonatomic, assign) int scene;
@property (nonatomic, strong) MBProgressHUD* HUD;

- (IBAction)shareBtnClick:(UIButton*)sender;

@property (nonatomic, strong) NSArray * dataSource;

@end

@implementation SportEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.date = @"2016-04-28";
//    self.sportEnergy = 258;
    self.animationView.layer.cornerRadius = 50.0f;
    self.animationView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.animationView.layer.borderWidth = 1.0f;

    self.littleView.layer.cornerRadius = 40.0f;
    self.littleView.layer.borderWidth = 0.5f;
    self.littleView.layer.borderColor = [UIColor grayColor].CGColor;
   
    self.navigationItem.title = @"运动评价";
    
    self.dateLabel.text = [UtilCommon dateForTitleFormatStr:self.date];//日期
    NSArray * sportArray = [FileUtils readSportRecordWithUID:self.userId andDate:self.date];
    self.dataSource = [sportArray copy];
    self.hotEnergyLabel.text = [NSString stringWithFormat:@"%d",(int)self.sportEnergy];
    int  timeLength = 0;
   

    for (SportRecordModel * model in sportArray) {
        timeLength += model.TimeLength.intValue;
    }
    int hour = 0;
    int minite = 0;
    int second = 0;
    NSString * timeStr = [[NSString alloc]init];
    if (timeLength/(60*60)) {
        hour = timeLength/(60*60);
    }
    if (timeLength%(60*60)/60) {
        minite = timeLength%(60*60)/60;
    }
    if ((timeLength%(60*60))%60) {
        second = (timeLength%(60*60))%60;
    }
    if (hour) {
       timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d时",hour]];
    }
    if (minite) {
     timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d分",minite]];
    }
    if (second) {
       timeStr = [timeStr stringByAppendingString:[NSString stringWithFormat:@"%d秒",second]];
    }
    if (!hour&&!minite&&!second) {
        timeStr = [timeStr stringByAppendingString:@"0秒"];
    }
    self.timeLabel.text = timeStr;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",sportArray.count];
   
//    [UtilCommon strDateFromDateStr:self.date] 更改时间格式
   NSArray * array = [FileUtils getTargetFootStepUseUID:self.userId andDate:[UtilCommon strDateFromDateStr:self.date]];
    NSString * targetSteps = NULL;
    if ([array[0] isEqualToString:@""]) {
       targetSteps = @"5000";
    }else{
        targetSteps = array[0];
    }
//    折算的步数 和 设置的目标步数
    NSString* stepBase = [FileUtils getValueUsingcode:@"001"];
    int step = (int)stepBase.floatValue * self.sportEnergy; //折算的步数
    self.baseLineStep.text = targetSteps;
    self.stepCurrent.text = [NSString stringWithFormat:@"%d",step];
    
    LXMPieModel * model = [[LXMPieModel alloc]initWithColor:blueColorWithRGB(61, 172, 225) value:step text:nil];
    LXMPieModel * model1 = [[LXMPieModel alloc]initWithColor:[UIColor whiteColor] value:targetSteps.floatValue text:nil];
    LXMPieView * lxmView = [[LXMPieView alloc]initWithFrame:self.animationView.bounds values:nil];
    lxmView.valueArray = [NSArray arrayWithObjects:model,model1, nil];
    [lxmView reloadData];
    
    [self.animationView addSubview:lxmView];
    [self.animationView bringSubviewToFront:self.littleView];
    
    self.tableView.allowsSelection = NO;
}
#pragma mark 分享按钮点击事件
- (void)shareBtnClick:(UIButton *)sender{
    ShareChooseView * view = [ShareChooseView viewWithXIB];
    view.shareChoice = ^(NSInteger scene){
        if (scene!=1 && scene!=0) {
            return ;
        }
        self.scene = (int)scene;
        self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        _HUD.delegate = self;
        _HUD.mode = MBProgressHUDModeIndeterminate;
        _HUD.labelText = @"正在上传文件";
        [_HUD showWhileExecuting:@selector(upDataToSever)  onTarget:self withObject:nil animated:YES];
    };
    [self.view addSubview:view];

}
- (void)upDataToSever{
    if (![WXApi isWXAppInstalled]) {
        _HUD.labelText = @"您未安装微信";
        return;
    }
    //   截屏
    CGRect rect =self.view.frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    float originX = 0 ;
    float originY = 0;
    float width = W;
    float height  = 250;
    //你需要的区域起点,宽,高;
    CGRect rect1 = CGRectMake(originX , originY , width , height);
    UIImage * image = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([img CGImage], rect1)];
    
    NSString * time = [UtilCommon GetsTheNumberOfMilliseconds];
    //            NSLog(@"%@fsdfsdfsd",Extensionstr);
    NSString * uuidstr =   [UtilCommon uuidString];
    NSString * filename = [NSString stringWithFormat:@"%@-%@-PNG",self.userId,time];
    NSString *   str16 = [UtilCommon hexStringFromString:filename];
    
    BOOL flag = [WebUtilsCommon imageUpload:image filename:[str16 uppercaseString] UUID:uuidstr picExtersion:@"PNG"];
    if (flag) {
        _HUD.labelText = @"文件上传成功，正在上传数据";
        NSString * sidStr = [WebUtilsCommon upToSeverOfWeixinWithUID:self.userId andSportArray:[SportFileUtils readSportRecordWithUID:self.userId andDate:self.date] ImageName:[str16 uppercaseString] andDate:self.date];
        NSString *kLinkURL = [NSString stringWithFormat:@"http://www.halsma.com/healthdiabetes/client/wxshare.showSport.action?sid=%@",sidStr];
        static NSString *kLinkTitle = @"看看我的运动。";
        static NSString *kLinkDescription = @"我的运动，小伙伴们来比比吧。";
        //创建发送对象实例
        SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
        sendReq.bText = NO;  //不使用文本信息
        sendReq.scene = self.scene;
        //        sendReq.text = @"dadadadad";
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title = kLinkTitle;//分享标题
        urlMessage.description = kLinkDescription;//分享描述
        [urlMessage setThumbImage:[UIImage imageNamed:@"logo.png"]];
        //创建多媒体对象
        WXWebpageObject *webObj = [WXWebpageObject object];
        webObj.webpageUrl = kLinkURL;//分享链接
        //完成发送对象实例
        urlMessage.mediaObject = webObj;
        sendReq.message = urlMessage;
        [WXApi sendReq:sendReq];
    }
}

#pragma  mark tableView datasource && delehate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SportEvaluateCell * cell = [SportEvaluateCell cellWithXIBForTableView:tableView andSportEnergy:self.sportEnergy];
    SportRecordModel * model = [self.dataSource objectAtIndex:indexPath.row];
    [cell cellWithSportModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 2;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(0, 0, W, 2);
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSArray  array];
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
