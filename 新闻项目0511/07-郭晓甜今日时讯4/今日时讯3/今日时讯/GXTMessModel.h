//
//  GXTMessModel.h
//  今日时讯
//
//  Created by qingyun on 16/4/24.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXTMessModel : NSObject
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *des;
@property (nonatomic,strong) NSString *times;

-(instancetype) initWithDictionary:(NSDictionary *)dict;
+(instancetype) messModelWithDictionary:(NSDictionary *)dict;


@end
