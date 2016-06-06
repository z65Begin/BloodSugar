//
//  CXChooseDateYYView.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/18.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "CXChooseDateYYView.h"

@interface CXChooseDateYYView()

@property (nonatomic, weak) IBOutlet UILabel * timeLabel;
@property (nonatomic, weak) IBOutlet UIDatePicker * datePicker;
@property (nonatomic, weak) IBOutlet UIButton * sureBtn;
@property (nonatomic, weak) IBOutlet UIView * backView;

- (IBAction)dateChange:(UIDatePicker*)sender;

- (IBAction)sureButtonClick:(UIButton*)sender;
@end

@implementation CXChooseDateYYView

- (void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backViewClick)];
    [self.backView addGestureRecognizer:tapGR];
}

- (void)backViewClick{
    [self removeFromSuperview];
}
- (void)dateChange:(UIDatePicker *)sender{
    NSDate * date = sender.date;
//    NSLog(@"%@",sender.date);
    
   
    NSString *weekdayStr = [self getWeekDayWithDate:date];
    
    NSString * timeStr = [UtilCommon dateFormateStr:date DATEFORMAT:@"YYYY-MM-dd"];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@%@",timeStr,weekdayStr];
    
//    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    NSDateComponents *comp = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:date];
//    
//    
//    
//    int daycount = [comp weekday] - 2;
//    
//    NSDate *weekdaybegin=[date addTimeInterval:-daycount*60*60*24];
//    
//    NSDate *weekdayend = [date addTimeInterval:(6-daycount)*60*60*24];
//    
//    NSCalendar *mycal = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    unsigned units = NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear|NSCalendarUnitWeekday;
//    //周一
//    
//    comp =[mycal components:units fromDate:weekdaybegin];
//    
//    NSInteger month = [comp month];
//    
//    NSInteger year = [comp year];
//    
//    NSInteger day = [comp day];
//    
//    NSString *date1=[[NSString alloc]initWithFormat:@"%tu:%tu:%tu",year,month,day];//所要求的周一的日期
//    //周日
//    
//    comp = [mycal components:units fromDate:weekdayend];
//    
//    month = [comp month];
//    
//    year = [comp year];
//    
//    day = [comp day];
//    
//    NSString *date2=[[NSString alloc]initWithFormat:@"%tu:%tu:%tu",year,month,day];//所要求的周日的日期
//    
//    NSLog(@"%@-%@",date1,date2);
    
}

- (NSString*)getWeekDayWithDate:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *weekdayStr = nil;
    [formatter setDateFormat:@"c"];
    NSInteger weekday = [[formatter stringFromDate:date] integerValue];
    if( weekday==1 ){
        weekdayStr = @"星期日";
    }else if( weekday==2 ){
        weekdayStr = @"星期一";
    }else if( weekday==3 ){
        weekdayStr = @"星期二";
    }else if( weekday==4 ){
        weekdayStr = @"星期三";
    }else if( weekday==5 ){
        weekdayStr = @"星期四";
    }else if( weekday==6 ){
        weekdayStr = @"星期五";
    }else if( weekday==7 ){
        weekdayStr = @"星期六";
    }
    return weekdayStr;
}

- (void)sureButtonClick:(UIButton *)sender{
//    [FileUtils getLocalDate];
   NSDate * nowDate = [UtilCommon dateFormaterYYYY_MM_DDFromDateStr: [FileUtils getLocalDate]];
    
    if ([nowDate compare:self.datePicker.date] == NSOrderedAscending) {
//        NSLog(@"12323");
        [UtilCommon alertView:@"提示" andMessage:@"不能指定晚于今天的日期"];
    }else{
        if (self.chooseDate) {
            self.chooseDate([UtilCommon dateFormateStr:self.datePicker.date DATEFORMAT:@"YYYY-MM-dd"]);
        }
    }
    [self backViewClick];
//    NSLog(@"我点按钮了 你怕不怕");
}
+ (id)viewWithXIBWithDate:(NSString*)dateStr{
    CXChooseDateYYView * view = [[[NSBundle mainBundle]loadNibNamed:@"CXChooseDateYYView" owner:self options:nil]firstObject];
    NSDate * date = [UtilCommon dateFormaterYYYY_MM_DDFromDateStr:dateStr];
    view.datePicker.date = date;
   NSString * weekdayStr = [view getWeekDayWithDate:date];
    view.timeLabel.text = [NSString stringWithFormat:@"%@%@",dateStr,weekdayStr];
    
    view.frame = CGRectMake(0, 0, W, H);
    
    

    return view;
}

@end
