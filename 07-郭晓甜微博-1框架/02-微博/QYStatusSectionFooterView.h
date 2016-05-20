//
//  QYStatusSectionFooterView.h
//  02-微博
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYStatusModel;
@interface QYStatusSectionFooterView : UITableViewHeaderFooterView
@property (nonatomic,strong) QYStatusModel *model;
@end
