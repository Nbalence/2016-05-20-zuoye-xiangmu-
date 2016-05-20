//
//  GXTTableViewCell.h
//  新闻客户端
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

//首先要引入模型
@class GXTModel;

@interface GXTTableViewCell : UITableViewCell

@property (nonatomic,strong) GXTModel *cellModel;

@end
