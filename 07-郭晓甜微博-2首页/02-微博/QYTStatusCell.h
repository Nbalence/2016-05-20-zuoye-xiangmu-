//
//  QYTStatusCell.h
//  02-微博
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYStatusModel;
@interface QYTStatusCell : UITableViewCell
@property (nonatomic,strong) QYStatusModel *statusModel;
@end
