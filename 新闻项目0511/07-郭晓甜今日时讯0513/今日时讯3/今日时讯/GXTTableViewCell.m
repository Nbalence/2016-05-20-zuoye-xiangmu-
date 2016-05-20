//
//  GXTTableViewCell.m
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTTableViewCell.h"
#import "GXTCellModel.h"

@interface GXTTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fightLabel;
@property (weak, nonatomic) IBOutlet UILabel *numCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end

@implementation GXTTableViewCell


//重写Set方法设置子视图属性
-(void)setCellModel:(GXTCellModel *)cellModel
{
    _cellModel = cellModel;
//    _titleLabel.text = cellModel.title;
//    _fightLabel.text = cellModel.fight;
//    _numCountLabel.text = cellModel.numcount;
//    _imgView.image = [UIImage imageNamed:cellModel.icon];
#if 0
    _titleLabel.text = cellModel.title;
    _fightLabel.text = cellModel.origin;
    //_numCountLabel.text = cellModel.create_time;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSDate *conformTimesp = [NSDate dateWithTimeIntervalSince1970:[cellModel.create_time integerValue]];
    
    _numCountLabel.text = [formatter stringFromDate:conformTimesp];
    
    //图片需要先转换
    NSURL *url = [NSURL URLWithString:cellModel.cover];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _imgView.image = [UIImage imageWithData:data];
    
    
#else
    
    NSURL *url = [NSURL URLWithString:cellModel.thumbnail];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    _imgView.image = [UIImage imageWithData:data];
    _titleLabel.text = cellModel.title;
    _fightLabel.text = cellModel.source;
    //_numCountLabel.text = cellModel.comments;
    
    _numCountLabel.text = cellModel.updateTime;
    
#endif
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
