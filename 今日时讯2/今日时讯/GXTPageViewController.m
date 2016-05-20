//
//  GXTPageViewController.m
//  今日时讯
//
//  Created by qingyun on 16/4/23.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTPageViewController.h"
#import "GXTViewController2.h"
#import "GXTViewController3.h"
#import "GXTViewController4.h"
#import "GXTCollectionViewCell.h"
#import "GXTnewsModel.h"

#define GXTScreen [UIScreen mainScreen].bounds.size.width

@interface GXTPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *titlesArray;
@property (nonatomic,strong) NSArray *viewsArray;
@property (nonatomic)        NSInteger pageNum;

@end

@implementation GXTPageViewController
static NSString *collCellIdentifier = @"titleCell";

//懒加载读取标题
-(NSMutableArray *)titlesArray
{
    if (_titlesArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            GXTnewsModel *model = [GXTnewsModel newsWithDictionary:dict];
            [models addObject:model];
        }
        _titlesArray = models;
    }
    return _titlesArray;
}

//懒加载几个视图
-(NSArray *)viewsArray
{
    if (_viewsArray == nil) {
        GXTViewController2 *v2 = [[GXTViewController2 alloc] init];
        v2.view.backgroundColor = [UIColor cyanColor];
        GXTViewController3 *v3 = [[GXTViewController3 alloc] init];
        v3.view.backgroundColor = [UIColor blueColor];
        GXTViewController4 *v4 = [[GXTViewController4 alloc] init];
        v4.view.backgroundColor = [UIColor brownColor];
        _viewsArray = @[v2,v3,v4];
    }
    return _viewsArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置代理和数据源
    self.delegate = self;
    self.dataSource = self;
    
    [self addCollectionView];
    
    [self setViewControllers:@[self.viewsArray[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
}

//1、加载collectionView
-(void)addCollectionView
{
    //1、布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 35);
    //2、设置水平滑动
    layout.minimumLineSpacing = 15;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //3、添加
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, GXTScreen, 35) collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //4、注册
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([GXTCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:collCellIdentifier];
}


#pragma mark - UICollectionViewDataSource
//1.items
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titlesArray.count;
}
//2.sections
-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//3.cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GXTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = nil;
    GXTnewsModel *model = self.titlesArray[indexPath.item];
    cell.newsModel = model;
    return cell;
}
//4.选中的item
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //1、设置滚动
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //2、提取相应的页面
    NSInteger index = [self.viewsArray indexOfObject:self.viewControllers.firstObject];
    index = indexPath.item;
    [self setViewControllers:@[self.viewsArray[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    
    UICollectionViewCell *didSelect = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    didSelect.backgroundColor = [UIColor orangeColor];
    
    for (int i = 0; i < self.titlesArray.count; i++) {
        UICollectionViewCell *se1 = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item- i inSection:0]];
        se1.backgroundColor = [UIColor clearColor];
        
        UICollectionViewCell *se2 = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item+ i inSection:0]];
        se2.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - UIPageViewControlDelegate
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    NSInteger num = [self.viewsArray indexOfObject:self.viewControllers.firstObject];
    
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:num inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    UICollectionViewCell *select = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:num inSection:0]];
    select.backgroundColor = [UIColor cyanColor];
    UICollectionViewCell *select1 = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:num+1 inSection:0]];
    select1.backgroundColor = nil;
    
    
    UICollectionViewCell *select2 = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:num-1 inSection:0]];
    select2.backgroundColor = nil;
}

#pragma mark - UIPageViewDatasource
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger num = [self.viewsArray indexOfObject:self.viewControllers.firstObject];
    num --;
    if ((num < 0) || (num = NSNotFound)) {
        return nil;
    }
    return self.viewsArray[num];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.viewsArray indexOfObject:self.viewControllers.firstObject];
    index++;
    if (index == self.viewsArray.count || index == NSNotFound) return nil;
    
    return self.viewsArray[index];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
