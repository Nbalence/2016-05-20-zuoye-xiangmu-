//
//  GXTTableViewCell3.m
//  今日时讯
//
//  Created by qingyun on 16/4/23.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTTableViewCell3.h"
#import "GXTMessModel.h"

@interface GXTTableViewCell3 ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation GXTTableViewCell3

//重写Set方法
-(void)setMessModel:(GXTMessModel *)messModel
{
    _messModel = messModel;
    _desLabel.text = messModel.des;
    _timeLabel.text = messModel.times;
    _imageView3.image = [UIImage imageNamed:messModel.message];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
