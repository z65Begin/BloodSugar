//
//  EmailController.m
//  糖尿病康复伴侣
//
//  Created by liuyang on 16/2/19.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "EmailController.h"
#import "innerMailCell.h"
#import "InnerMailModel.h"

#import "EmailDetailController.h"

//#import "MBProgressHUD.h"

@interface EmailController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>{
    
    //    InnerMailModel * model;
    NSArray * Array;
    UITableView *tabview;
}
@property (nonatomic) Reachability *hostReachability;
@property (nonatomic, weak) MBProgressHUD * progressHUB;
@property(nonatomic)NSMutableArray * dataArray;
@end

@implementation EmailController
-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self requestEmailFromWB];
    self.view.backgroundColor = [UIColor colorWithRed:117/255.0 green:202/255.0 blue:235/255.0 alpha:1.0];
    
    [self createNav];
    [self createUI];
}
-(void)requestEmailFromWB{
    [self.dataArray removeAllObjects];
    
    NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
    NSString * username = [userdef objectForKey:USER_ID];
    Array =  [FileUtils readInnerMail:username];
    for (InnerMailModel * model in Array) {
        [self.dataArray addObject:model];
    }
}
-(void)createNav{
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:16];  //设置文本字体与大小
    titleLabel.textColor = [UIColor blackColor];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.text = @"站内信";  //设置标题
    self.navigationItem.titleView = titleLabel;
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self requestEmailFromWB];
    [tabview reloadData];
}

-(void)createUI{
    tabview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, W, H) style:UITableViewStyleGrouped];
    tabview.delegate = self;
    tabview.dataSource = self;
    tabview.separatorColor = [UIColor colorWithRed:117/255.0 green:202/255.0 blue:235/255.0 alpha:1.0];
    
    [self.view addSubview:tabview];
}
//刷新按钮点击事件,重新从网络请求数据写入本地
- (void)cx_RefreshButtonClick{
//    [SingleManager sharedSingleManager].InfoModel.Org
//    [WebUtilsCommon getNoticeAdjFromServerUID:[SingleManager sharedSingleManager].InfoModel.UID Uorg:[SingleManager sharedSingleManager].InfoModel.Org FileName:@"626162612D313436303639313831373630302D4A5047" FileType:@"AdvsAdj"];
    
    MBProgressHUD * mb = [[MBProgressHUD alloc] initWithView:self.view];
    mb.delegate = self;
    mb.mode = MBProgressHUDModeIndeterminate;
    mb.labelText = @"正在获取邮件...";
    [self.view addSubview:mb];
    self.progressHUB = mb;
    [mb showWhileExecuting:@selector(getDataFromserver)  onTarget:self withObject:nil animated:YES];
}
- (void)getDataFromserver{
    NSString *remoteHostName = WEN_SERVER_IP;
    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    [self.hostReachability startNotifier];
    //    站内信
    NSArray *innerMailArr = nil;
    NSString * newUpdateTime = nil;
    NSString * userID = [SingleManager sharedSingleManager].InfoModel.UID;
    
    if ([UtilCommon isConnected:self.hostReachability]) {
        if([FileUtils readInnerMail:userID] != nil){
            innerMailArr = [WebUtilsCommon getInnerMailFromServer:nil andUid:userID];
        }else{
            //读取本地站内信最后更新时间
            NSString *updateTime = [FileUtils readInnerMailUpdateTime:userID];
            //从服务器获取新的站内信
            innerMailArr = [WebUtilsCommon getInnerMailFromServer:updateTime andUid:userID];
            //
            newUpdateTime = [WebUtilsCommon getTimeFromServer:updateTime andUid:userID];
        }
    }
    
    if (innerMailArr != nil && innerMailArr.count > 0) {
        //显示有未读邮件
        //[_emailBtn setImage:[UIImage imageNamed:@"btn_email.png"] forState:UIControlStateNormal];
        //将新的站内信写入本地文件
        [FileUtils writeInnerMail:innerMailArr andUid:userID andNewUpdateTime:newUpdateTime];
    }
}

#pragma mark TableView dataSource && delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * uv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 60)];
    UILabel *lb = [[UILabel alloc]init];
    lb.tintColor = [UIColor blackColor];
    lb.text = @"未读/全部";
    lb.font = [UIFont systemFontOfSize:14.0];
    lb.textAlignment = NSTextAlignmentCenter;
    [uv addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(uv.mas_left).offset(10);
        make.top.equalTo(uv.mas_top).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        
    }];
    UILabel * line = [[UILabel alloc]init];
    line.backgroundColor =  [UIColor colorWithRed:37/255.0 green:122/255.0 blue:247/255.0 alpha:1.0];
    [uv addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(uv.mas_left).offset(10);
        make.top.equalTo(lb.mas_bottom).offset(2);
        make.width.equalTo(@100);
        make.height.equalTo(@1);
        
    }];
    
    UILabel * dataLable = [[UILabel alloc]init];
    int alreadyRead = 0;
    for (InnerMailModel * model in self.dataArray) {
        if ([model.opened isEqualToString:@"false"]) {
            alreadyRead++;
        }
    }
    
    NSString * str  = [NSString stringWithFormat:@"%d/%ld",alreadyRead,self.dataArray.count];
    dataLable.font = [UIFont systemFontOfSize:14.0f];
    dataLable.text = str;
    dataLable.textAlignment = NSTextAlignmentCenter;
    [uv addSubview:dataLable];
    [dataLable mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(uv.mas_left).offset(10);
        make.top.equalTo(line.mas_bottom).offset(2);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
        make.left.mas_equalTo(lb.mas_left);
    }];
    
    UIButton * btn  = [[UIButton alloc]init];
    [btn setTitle:@"刷新" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitleColor:[UIColor colorWithRed:37/255.0 green:122/255.0 blue:247/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_refresh"] forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [uv addSubview:btn];
    [btn addTarget:self action:@selector(cx_RefreshButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(uv.mas_right).offset(10);
        make.top.equalTo(uv.mas_top).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@40);
    }];
    return uv;
}
-(void)refreshdata{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"处理中" message:@"正在获取邮件..." delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil , nil];
    [tabview addSubview:alert];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    innerMailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"innerCell"];
    if (cell== nil) {
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"innerMailCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    InnerMailModel * model = self.dataArray[indexPath.row];
    NSString * sendt = model.sendTime;
    NSArray * strA = [sendt componentsSeparatedByString:@" "];
    
    cell.senderName.text = model.senderName;
    cell.timeLable.text = strA[0];
    cell.titleLable.text = model.title;
    cell.emailDescription.text = model.content;
    if(model.Adjunct != nil){
        cell.addFiles.image = [UIImage imageNamed:@"ico_adjunct"];
    }
    if ([model.opened isEqualToString:@"ture"]) {
        [cell.readEmailState setImage:[UIImage imageNamed:@"ico_mail_open"]];
    }else{
        [cell.readEmailState setImage:[UIImage imageNamed:@"ico_mail_close"]];
        
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InnerMailModel *innerMail = self.dataArray[indexPath.row];
    //    设置已读
    NSUserDefaults * userdef = [NSUserDefaults standardUserDefaults];
    NSString * username = [userdef objectForKey:USER_ID];
    [FileUtils writeInnerMailReadStateUid:username mailId:innerMail.mid state:@"ture"];
    
    EmailDetailController * detail = [[EmailDetailController alloc]initWithNibName:@"EmailDetailController" bundle:nil];
    detail.navigationItem.title = @"站内信";
    [self.navigationController pushViewController:detail animated:YES];
    detail.innerMailArr =self.dataArray;
    detail.index = indexPath.row;
}
@end
