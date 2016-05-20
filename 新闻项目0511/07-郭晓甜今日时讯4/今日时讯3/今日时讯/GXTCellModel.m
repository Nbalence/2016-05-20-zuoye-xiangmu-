//
//  GXTCellModel.m
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTCellModel.h"

@implementation GXTCellModel
-(instancetype) initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        //[self setValuesForKeysWithDictionary:dict];
        _title            = dict[@"title"];
        _create_time      = dict[@"create_time"];
        _origin           = dict[@"origin"];
        _cover            = dict[@"cover"];
    }
    return self;
}
+(instancetype) cellWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}
@end
