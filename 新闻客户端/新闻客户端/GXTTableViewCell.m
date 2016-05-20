//
//  GXTTableViewCell.m
//  新闻客户端
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GXTTableViewCell.h"
#import "GXTModel.h"

@interface GXTTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fightLabel;

@property (weak, nonatomic) IBOutlet UILabel *numCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@end


@implementation GXTTableViewCell


//引入模型需要重写Set方法来获取模型中的具体数据
-(void)setCellModel:(GXTModel *)cellModel
{
    _cellModel = cellModel;
    _titleLabel.text = cellModel.title;
    _fightLabel.text = cellModel.fight;
    _numCountLabel.text = cellModel.numcount;
    _imgView.image = [UIImage imageNamed:cellModel.icon];
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
