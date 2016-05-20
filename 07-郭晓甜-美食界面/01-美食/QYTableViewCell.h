//
//  QYTableViewCell.h
//  01-美食
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>

//引入模型
@class QYCellModel;
@interface QYTableViewCell : UITableViewCell

@property (nonatomic,strong) QYCellModel *cellModel;

@end
