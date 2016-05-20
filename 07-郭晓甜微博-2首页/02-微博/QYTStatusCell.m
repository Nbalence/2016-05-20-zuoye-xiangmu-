//
//  QYTStatusCell.m
//  02-微博
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTStatusCell.h"
#import "QYStatusModel.h"
#import "QYUserModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Common.h"

#define kNumOfRow  3                                                            //列数
#define kImageEdge 8                                                            //间距
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kImageViewW (kScreenW - (kNumOfRow + 1) * kImageEdge ) / kNumOfRow


@interface QYTStatusCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *imageContentView;
@property (weak, nonatomic) IBOutlet UILabel *reContentLabel;
@property (weak, nonatomic) IBOutlet UIView *reImageContentView;

@end
@implementation QYTStatusCell


-(void)setStatusModel:(QYStatusModel *)statusModel
{
    _statusModel = statusModel;
    //设置头像
    _avatarView.layer.cornerRadius = 25;
    _avatarView.layer.masksToBounds = YES;
    NSURL *profileUrl = [NSURL URLWithString:statusModel.user.profileImageUrl];
    [_avatarView sd_setImageWithURL:profileUrl placeholderImage:[UIImage imageNamed:@"social-user"]];
    
    //昵称
    _nickName.text = statusModel.user.name;
    //创建时间
    _createTime.text = statusModel.createsAt;
    //来源
    _sourceLabel.text = statusModel.source;
    //内容
    _contentLabel.text = statusModel.text;
    
    //然后判断是否有转发的微博
    if (statusModel.retweetedStatus) {
        //显示转发的微博和转发图片
        _reContentLabel.text = statusModel.retweetedStatus.text;
        [self layoutSubviewsForView:_reImageContentView picUrls:statusModel.retweetedStatus.picUrls];
        //隐藏imageContentView
        [self layoutSubviewsForView:_imageContentView picUrls:nil];
    }else{
        //显示当前微博的图片
        [self layoutSubviewsForView:_imageContentView picUrls:statusModel.picUrls];
        //隐藏reContentLabel和reImageContentView
        _reContentLabel.text = nil;
        [self layoutSubviewsForView:_reImageContentView picUrls:nil];
    }

}

//对图片视图的父视图添加图片视图
-(void)layoutSubviewsForView:(UIView *)view picUrls:(NSArray *)urls
{
    //1、移除View的所有子视图
#if 0
    for (UIView *subview in view.subviews) {
        [subview removeFromSuperview];
    }
#endif
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //2、根据urls计算View应有的高度
    CGFloat height = [self imageContentViewViewHeightWithPics:urls];
    [view.constraints enumerateObjectsUsingBlock:^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.firstAttribute == NSLayoutAttributeHeight) {
            obj.constant = height;
            *stop = YES;
        }
    }];
    
    //3、根据urls添加图片视图
    for (int i=0; i<urls.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [view addSubview:imageView];
        
        //计算位置
        //列数
        NSInteger column = i % kNumOfRow;
        //行数
        NSInteger row = i / kNumOfRow;
        CGFloat x = (column + 1) * kImageEdge + column * kImageViewW;
        CGFloat y = (row + 1) * kImageEdge + row * kImageViewW;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).with.offset(x);
            make.top.equalTo(view.mas_top).with.offset(y);
            make.size.mas_equalTo(CGSizeMake(kImageViewW, kImageViewW));
        }];
        
        NSDictionary *imageDict = urls[i];
        NSString *imageUrlString = imageDict[kStatusThumbnailPic];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"social-placeholder"]];
        
        //防止照片走形
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        
    }
    
}

-(CGFloat)imageContentViewViewHeightWithPics:(NSArray *)urls
{
    //判断urls是否为空
    if (urls.count == 0) {
        return 0;
    }
    //总行数
    NSInteger row = (urls.count - 1) / kNumOfRow + 1;
    return row * kImageViewW + (row + 1) * kImageEdge;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
