//
//  QYCellModel.m
//  01-美食
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "QYCellModel.h"

@implementation QYCellModel


-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)modelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end
