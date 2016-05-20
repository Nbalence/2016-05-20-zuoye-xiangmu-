//
//  friendGroup.h
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface friendGroup : NSObject
@property (nonatomic,strong) NSArray *friends;  //好友组
@property (nonatomic,strong) NSString *name;    //组名
@property (nonatomic)        NSInteger online;  //在线人数
@property (nonatomic)        BOOL isOpen;       //标识当前Section是否打开


-(instancetype) initWithFGDictionary:(NSDictionary *)dict;
+(instancetype) friendGroupWithDictionary:(NSDictionary *)dict;


@end
