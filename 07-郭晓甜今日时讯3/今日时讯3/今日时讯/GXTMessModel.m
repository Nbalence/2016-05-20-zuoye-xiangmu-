//
//  GXTMessModel.m
//  今日时讯
//
//  Created by qingyun on 16/4/24.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTMessModel.h"

@implementation GXTMessModel
-(instancetype) initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype) messModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
