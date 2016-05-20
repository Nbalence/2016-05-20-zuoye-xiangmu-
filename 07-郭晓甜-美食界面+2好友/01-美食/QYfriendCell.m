//
//  QYfriendCell.m
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "QYfriendCell.h"
#import "friends.h"

@implementation QYfriendCell

//初始化
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

//重写Set方法
-(void)setFr:(friends *)fr
{
    _fr = fr;
    
    self.imageView.image = [UIImage imageNamed:fr.icon];
    self.textLabel.text = fr.name;
    self.detailTextLabel.text = fr.status;
    
    //需要有一个标识，来根据VIP状态设置textLabel的颜色
    self.textLabel.textColor = fr.vip ? [UIColor redColor] : [UIColor blackColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
