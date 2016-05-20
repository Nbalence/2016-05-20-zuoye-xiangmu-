//
//  ViewController.m
//  01-美食
//
//  Created by qingyun on 16/4/11.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "ViewController.h"
#import "QYCellModel.h"
#import "QYTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
//上边图片属性
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

//下边美食属性
@property (weak, nonatomic) IBOutlet UITableView *tableViews;

//首先定义一个数组用来存放plist文件内容
@property (nonatomic,strong)NSMutableArray *datas;

//@property (nonatomic,strong)NSMutableDictionary *mDic;
@property (nonatomic,strong)NSMutableArray *arr;


//添加搜索框
@property (nonatomic,strong) UISearchBar *searchBar;
//添加搜索框状态
@property (nonatomic)        BOOL isSearch;

@property (nonatomic,strong) NSMutableArray *results;

@end

@implementation ViewController


//懒加载数据内容
-(NSArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            QYCellModel *cellModel = [QYCellModel modelWithDictionary:dic];
            [models addObject:cellModel];
        }
        _datas = models;
        
    }
    return _datas;
}

//懒加载搜索框
-(UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 44)];
        _searchBar.keyboardType = UIKeyboardTypeNamePhonePad;
        //设置代理
        _searchBar.delegate = self;
    }
    return _searchBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //上边图片的代码
    //1.设置scrollView的contentSize
    _scrollView.contentSize = CGSizeMake(414 * 3, 0);
    //2.设置代理
    _scrollView.delegate = self;
    //设置分页
    _scrollView.pagingEnabled = YES;
    //隐藏横向滚动条
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //锁定方向(当系统识别滚动方向的时候，会把另外一个方向锁定，如果识别不了，就不锁定方向)
    _scrollView.directionalLockEnabled = YES;
    
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.tintColor = [UIColor whiteColor];
    self.editButtonItem.target = self;
    self.editButtonItem.action = @selector(changeTableViewEdit:);
    
    
    //导航栏添加搜索框
    self.navigationItem.titleView = self.searchBar;
    self.navigationController.navigationBar.barTintColor = [UIColor lightGrayColor];
    

    
}

#pragma mark - TableView代理
//首先是行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearch) {
        return _results.count;
    }
    else
    {
        return self.datas.count;
    }
}

//然后是行内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_isSearch) {
        cell.cellModel = _results[indexPath.row];
    }
    else
    {
        cell.cellModel = self.datas[indexPath.row];
    }
    
    return cell;
}

////设置Section的头标题
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return _isSearch ? nil : self.datas[section];
//}

#pragma mark - UISearchDelegate

//开始编辑
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //需要显示取消按钮
    searchBar.showsCancelButton = YES;
}

//点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //1、隐藏取消按钮
    searchBar.showsCancelButton = NO;
    //2、取消searchBar的第一响应
    [searchBar resignFirstResponder];
    //3、清除文本
    searchBar.text = nil;
    //4、更改搜索状态
    _isSearch = NO;
    //5、刷新界面
    [self.tableViews reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //隐藏键盘
    [searchBar resignFirstResponder];
    //隐藏取消按钮
    searchBar.showsCancelButton = NO;
}

//当searchBar的文本已经改变的时候
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //当searchBar的文本被清空的时候
    if (searchBar.text.length == 0) {
        _isSearch = NO;
        [self.tableViews reloadData];
        return;
    }
    //更改搜索状态
    _isSearch = YES;
    //根据关键字检索数据
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title CONTAINS[CD] %@",searchText];
    NSMutableArray *mArray = [NSMutableArray array];

    NSArray *filter = [self.datas filteredArrayUsingPredicate:predicate];
    [mArray addObjectsFromArray:filter];
    _results = mArray;
    //3、刷新表视图
    [self.tableViews reloadData];
}





//继续scrollView的Image
#pragma mark - UIScrollView代理
//滚动停止的时候更新当前页码
-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算当前页码
    NSInteger currentPage = scrollView.contentOffset.x / 414;
    _pageControl.currentPage = currentPage;
}

- (IBAction)pageControlChange:(UIPageControl *)sender {
    //计算ScrollVIew的偏移量
    CGPoint point = CGPointMake(sender.currentPage * 414, 0);
    [_scrollView setContentOffset:point animated:YES];
    
}



#pragma mark - 编辑（删除）

-(void)changeTableViewEdit:(UIBarButtonItem *)barBtnItem
{
    [self.tableViews setEditing:!self.tableViews.editing animated:YES];
    barBtnItem.title = self.tableViews.editing ? @"Done" :@"Edit";
}

//允许编辑
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//指定编辑样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

//提交编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.datas removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation: UITableViewRowAnimationLeft];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
