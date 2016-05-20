//
//  GXTCellModel.h
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXTCellModel : NSObject

//首先设置plist文件中的属性
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *fight;
@property (nonatomic,strong) NSString *numcount;

-(instancetype) initWithDictionary:(NSDictionary *)dict;
+(instancetype) cellWithDictionary:(NSDictionary *)dict;

@end
