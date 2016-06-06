//
//  YDDPaiXu.m
//  糖尿病康复伴侣
//
//  Created by 天景隆 on 16/3/13.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YDDPaiXu.h"
#import "ChineseString.h"
#import "pinyin.h"
@implementation YDDPaiXu
+(NSMutableArray *)zhongWenPaiXu:(NSMutableArray *)newArray{
      NSMutableArray *result=[NSMutableArray array];
    //Step1:初始化
    NSMutableArray *stringsToSort=[[NSMutableArray alloc]initWithArray:newArray];
    
    //Step1输出
//    NSLog(@"尚未排序的NSString数组:");
    for(int i=0;i<[stringsToSort count];i++){
//        NSLog(@"%@",[stringsToSort objectAtIndex:i]);
    }
    //Step2:获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[stringsToSort count];i++){
        ChineseString *chineseString=[[ChineseString alloc]init];
        
        chineseString.string=[NSString stringWithString:[stringsToSort objectAtIndex:i]];
        
        if(chineseString.string==nil){
            chineseString.string=@"";
        }
        
        if(![chineseString.string isEqualToString:@""]){
            NSString *pinYinResult=[NSString string];
            for(int j=0;j<chineseString.string.length;j++){
                NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.string characterAtIndex:j])]uppercaseString];
                
                pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
            }
            chineseString.pinYin=pinYinResult;
        }else{
            chineseString.pinYin=@"";
        }
        [chineseStringsArray addObject:chineseString];
    }
    
    //Step2输出
//    NSLog(@"\n\n\n转换为拼音首字母后的NSString数组");
    for(int i=0;i<[chineseStringsArray count];i++){
//        ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
//        NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);
    }

    //Step3:按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    //Step3输出
//    NSLog(@"\n\n\n按照拼音首字母后的NSString数组");
    for(int i=0;i<[chineseStringsArray count];i++){
//        ChineseString *chineseString=[chineseStringsArray objectAtIndex:i];
//        NSLog(@"原String:%@----拼音首字母String:%@",chineseString.string,chineseString.pinYin);
    }
    
    // Step4:如果有需要，再把排序好的内容从ChineseString类中提取出来
  
    
    for(int i=0;i<[chineseStringsArray count];i++){
        [result addObject:((ChineseString*)[chineseStringsArray objectAtIndex:i]).string];
    }
    
    //Step4输出
//    NSLog(@"\n\n\n最终结果:");
    for(int i=0;i<[result count];i++){
//        NSLog(@"%@",[result objectAtIndex:i]);
    }

return result;

}


@end
