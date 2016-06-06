//
//  ChatViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "ChatViewController.h"

#import "cx_Advisory.h"

#import "MessageFrame.h"

#import "Message.h"

#import "MessageCell.h"

#import "MBProgressHUD+MJ.h"

#import "Reachability.h"

@interface ChatViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
 NSString * filenameExtension;//字符串扩展名处理
}
@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * contentLabel;
@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UIButton * chooseBtn;

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) IBOutlet UITextField * inputField;

- (IBAction)cx_chooseImage:(UIButton*)sender;
@property (nonatomic, strong) NSMutableArray * datasource;

@property (nonatomic, strong) UIImage * image;

@property (nonatomic, assign) BOOL isDoctor;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    NSString * uid = [SingleManager sharedSingleManager].InfoModel.UID;
    BOOL isDoctor;
    if ((self.advisory.docName&&![self.advisory.docName isEqualToString:@""]) || (self.advisory.docID&&![self.advisory.docID isEqualToString:@""])) {
        isDoctor = YES;
    }else{
        isDoctor = NO;
    }
    self.isDoctor = isDoctor;
    [self cx_setConttent];
    
 NSArray * messageArr = [FileUtils chatHistoryWithUid:uid And:self.advisory.idAddress type:isDoctor];
    for (Message * message in messageArr) {
        MessageFrame * messageFrame = [[MessageFrame alloc]init];
      messageFrame.showTime = (message.type == MessageTypeOther)? YES:NO;
        messageFrame.message = message;
        
        [self.datasource addObject:messageFrame];
    }
    [self.tableView reloadData];
}
- (void)cx_setConttent{
    self.titleLabel.text = self.advisory.title;
    if ((self.advisory.docID == nil)&&(self.advisory.docName == nil)) {
        self.timeLabel.text = [NSString stringWithFormat:@"%@(自己)",self.advisory.updtime];
    }else{
        self.timeLabel.text = [NSString stringWithFormat:@"%@(%@)",self.advisory.updtime,self.advisory.docName];
    }
    self.contentLabel.text = self.advisory.text;
}

#pragma mark tableView datasource && delegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cell";
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell ==nil) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.messageFrame = self.datasource[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.datasource[indexPath.row] cellHeight];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
#pragma mark 点击textField键盘的回车按钮
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus == NotReachable) {
        [UtilCommon alertView:@"提示" andMessage:@"当前无网络连接，无法发送咨询内容"];
        return NO;
    }
    // 1、增加数据源
    NSString *content = textField.text;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    NSDate *date = [NSDate date];
    fmt.dateFormat = @"MM-dd"; // @"yyyy-MM-dd HH:mm:ss"
//    NSString *time = [fmt stringFromDate:date];
//    [self addMessageWithContent:content time:time];
    
//    cx_Advisory * advisory = [[cx_Advisory alloc]init];
    if ([content isEqualToString:@""]) {
        [UtilCommon alertView:@"提示" andMessage:@"咨询内容不能为空"];
        return NO;
    }
//  上传数据
    NSString * nameImage = @"";
    if (self.image) {
        NSString * Extensionstr = [UtilCommon GetFilenameExtension:filenameExtension];
        NSString * time = [UtilCommon GetsTheNumberOfMilliseconds];
        //            NSLog(@"%@fsdfsdfsd",Extensionstr);
        NSString * uuidstr =   [UtilCommon uuidString];
        NSString * filename = [NSString stringWithFormat:@"%@-%@-%@",[SingleManager sharedSingleManager].InfoModel.UID,time,Extensionstr];
        NSString *   str16 = [[UtilCommon hexStringFromString:filename] uppercaseString];//转换成大写字母
        nameImage = str16;
//      MBProgressHUD* hud = [[MBProgressHUD alloc]init];
        [MBProgressHUD showMessage:@"上传图片"];
       [WebUtilsCommon imageUpload:self.image filename:str16  UUID:uuidstr picExtersion:Extensionstr];
        
    }
    if (!self.isDoctor) {
        NSData * data = [WebUtilsCommon upAdvisoryReplyUseUID:[SingleManager sharedSingleManager].InfoModel.UID AndUOrg:[SingleManager sharedSingleManager].InfoModel.Org AndRecId:self.advisory.idAddress AndMaxId:[NSString stringWithFormat:@"%d",(int)self.datasource.count] AndUsrId:[SingleManager sharedSingleManager].InfoModel.UID AndText:textField.text andAdjunct:nameImage];
        //    取时间
        NSString * datatime = [FileUtils getLastTimeOfConsultUseUID:[SingleManager sharedSingleManager].InfoModel.UID];
        data =  [WebUtilsCommon downDoctorAdvisoryUseUID:[SingleManager sharedSingleManager].InfoModel.UID dataTime:datatime];
        [FileUtils analysisDoctorAdvisoryUseData:data andUID:[SingleManager sharedSingleManager].InfoModel.UID];
    }else{
        NSData* data = [WebUtilsCommon upDoctorInstructReplyUseUID:[SingleManager sharedSingleManager].InfoModel.UID AndUOrg:[SingleManager sharedSingleManager].InfoModel.Org AndRecId:self.advisory.idAddress AndMaxId:[NSString stringWithFormat:@"%d",(int)self.datasource.count] AndUsrId:[SingleManager sharedSingleManager].InfoModel.UID AndText:textField.text andAdjunct:nameImage];
        NSString * datatime = [FileUtils getLastTimeOfDocinstructUseUID:[SingleManager sharedSingleManager].InfoModel.UID];
        data =  [WebUtilsCommon downDoctorInstructUseUID:[SingleManager sharedSingleManager].InfoModel.UID andDataTime:datatime];
        [FileUtils analysisDoctorInstructUseData:data andUID:[SingleManager sharedSingleManager].InfoModel.UID];
    }
    NSArray * messageArr = [FileUtils chatHistoryWithUid:[SingleManager sharedSingleManager].InfoModel.UID And:self.advisory.idAddress type:self.isDoctor];
    [self.datasource removeAllObjects];
    for (Message * message in messageArr) {
        MessageFrame * messageFrame = [[MessageFrame alloc]init];
        messageFrame.showTime = (message.type == MessageTypeOther)? YES:NO;
        messageFrame.message = message;
        [self.datasource addObject:messageFrame];
    }
    [self.tableView reloadData];
    
    // 2、刷新表格
//    [self.tableView reloadData];
    // 3、滚动至当前行
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_allMessagesFrame.count - 1 inSection:0];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    // 4、清空文本框内容
    _inputField.text = nil;
    self.image = nil;
    [self.view endEditing:YES];
    
    return YES;
}
- (void)cx_chooseImage:(UIButton *)sender{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        [MBProgressHUD showMessage:@"打开照片图库错误"];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    filenameExtension = info[@"UIImagePickerControllerReferenceURL"];
    self.image = info[@"UIImagePickerControllerOriginalImage"];
    [MBProgressHUD showMessage:@"已成功选择照片"];
    [picker dismissViewControllerAnimated:YES completion:nil];

}


- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    NSLog(@"%s",__func__);
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
