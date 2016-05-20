//
//  NSDate+Status.h
//  02-微博
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Status)
//把微博给的事件字符串转换成NSDate
+(instancetype) statusDateWithString:(NSString *)dateString;
@end
