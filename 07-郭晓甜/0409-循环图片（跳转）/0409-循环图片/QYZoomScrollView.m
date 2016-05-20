//
//  QyZoomScrollView.m
//  0409-循环图片
//
//  Created by qingyun on 16/4/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYZoomScrollView.h"

@interface QYZoomScrollView()<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation QYZoomScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //添加子视图
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:imageView];
        
        _imageView = imageView;
        //设置自身属性
        self.minimumZoomScale = 0.5;
        self.maximumZoomScale = 1.5;
        self.delegate = self;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
    }
    return self;
}
//设置双击事件
- (void)doubleClick:(UITapGestureRecognizer *)tap {
    //1，如果当前的scrollView的缩放比例不为1.0，重置为1.0
    if (self.zoomScale != 1.0) {
        [self setZoomScale:1.0 animated:YES];
        //如果没有return的话，下次查看当前图片还是为上次观看过后的大小
        return;
    }
    //2，如果缩放比例为1.0，双击放大
    //矩形区域的中心
    CGPoint location = [tap locationInView:self];
    CGFloat rectW = 200;
    CGFloat rectH = 100;
    CGRect rect = CGRectMake(location.x - rectW / 2.0, location.y - rectH / 2.0, rectW, rectH);
    [self zoomToRect:rect animated:YES];
}
//重写setImage的方法。设置imageView的image
- (void)setImage:(UIImage *)image {
    //自身完成对属性的赋值：重写cet方法的时候必须添加上这个设置方法
    _image = image;
    
    [_imageView setImage:image];
}
#pragma mark -UIscrollviewDelegate
//代理，添加所需要缩放的视图
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    //
    return _imageView;
}
@end
