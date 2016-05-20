//
//  GXTCollectionViewCell.m
//  新闻客户端
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GXTCollectionViewCell.h"
#import "GXTnewsModel.h"

@interface GXTCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titles;

@end


@implementation GXTCollectionViewCell

//需要重写Set方法
-(void)setNewsModel:(GXTnewsModel *)newsModel
{
    _newsModel = newsModel;
    _titles.text = newsModel.title;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
