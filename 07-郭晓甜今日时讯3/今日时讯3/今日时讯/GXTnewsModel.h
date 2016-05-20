//
//  GXTnewsModel.h
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXTnewsModel : NSObject
@property (nonatomic,strong) NSString *title;

-(instancetype) initWithDictionary:(NSDictionary *)dict;
+(instancetype) newsWithDictionary:(NSDictionary *)dict;
@end
