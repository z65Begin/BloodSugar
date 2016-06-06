//
//  SingleManager.m
//  糖尿病康复伴侣
//
//  Created by 杨冬冬 on 16/3/22.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "SingleManager.h"

@implementation SingleManager

@synthesize InfoModel;
@synthesize foodModel;
+ (SingleManager *)sharedSingleManager
{
    static SingleManager *sharedSingleManager = nil;
    
    @synchronized(self)
    {
        if (!sharedSingleManager)
            sharedSingleManager = [[SingleManager alloc] init];
        return sharedSingleManager;
    }
}
//- (UserInfoModel *)InfoModel{
//    if (!InfoModel) {
//        InfoModel = [[UserInfoModel alloc]init];
//    }
//    return InfoModel;
//}
- (NSArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [NSArray array];
    }
    return _timeArray;
}

@end
