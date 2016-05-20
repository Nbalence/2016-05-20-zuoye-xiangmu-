//
//  GXTCollectionViewCell.m
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTCollectionViewCell.h"
#import "GXTnewsModel.h"

@interface GXTCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titles;
@end

@implementation GXTCollectionViewCell

//重写Set方法
-(void)setNewsModel:(GXTnewsModel *)newsModel
{
    _newsModel = newsModel;
    _titles.text = newsModel.title;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
