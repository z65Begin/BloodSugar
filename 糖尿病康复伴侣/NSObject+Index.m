//
//  NSObject+Abcdefg.m
//  zhenlipain
//
//  Created by invoker on 15/3/23.
//
//
#include "pinyin.h"
#import "NSObject+Index.h"
#import "ChineseString.h"

@implementation NSObject (Index)


- ( NSMutableArray *)getChineseStringArr:( NSMutableArray *)arrToSort andSck:(NSMutableArray *)_sectionHeadsKeys

{
    
    // 创建一个临时的变动数组
     NSMutableArray *chineseStringsArray = [ NSMutableArray array ];
    
    for ( int i = 0 ; i < [arrToSort count ]; i++)
    {
         // 创建一个临时的数据模型对象
        ChineseString *chineseString=[[ ChineseString alloc ] init ];
        // 给模型赋值
        chineseString. string =[ NSString stringWithString :[arrToSort objectAtIndex :i]];
        if (chineseString. string == nil )
        {
            chineseString. string = @"" ;
        }
        if (![chineseString. string isEqualToString : @"" ])
        {
             //join( 链接 ) the pinYin (letter 字母 )  链接到首字母
            NSString *pinYinResult = [ NSString string ];
             // 按照数据模型中 row 的个数循环
            for ( int j = 0 ;j < chineseString. string . length ; j++)
            {
                NSString *singlePinyinLetter = [[ NSString stringWithFormat : @"%c" ,
                                                 pinyinFirstLetter ([chineseString. string characterAtIndex :j])] uppercaseString ];
                pinYinResult = [pinYinResult stringByAppendingString :singlePinyinLetter];
            }
            chineseString. pinYin = pinYinResult;
        } else {
            chineseString. pinYin = @"" ;
        }
        [chineseStringsArray addObject :chineseString];
        }
    //sort( 排序 ) the ChineseStringArr by pinYin( 首字母 )
    
    NSArray *sortDescriptors = [ NSArray arrayWithObject :[ NSSortDescriptor sortDescriptorWithKey : @"pinYin" ascending : YES ]];
    [chineseStringsArray sortUsingDescriptors :sortDescriptors];
    NSMutableArray *arrayForArrays = [ NSMutableArray array ];
    BOOL checkValueAtIndex= NO ;  //flag to check
     NSMutableArray *TempArrForGrouping = nil ;
    for ( int index = 0 ; index < [chineseStringsArray count ]; index++)
        {
            ChineseString *chineseStr = ( ChineseString *)[chineseStringsArray objectAtIndex :index];
        NSMutableString *strchar= [ NSMutableString stringWithString :chineseStr. pinYin ];
       NSString *sr= [strchar substringToIndex : 1 ];
       //sr containing here the first character of each string  ( 这里包含的每个字符串的第一个字符 )
//        NSLog ( @"%@" ,sr);
       //here I'm checking whether the character already in the selection header keys or not  ( 检查字符是否已经选择头键 )
        if (![ _sectionHeadsKeys containsObject :[sr uppercaseString ]])
        {
            [ _sectionHeadsKeys addObject :[sr uppercaseString ]];
            TempArrForGrouping = [[ NSMutableArray alloc ] initWithObjects : nil ] ;
            checkValueAtIndex = NO ;
        }
        if ([ _sectionHeadsKeys containsObject :[sr uppercaseString ]])
        {
            [TempArrForGrouping addObject :[chineseStringsArray objectAtIndex :index]];
            if (checkValueAtIndex == NO )
            {
                [arrayForArrays addObject :TempArrForGrouping];
                checkValueAtIndex = YES ;
            }
         }
     }
    return arrayForArrays;
}

@end
