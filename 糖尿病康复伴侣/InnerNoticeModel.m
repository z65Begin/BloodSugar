//
//  InnerNoticeModel.m
//  HalsmaForIos
//
//  Created by liuyang on 15/12/21.
//  Copyright © 2015年 hbis. All rights reserved.
//

#import "InnerNoticeModel.h"

@implementation InnerNoticeModel

+(id)innerNoticeModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
