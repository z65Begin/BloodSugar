//
//  SportDayAddViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/5.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SportDayAddViewController.h"

#import "sportCataModel.h"

#import "SportRecordModel.h"
#import "SportAlertView.h"
//角度转换成弧度
#define  ANGEL(x) x/180.0 * M_PI

#define kPerSecondA     ANGEL(6)
#define kPerMinuteA     ANGEL(6)

@interface SportDayAddViewController ()<UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel * nameLabel;

@property (nonatomic, weak) IBOutlet UILabel * valueLabel;
@property (nonatomic, weak) IBOutlet UILabel * heatLabel;
@property (nonatomic, weak) IBOutlet UILabel * stepNumber;
@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UIView * backGroundView;

@property (nonatomic, weak) IBOutlet UIButton * stopButton;
@property (nonatomic, weak) IBOutlet UIButton * endButton;
@property (nonatomic, weak) IBOutlet UIButton * backButton;

- (IBAction)stopButtonClick:(UIButton*)sender;
- (IBAction)endButtonClick:(UIButton*)sender;
- (IBAction)backButtonClick:(UIButton*)sender;

@property (nonatomic,strong) CALayer *layerSec;
@property (nonatomic,strong) CALayer *layerMin;

@property (nonatomic, assign) int second;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int hour;

@property (nonatomic, strong) NSTimer * timer;


@property (nonatomic, strong) SportRecordModel* model;

@end

@implementation SportDayAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.nameLabel.text = self.cataModel.Name;
    self.valueLabel.text = self.cataModel.Energy;
    
    self.backGroundView.layer.cornerRadius = 50.0f;
    self.backGroundView.layer.borderColor = blueColorWithRGB(45, 156, 255).CGColor;
    self.backGroundView.layer.borderWidth = 2.0f;
    [self.backGroundView.layer addSublayer:self.layerMin];
    [self.backGroundView.layer addSublayer:self.layerSec];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    [_timer setFireDate:[NSDate distantPast]];
    self.second = 0;
    self.minute = 0;
    self.hour = 0;
    self.model = [[SportRecordModel alloc]init];
    self.model.Type = self.cataModel.sid;
    self.model.date = self.date;
    self.model.time = [FileUtils getNowUpdTime];
    
}
- (void)timeChange{
    self.second ++;
    if (self.second==60) {
        self.second = 0 ;//sec=0;
        self.minute ++;
    }
    if (self.minute == 60) {
        self.minute = 0;// min=0;
        self.hour++;
    }
    self.layerSec.transform = CATransform3DMakeRotation(self.second* kPerSecondA, 0, 0, 1);
    self.layerMin.transform = CATransform3DMakeRotation(self.minute * kPerMinuteA, 0, 0, 1);
    NSString * timeStr = nil;
    float heatNumber = (self.hour*60 +self.minute + self.second/60.0)*self.cataModel.Energy.floatValue;
    if (self.hour) {
        timeStr = [NSString stringWithFormat:@"%02d时%02d分%02d秒",self.hour,self.minute,self.second];
    }else{
        timeStr = [NSString stringWithFormat:@"%02d分%02d秒",self.minute,self.second];
    }
    self.timeLabel.text = timeStr;
    self.heatLabel.text = [NSString stringWithFormat:@"%d",(int)heatNumber];
    NSString * value =[FileUtils getValueUsingcode:@"001"];
    self.stepNumber.text = [NSString stringWithFormat:@"%d",(int)(heatNumber*[value floatValue])];
    
}
- (void)stopButtonClick:(UIButton *)sender{
    if (sender.selected) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
        [_timer fire];
    }else{
        [_timer invalidate];
        self.layerSec.transform = CATransform3DMakeRotation(0, 0, 0, 1);
        self.layerMin.transform = CATransform3DMakeRotation(0, 0, 0, 1);
    }
    sender.selected = !sender.selected;
}

- (void)endButtonClick:(UIButton *)sender{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否要结束计时并记录当前数据？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}
- (void)backButtonClick:(UIButton *)sender{
 [self.navigationController popToViewController: [self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}
#pragma mark AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
         [_timer invalidate];
        UIView * backView = [[UIView alloc]initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor darkGrayColor];
        backView.alpha = 0.3;
        SportAlertView * view = [SportAlertView viewWithXIB];
        view.frame = CGRectMake(20, (H-400)/2, W-40, 204);
        [self.view addSubview:backView];
        [self.view addSubview:view];
        __block typeof(view) weakView = view;
        view.chooseChildResult = ^(NSString * resultStr){
            [backView removeFromSuperview];
            [weakView removeFromSuperview];
            self.backButton.hidden = NO;
            self.stopButton.hidden = YES;
            self.endButton.hidden = YES;
            self.model.Result = resultStr;
            self.model.UpdTime = [FileUtils getNowUpdTime];
            self.model.TimeLength = [NSString stringWithFormat:@"%d",(self.second + self.minute*60 + self.hour*60*60)];
            
            [SportFileUtils saveSportRecordWithUID:self.userId andRecordModel:self.model];
        };

    }
    
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
- (CALayer *)layerSec{
    if (_layerSec == nil) {
        _layerSec = [CALayer layer];
        _layerSec.backgroundColor = [UIColor redColor].CGColor;
        _layerSec.cornerRadius = 5;
        _layerSec.anchorPoint = CGPointMake(1, 1);
         _layerSec.frame = CGRectMake(self.backGroundView.bounds.size.width/2, self.backGroundView.bounds.size.height/2 -45, 2, 45);
    }
    return _layerSec;
}

- (CALayer *)layerMin{
    if (_layerMin == nil) {
        _layerMin = [CALayer layer];
//        _layerMin.bounds = CGRectMake(0, 0, 2, 40);
        _layerMin.backgroundColor = [UIColor blackColor].CGColor;
        _layerMin.cornerRadius = 5;
        _layerMin.anchorPoint = CGPointMake(1 , 1);
//        _layerMin.position = CGPointMake(self.backGroundView.bounds.size.width/2, self.backGroundView.bounds.size.height/2);
        
        _layerMin.frame = CGRectMake(self.backGroundView.bounds.size.width/2, self.backGroundView.bounds.size.height/2 -40, 2, 40);
    }
    return _layerMin;
}
@end
