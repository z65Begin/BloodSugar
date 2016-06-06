//
//  BodySignModel.m
//  糖尿病康复伴侣
//
//  Created by Admin on 16/5/3.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "BodySignModel.h"

#import <objc/runtime.h>
@implementation BodySignModel

- (NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties =class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}


@end
