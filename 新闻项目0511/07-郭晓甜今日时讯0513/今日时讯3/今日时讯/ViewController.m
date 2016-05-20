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
#import "AFNetworking.h"
#import "otherViewController.h"

#define KURLString @"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10,SYRECOMMEND&province=%E5%8C%97%E4%BA%AC%E5%B8%82&city=%E5%8C%97%E4%BA%AC%E5%B8%82&newShowType=1&gv=5.1.2&av=0&proid=ifengnews&os=ios_9.3.1&vt=5&screen=1242x2208&publishid=4002&uid=d3d4ed8ddd5a445f98f0f3f67a4b9522"

#define KURL @"http://www.zhihuiluanchuan.com/index.php?s=/Api/document/zxrd&page=1"

@interface ViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UITableView *tableViews;

//@property (nonatomic,strong) NSMutableArray *datas;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSArray *datas;


@property (nonatomic,strong) UIRefreshControl *refresh;

@end

@implementation ViewController
    static NSString *cellIdentifier = @"cell";
static const NSInteger imagecount = 3;

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
    self.tableViews.delegate = self;
    [self rsusponseData];
    

    _refresh = [[UIRefreshControl alloc] init];
    [_refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    _refresh.backgroundColor = [UIColor grayColor];
    _refresh.tintColor = [UIColor blackColor];
    [self.tableViews addSubview:_refresh];
    
}

-(void)rsusponseData
{
    
#if 0
    //创建对象
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    //设置响应序列
    //设置请求序列化为json序列化
    manage.responseSerializer = [AFJSONResponseSerializer serializer];
    //设置数据类型
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    //创建任务
    NSURLSessionDataTask *task = [manage dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KURL]] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            NSMutableArray *tempArr = responseObject[@"data"];
            NSMutableArray *mArr = [NSMutableArray array];
            for (NSDictionary *dic in tempArr) {
                GXTCellModel *model = [GXTCellModel cellWithDictionary:dic];
                [mArr addObject:model];
            }
            _datas = mArr;
        }
        //刷新
        __weak UITableView *tabView = self.tableViews;
        dispatch_async(dispatch_get_main_queue(),^{
            [tabView reloadData];
        });
    }];
    
    [task resume];
#else
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    __weak UITableView *tabView = self.tableViews;
    
    [manager GET:KURLString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSDictionary *sourceDic = responseObject[0];
        NSArray *itemArray = sourceDic[@"item"];
        
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in itemArray) {
            GXTCellModel *model = [GXTCellModel cellWithDictionary:dic];
            [mArray addObject:model];
        }
        self.datas = mArray;
        [tabView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
    
    
    
#endif
    
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

    GXTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier ];
    GXTCellModel *model = self.datas[indexPath.row];
    //cell.cellModel = self.datas[indexPath.row];
    cell.cellModel = model;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    otherViewController *OVC = [[otherViewController alloc] init];
    [self.navigationController pushViewController:(UIViewController *)OVC animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







//下拉刷新
-(void)refreshView:(UIRefreshControl *)sender
{
    [sender beginRefreshing];//开始刷新
    //设置刷新时的文字提示
    NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"正在加载..." attributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    sender.attributedTitle = str;
    UIRefreshControl *weakRF = _refresh;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){[weakRF endRefreshing];});
    
    //重新加载数据
    [self rsusponseData];
}

@end
