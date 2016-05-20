//
//  NSString+Status.h
//  02-微博
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Status)
//从htlm提取字符串中微博来源
+(instancetype) statusSourceWithHtml:(NSString *)html;
@end
