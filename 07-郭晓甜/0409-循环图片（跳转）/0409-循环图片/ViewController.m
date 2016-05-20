//
//  ViewController.m
//  0409-循环图片
//
//  Created by qingyun on 16/4/9.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"
#import "QYZoomScrollView.h"
#define QYScreenW [UIScreen mainScreen].bounds.size.width
#define QYScreenH [UIScreen mainScreen].bounds.size.height
#define ImageCount 6
@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrolView;
@property (nonatomic,strong) NSArray *images;//图片的路径
@property (nonatomic) NSInteger currentIndex; //当前显示的图片在zoomScrollView的索引

@end

@implementation ViewController
//懒加载创建images数组
- (NSArray *)images {
    if (_images == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < ImageCount; i++) {
            //获取图片的名字：new_feature_%d@2x，字符串必须完全，@2x、否则程序崩溃
            NSString *imageName = [NSString stringWithFormat:@"new_feature_%d@2x",i + 1];
            //获取路径
            NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            [array addObject:imagePath];
        }
        _images = array;
    }
    return _images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    //1,创建并添加
    [self createdAndAddScrollView];
    //1,创建并添加缩放的zoomScrollView
    [self addZoomScrollViewForScrollView];
    
    //2、配置scrollView的图片
    [self configureImageForZoomScrollView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
//创建并添加底部循环scrollView
- (void)createdAndAddScrollView {
    //
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, QYScreenW + 25, QYScreenH)];
    [self.view addSubview:scrollView];
    
    //设置
    scrollView.contentSize = CGSizeMake((QYScreenW + 25) * ImageCount, QYScreenH);
    //分页
    scrollView.pagingEnabled = YES;
    //背景颜色
    scrollView.backgroundColor  = [UIColor blackColor];
    //水平滚动条隐藏
    scrollView.showsHorizontalScrollIndicator = NO;
    //
    scrollView.alwaysBounceHorizontal = NO;
    //
    scrollView.directionalLockEnabled = YES;
    //设置代理
    scrollView.delegate = self;
    
    _scrolView = scrollView;
}

//在底部scrollViews上添加缩放的zoomScrollView

- (void)addZoomScrollViewForScrollView {
    for (int i ; i < 3; i++) {
        QYZoomScrollView *zoomScrollView = [[QYZoomScrollView alloc] initWithFrame:CGRectMake((QYScreenW + 25) * i, 0, QYScreenW, QYScreenH)];
        [_scrolView addSubview:zoomScrollView];
//        //设置图片（不加循环的时候需要在这里播放图片）
//        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
//        zoomScrollView.image = [UIImage imageNamed:imageName];
        zoomScrollView.tag = 100 + i;
    }
}
//确保索引的可用
- (NSInteger)enableForIndex:(NSInteger)index {
    //如果左滑动使当前的索引小于零会致使图片循环播放出现错误
    if (index < 0) {
        return self.images.count - 1;
    }else {//如果图片的序号大于零的话就可以直接取余数，返回当前的叙序数
        return index % self.images.count;
    }
}
//配置需要缩放的zoomScrollView的图片
- (void)configureImageForZoomScrollView {
    //1、获取左右中共计三个需要所养的zoomScrollView
    QYZoomScrollView *leftZoomScrollView = [_scrolView viewWithTag:100];
    QYZoomScrollView *middleZoomScrollView = [_scrolView viewWithTag:101];
    QYZoomScrollView *rightZoomScrollView = [_scrolView viewWithTag:102];
    
    //2、对三个需要缩放的zoomScrollView设置图片
    NSInteger leftIndex = [self enableForIndex:(_currentIndex - 1)];
    leftZoomScrollView.image = [UIImage imageWithContentsOfFile:self.images[leftIndex]];
    
    NSInteger middleIndex = [self enableForIndex:(_currentIndex)];
    middleZoomScrollView.image = [UIImage imageWithContentsOfFile:self.images[middleIndex]];
    
    NSInteger rightindex = [self enableForIndex:(_currentIndex + 1)];
    rightZoomScrollView.image = [UIImage imageWithContentsOfFile:self.images[rightindex]];
    //
    //设置底部滚动的scrollView的偏移量，确保屏幕现实的是中间的scrollView、
    [_scrolView setContentOffset:CGPointMake((QYScreenW + 25), 0)];
    
}
//代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //遍历子视图
    [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[QYZoomScrollView class]]) {
            QYZoomScrollView *zoomScrollView = obj;
            [zoomScrollView setZoomScale:1.0 animated:NO];
        }
    }];
    //在滚动之后，重置zoomVcrollView的图片，并设置底滚动的scrollView的偏移量
    if (scrollView.contentOffset.x == 0) {//右滑动
        _currentIndex--;
    }else if (scrollView.contentOffset.x == (QYScreenW + 25) * 2) {
        _currentIndex++;
    }
    //确保_currentIndex的合法性
    _currentIndex = [self enableForIndex:_currentIndex];
    
    [self configureImageForZoomScrollView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //
    
    // Dispose of any resources that can be recreated.
}

@end
