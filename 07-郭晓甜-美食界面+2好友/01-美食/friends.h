//
//  friends.h
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface friends : NSObject

@property (nonatomic,strong) NSString *icon;    //好友头像
@property (nonatomic,strong) NSString *name;    //好友名字
@property (nonatomic,strong) NSString *status;  //好友状态
@property (nonatomic)        BOOL   vip;        //颜色

-(instancetype) initWithFDictionary:(NSDictionary *)dict;
+(instancetype) friendsWithDictionary:(NSDictionary *)dict;


@end
