//
//  QYStatusModel.m
//  02-微博
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYStatusModel.h"
#import "Common.h"
#import "QYUserModel.h"
#import "NSDate+Status.h"
#import "NSString+Status.h"

@implementation QYStatusModel

+(instancetype)statusModelWithDictionary:(NSDictionary *)statusInfo{
    return [[self alloc] initWithDictionary:statusInfo];
}

-(instancetype) initWithDictionary:(NSDictionary *)statusInfo
{
    if (self = [super init]) {
        //微博的创建时间
        NSString *createdString = statusInfo[kStatusCreatAt];
        NSDate *createdDate = [NSDate statusDateWithString:createdString];
        _createsAt = [self createdStringWithDate:createdDate];
        //微博ID
        _statusId = statusInfo[kStatusId];
        //内容
        _text = statusInfo[kStatusText];
        //来源
        NSString *sourceHtml = statusInfo[kStatusSource];
        _source = [NSString statusSourceWithHtml:sourceHtml];
        //用户信息
        NSDictionary *userDict = statusInfo[kStatusUser];
        _user = [QYUserModel userWithDictionary:userDict];
        //转发的微博
        NSDictionary *reStatusDict = statusInfo[kStatusRetweetedStatus];
        if (reStatusDict) {
            _retweetedStatus = [QYStatusModel statusModelWithDictionary:reStatusDict];
        }
        //微博图片集合
        _picUrls = statusInfo[kStatusPicUrls];
        //转发数
        _repostsCount = [statusInfo[kStatusRepostsCount] integerValue];
        //评论数
        _commentsCount = [statusInfo[kStatusCommentsCount] integerValue];
        //表态数
        _attitudesCount = [statusInfo[kStatusAttitudesCount] integerValue];
    }
    return self;
}

//根据时间转换显示时间级别
-(NSString *)createdStringWithDate:(NSDate *)date
{
    //首先计算时间差 （date和当前时间差）
    NSTimeInterval interval = -[date timeIntervalSinceNow];
    //然后根据时间差显示级别（秒，分，时，天，日期）
    if (interval < 60) {
        return [NSString stringWithFormat:@"刚刚 %d 秒之前",(int)interval];
    }
    else if (interval < 60 * 60)
    {
        return [NSString stringWithFormat:@"刚刚 %d 分之前",(int)interval];
    }
    else if (interval < 60 * 60 * 24)
    {
        return [NSString stringWithFormat: @"刚刚 %d 小时之前",(int)interval];
    }
    else if (interval < 60 * 60 * 24 * 30)
    {
        return [NSString stringWithFormat:@"刚刚 %d 天前",(int)interval];
    }
    else
    {
        //直接格式化成日期
        /*
         NSDateFormatterStyle取值
         NSDateFormatterNoStyle
         例如:(空白)
         NSDateFormatterShortStyle
         例如: 下午 7:00   |   16/4/19
         NSDateFormatterMediumStyle
         例如: 下午 7:00:00   |    2016年4月19日
         NSDateFormatterLongStyle
         例如: GMT +8 下午 7:00:00    |  2016年4月19日
         NSDateFormatterFullStyle
         例如: 中国标准时间下午7:00:00    |  2016年4月19日 星期二
         */
        
        return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    }
}


@end
