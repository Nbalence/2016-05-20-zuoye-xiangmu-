//
//  GXTCollectionViewCell.h
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GXTnewsModel;
@interface GXTCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) GXTnewsModel *newsModel;
@end
