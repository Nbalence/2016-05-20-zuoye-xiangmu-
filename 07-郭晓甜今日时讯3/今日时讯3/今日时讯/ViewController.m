//
//  ViewController.m
//  今日时讯
//
//  Created by qingyun on 16/4/22.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "ViewController.h"
#import "GXTCellModel.h"
#import "GXTTableViewCell.h"

@interface ViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UITableView *tableViews;
@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *arr;

@end

@implementation ViewController

static const NSInteger imagecount = 3;

//懒加载数据
-(NSMutableArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"img" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            GXTCellModel *cellModel = [GXTCellModel cellWithDictionary:dic];
            [models addObject:cellModel];
        }
        _datas = models;
    }
    return _datas;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat imgY = 0;
    
    CGFloat imgwidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat imghdight = self.scrollView.frame.size.height;
    CGFloat contentW = imgwidth * imagecount;
    
    //设置偏移
    self.scrollView.contentSize = CGSizeMake(contentW, 0);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    for (int i=0; i < 3; i++) {
        CGFloat imgX = imgwidth * i;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, imgY, imgwidth, imghdight)];
        NSString *imageName = [NSString stringWithFormat:@"bg%d.jpg",i+1];
        imageView.image = [UIImage imageNamed:imageName];
        [self.scrollView addSubview:imageView];
    }

    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(300, 150, 100, 0)];
    _pageControl = pageControl;
    pageControl.numberOfPages = imagecount;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    [self.tableViews addSubview:pageControl];
    [self addTimer];
     self.tableViews.dataSource = self;
    
    
}

//设置定时器
-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
}

-(void)nextPage
{
    NSInteger page = 0;
    if (self.pageControl.currentPage == imagecount - 1) {
        
        page = 0;
    }
    else
    {
        page = self.pageControl.currentPage + 1;
    }
//    [UIView animateWithDuration:0.4 animations:^{
         self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * page, 0);
        
//    }];
   
}

//如果手动拖拽，则定时器失效
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

//结束拖拽时，重新开启定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
}

#pragma mark - UITableView代理
//行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}
//行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GXTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.cellModel = self.datas[indexPath.row];
    return cell;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
