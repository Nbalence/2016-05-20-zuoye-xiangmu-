//
//  QYStatusSectionFooterView.m
//  02-微博
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYStatusSectionFooterView.h"
#import "QYStatusModel.h"
#import "Masonry.h"
#import "Common.h"

@interface QYStatusSectionFooterView ()
@property (nonatomic,strong) UIButton *reTwitterBtn;
@property (nonatomic,strong) UIButton *commentBtn;
@property (nonatomic,strong) UIButton *likeBtn;
@end

@implementation QYStatusSectionFooterView

-(UIButton *)reTwitterBtn
{
    if (_reTwitterBtn == nil) {
        _reTwitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reTwitterBtn setImage:[UIImage imageNamed:@"statusdetail_icon_retweet"] forState:UIControlStateNormal];
        _reTwitterBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_reTwitterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _reTwitterBtn;
}

-(UIButton *)commentBtn
{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"statusdetail_icon_comment"] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

-(UIButton *)likeBtn
{
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"statusdetail_icon_like"] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _likeBtn;
}

-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.reTwitterBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.likeBtn];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self updateConstraints];
    }
    return self;
}

-(void)updateConstraints
{
    UIView *contentView = self.contentView;
    [_reTwitterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-(kScreenW / 4));
        make.centerY.equalTo(contentView);
    }];
    
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(contentView);
    }];
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(kScreenW / 4);
        make.centerY.equalTo(contentView);
    }];
    [super updateConstraints];
}

-(void)setModel:(QYStatusModel *)model
{
    _model = model;
    
    //转发
    NSString *reTwitterString = model.repostsCount ? [NSString stringWithFormat:@"%ld",model.repostsCount] : @"转发";
    [_reTwitterBtn setTitle:reTwitterString forState:UIControlStateNormal];
    
    //评论
    NSString *commentString = model.commentsCount ? [NSString stringWithFormat:@"%ld",model.commentsCount] : @"评论";
    [_commentBtn setTitle:commentString forState:UIControlStateNormal];
    
    //赞
    NSString *likeString = model.attitudesCount ? [NSString stringWithFormat:@"%ld",model.attitudesCount] : @"赞";
    [_likeBtn setTitle:likeString forState:UIControlStateNormal];
    
    
}




@end
