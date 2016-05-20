//
//  friends.m
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "friends.h"

@implementation friends
-(instancetype) initWithFDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype) friendsWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithFDictionary:dict];
}
@end
