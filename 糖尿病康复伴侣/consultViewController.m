//
//  consultViewController.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/4/11.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "consultViewController.h"
#import "UserInfoModel.h"

#import "MBProgressHUD/MBProgressHUD+MJ.h"

@interface consultViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITextField * titleTextField;//标题
    UITextView * contentView;//内容
    UIImageView * chooseImageView;//选择后图片
    BOOL isChoosePicture;//选择图片标志位
    NSString * filenameExtension;//字符串扩展名处理
    UserInfoModel * model;//用户infomodel
}
@end

@implementation consultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNav];
    [self createUI];
}
//返回
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
//提交
-(void)submit{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        [MBProgressHUD showMessage:@"您没有打开数据连接，无法执行同步操作。"];
        return;
    }
    
    model =  [FileUtils readUserInfo:self.uid];
    if (titleTextField.text.length>20) {
        [UtilCommon alertView:@"提示" andMessage:@"标题过长"];
        return;
    }
    if ([titleTextField.text isEqualToString:@""]) {
        [UtilCommon alertView:@"提示" andMessage:@"请输入标题。"];
        return;
    }
    if([contentView.text isEqualToString:@""]){
        [UtilCommon alertView:@"提示" andMessage:@"请输入内容。"];
        return;
    }else{
        if (!isChoosePicture) {
            if([WebUtilsCommon upDocAdvisoryUseUID:self.uid andUOrg:model.Org andTitle:titleTextField.text TEXT:contentView.text andAdjunt:@""]){
                [UtilCommon alertView:@"提示" andMessage:@"上传成功"];
            }
        }else{
            //        先传图片(生成uuid)filename 需要拼接名字
            NSString * Extensionstr = [UtilCommon GetFilenameExtension:filenameExtension];
            NSString * time = [UtilCommon GetsTheNumberOfMilliseconds];
            NSString * uuidstr =   [UtilCommon uuidString];
            NSString * filename = [NSString stringWithFormat:@"%@-%@-%@",model.UID,time,Extensionstr];
            NSString *   str16 = [UtilCommon hexStringFromString:filename];
            if  ([WebUtilsCommon imageUpload:chooseImageView.image filename:[str16 uppercaseString]UUID:uuidstr picExtersion:Extensionstr]){
                if([WebUtilsCommon upDocAdvisoryUseUID:self.uid andUOrg:model.Org andTitle:titleTextField.text TEXT:contentView.text andAdjunt:str16]){
                    [UtilCommon alertView:@"提示" andMessage:@"上传成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
            else{
                [UtilCommon alertView:@"提示" andMessage:@"上传失败"];
                return;
            }
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [titleTextField resignFirstResponder];
    [contentView resignFirstResponder];
    
}
-(void)createUI{
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.text = @"标题(20字以内)";
    titleLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@25);
    }];
    
    titleTextField = [[UITextField alloc]init];
    titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:titleTextField];
    [titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLable.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@25);
    }];
    UILabel * contentLable = [[UILabel alloc]init];
    contentLable.text = @"咨询内容(500字以内)";
    contentLable.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleTextField.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@25);
        
    }];
    contentView = [[UITextView alloc]init];
    contentView.layer.cornerRadius = 3;
    contentView.layer.masksToBounds = YES;
    contentView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    contentView.layer.borderWidth = 0.3;
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLable.mas_bottom).offset(5);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-5);
        make.height.equalTo(@200);
        
    }];
    
    UIButton * chooseButton = [[UIButton alloc]init];
    [chooseButton addTarget:self action:@selector(selectForAlbumButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [chooseButton setTitle:@"选择照片" forState:UIControlStateNormal];
    [chooseButton setBackgroundColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]];
    [chooseButton setTintColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]];
    [self.view addSubview:chooseButton];
    [chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(15);
        make.left.equalTo(contentView.mas_left).offset(5);
        make.height.equalTo(@45);
        make.width.equalTo(@100);
        
    }];
    UIButton * takephoto = [[UIButton alloc]init];
    [takephoto addTarget:self action:@selector(selectForCameraButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [takephoto setTitle:@"拍照" forState:UIControlStateNormal];
    [takephoto setBackgroundColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]];
    [takephoto setTintColor:[UIColor colorWithRed:52/255.0 green:182/255.0 blue:225/255.0 alpha:1.0]];
    [self.view addSubview:takephoto];
    [takephoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(15);
        make.left.equalTo(chooseButton.mas_right).offset(5);
        make.height.equalTo(@45);
        make.width.equalTo(@100);
        
    }];
    
    chooseImageView = [[UIImageView alloc]init];
    [self.view addSubview:chooseImageView];
    [chooseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(5);
        make.left.equalTo(takephoto.mas_right).offset(10);
        make.height.equalTo(@72);
        make.width.equalTo(@72);
        
    }];
}

//访问相册
-(void)selectForAlbumButtonClick{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"访问图片库错误"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    }
}
//访问摄像头
-(void)selectForCameraButtonClick{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"不可使用摄像功能"
                              message:@""
                              delegate:nil
                              cancelButtonTitle:@"OK!"
                              otherButtonTitles:nil];
        [alert show];
    }
}
#pragma Delegate method UIImagePickerControllerDelegate
//图像选取器的委托方法，选完图片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    filenameExtension = [NSString stringWithFormat:@"%@",editingInfo];
    chooseImageView.image =image; //imageView为自己定义的UIImageView
    isChoosePicture = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)creatNav{
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.title = @"提出咨询";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 30);
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:61/255.0 green:172/255.0 blue:225/255.0 alpha:1.0]];
    button.layer.cornerRadius = 3.0f;
    [button addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
   
    UIBarButtonItem * rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    //    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submit)];
    self.navigationItem.rightBarButtonItem =rightBarButtonItem;
}

- (void)dealloc{
    NSLog(@"____%s______",__func__);
}


@end
