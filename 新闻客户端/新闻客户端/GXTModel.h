//
//  GXTModel.h
//  新闻客户端
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXTModel : NSObject

//首先设置plist文件属性
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *numcount;
@property (nonatomic,strong) NSString *fight;

//然后是初始化方法
-(instancetype) initWithDictionary:(NSDictionary *)dict;
+(instancetype) modelWithDictionary:(NSDictionary *)dict;

@end
