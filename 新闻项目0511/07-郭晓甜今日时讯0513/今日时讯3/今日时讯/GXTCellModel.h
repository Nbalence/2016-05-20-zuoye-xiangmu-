//
//  GXTCellModel.h
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXTCellModel : NSObject

////首先设置plist文件中的属性
//@property (nonatomic,strong) NSString *icon;
//@property (nonatomic,strong) NSString *title;
//@property (nonatomic,strong) NSString *fight;
//@property (nonatomic,strong) NSString *numcount;
#if 0
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *cover;
@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *origin;

#else

@property (nonatomic, strong) NSString *title;//标题
@property (nonatomic, strong) NSString *source;//来源
@property (nonatomic, strong) NSString *commentsall;//
@property (nonatomic, strong) NSString *comments;//评论
@property (nonatomic, strong) NSString *thumbnail;//图片
@property (nonatomic, strong) NSString *ID;//内容网址
@property (nonatomic, strong) NSString *updateTime;//更新时间

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableArray *images;


#endif




-(instancetype) initWithDictionary:(NSDictionary *)dict;
+(instancetype) cellWithDictionary:(NSDictionary *)dict;

@end
