//
//  BodySignModel.h
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BodySignModel : NSObject

@property (nonatomic, copy) NSString * date;
@property (nonatomic, copy) NSString * UpdTime;
@property (nonatomic, copy) NSString * Weight;
@property (nonatomic, copy) NSString * DBP;
@property (nonatomic, copy) NSString * SBP;
@property (nonatomic, copy) NSString * Temperature;
@property (nonatomic, copy) NSString * BlipidChol;
@property (nonatomic, copy) NSString * BlipidTG;
@property (nonatomic, copy) NSString * BlipidHDLIP;
@property (nonatomic, copy) NSString * BlipidLDLIP;
@property (nonatomic, copy) NSString * GlyHemoglobin;
@property (nonatomic, copy) NSString * TotalBilirubin;
@property (nonatomic, copy) NSString * DirectBilirubin;
@property (nonatomic, copy) NSString * SerumCreatinine;
@property (nonatomic, copy) NSString * UricAcid;
@property (nonatomic, copy) NSString * MiAlbuminuria;
@property (nonatomic, copy) NSString * Fundus;
@property (nonatomic, copy) NSString * Plantar;
- (NSDictionary *)getAllPropertiesAndVaules;

@end
