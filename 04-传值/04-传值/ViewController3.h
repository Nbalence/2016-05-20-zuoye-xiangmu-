//
//  ViewController3.h
//  04-传值
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController3 : UIViewController
@property (nonatomic,strong) NSString *descString;
@property (nonatomic,strong) void (^changeDesc)(NSString *text);
@end
