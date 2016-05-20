//
//  QYTableViewCell.m
//  01-美食
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "QYTableViewCell.h"
#import "QYCellModel.h"

@interface  QYTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *namesLabel;

@end




@implementation QYTableViewCell

//重写setCellModel方法，用来设置子视图属性
-(void)setCellModel:(QYCellModel *)cellModel
{
    _cellModel = cellModel;
    _titleLabel.text = cellModel.title;
    _priceLabel.text = cellModel.price;
    _namesLabel.text = cellModel.buycount;
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
