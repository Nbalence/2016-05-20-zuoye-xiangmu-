//
//  QYFriendSection.m
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "QYFriendSection.h"
#import "friendGroup.h"

@interface QYFriendSection ()
@property (nonatomic,strong) UIButton *bgBtn;
@property (nonatomic,strong) UILabel *numLabel;
@end

@implementation QYFriendSection
//注册
static NSString *identifier = @"headeView";

//创建组头
+(instancetype) sectionHeaderView:(UITableView *)tableView
{
    //创建
    QYFriendSection *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (headerView == nil) {
        headerView = [[QYFriendSection alloc] initWithReuseIdentifier:identifier];
    }
    headerView.contentView.backgroundColor = [UIColor redColor];
    return headerView;
}


//初始化组头
-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //1、添加背景的button
        UIButton *bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //此处必须是self.contentView
        [self.contentView addSubview:bgBtn];
        
        //2、设置背景图片
            //普通状态呢
        UIImage *image = [[UIImage imageNamed:@"buddy_header_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 1, 44, 0) resizingMode:UIImageResizingModeStretch];
        
            //高亮状态
        UIImage *highLightedImage = [[UIImage imageNamed:@"buddy_header_bg_highlighted"] resizableImageWithCapInsets:UIEdgeInsetsMake(44, 1, 44, 0) resizingMode:UIImageResizingModeStretch];
        
            //设置点击状态
        [bgBtn setBackgroundImage:image forState:UIControlStateNormal];
        [bgBtn setBackgroundImage:highLightedImage forState:UIControlStateHighlighted];
        
/***/            //设置标题颜色
        [bgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
            //设置图片
        [bgBtn setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
            //设置内容对齐方式
        bgBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            //设置内容的偏移
        bgBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            //设置标题的偏移
        bgBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
            //设置btn中图片显示的模式
        bgBtn.imageView.contentMode = UIViewContentModeCenter;
            //设置超出部分不剪切
        bgBtn.imageView.clipsToBounds = NO;
        
            //添加监听事件
        [bgBtn addTarget:self action:@selector(bgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //3、添加右边的label
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        
            //label的对齐方式
        label.textAlignment = NSTextAlignmentRight;
        
        _bgBtn = bgBtn;
        _numLabel = label;
        
    }
    return self;
}

//设置子视图大小(bgBtn numLabel)
-(void)layoutSubviews
{
    [super layoutSubviews];
    //1、设置bgBtn的frame
    _bgBtn.frame = self.bounds;
    
    //2、设置numLabel的Frame
    CGFloat labelW = 100;
    CGFloat labelH = CGRectGetHeight(self.bounds);
    CGFloat labelX = CGRectGetWidth(self.bounds) - labelW - 10;
    CGFloat labelY = CGRectGetHeight(self.bounds) - labelH;
    _numLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
}

//重写set方法
-(void)setFriendGroups:(friendGroup *)friendGroups
{
    _friendGroups = friendGroups;
    //1、设置bgBtn的标题
    [_bgBtn setTitle:friendGroups.name forState:UIControlStateNormal];
    //2、设置numLabeld的文本
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",friendGroups.online,friendGroups.friends.count];
    
    //3、旋转图片(M_PI_2)
    if (_friendGroups.isOpen) {
        _bgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    else
    {
        _bgBtn.imageView.transform = CGAffineTransformIdentity;
    }
    
}


//bgBtn监听事件
-(void)bgBtnClick:(UIButton *)sender
{
    //1、更改isOpen的状态
    _friendGroups.isOpen = !_friendGroups.isOpen;
    
    //2、刷新界面
    if (_headerViewClick) {
        _headerViewClick();
    }
}



@end
