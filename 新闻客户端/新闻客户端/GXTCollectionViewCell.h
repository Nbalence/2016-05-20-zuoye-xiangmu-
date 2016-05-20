//
//  GXTCollectionViewCell.h
//  新闻客户端
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GXTnewsModel;
@interface GXTCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) GXTnewsModel *newsModel;
@end
