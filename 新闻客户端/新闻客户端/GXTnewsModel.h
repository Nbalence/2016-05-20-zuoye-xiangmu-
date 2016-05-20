//
//  GXTnewsModel.h
//  新闻客户端
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXTnewsModel : NSObject
@property (nonatomic,strong) NSString *title;

-(instancetype) initWithDictionary:(NSDictionary *)dict;
+(instancetype) newsWithDictionary:(NSDictionary *)dict;
@end
