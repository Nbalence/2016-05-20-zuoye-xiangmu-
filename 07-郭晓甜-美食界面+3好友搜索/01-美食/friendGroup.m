//
//  friendGroup.m
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "friendGroup.h"
#import "friends.h"

@implementation friendGroup

-(instancetype) initWithFGDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        //然后需要遍历friends，将其中的字典转化成模型
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in self.friends) {
            friends *fr = [friends friendsWithDictionary:dic];
            [models addObject:fr];
        }
        self.friends = models;
    }
    return self;
}
+(instancetype) friendGroupWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithFGDictionary:dict];
}


@end
