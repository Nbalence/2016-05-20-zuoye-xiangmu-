//
//  SecondTableViewController.m
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "SecondTableViewController.h"
#import "friends.h"
#import "friendGroup.h"
#import "QYfriendCell.h"
#import "QYFriendSection.h"

@interface SecondTableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>

@property (nonatomic,strong) NSMutableArray *friendGroups;
@property (strong, nonatomic) IBOutlet UITableView *secondTableView;

@property (nonatomic,strong) UISearchController *searchController;
@property (nonatomic,strong) NSMutableArray *results;
@property (nonatomic)        NSInteger index;
@property (nonatomic)        BOOL isSearching;

@end

@implementation SecondTableViewController
static NSString *identifier = @"fri";
//1.懒加载数据
-(NSArray *)friendGroups
{
    if (_friendGroups == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            friendGroup *friendGr = [friendGroup friendGroupWithDictionary:dict];
            _results = friendGr.friends;
            [models addObject:friendGr];
        }
        _friendGroups = models;
    }
    return _friendGroups;
}
//懒加载secondTableView
-(UITableView *)secondTableView
{
    if (_secondTableView == nil) {
        _secondTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    
        //设置数据源和代理
        _secondTableView.dataSource = self;
        _secondTableView.delegate = self;
    
    //注册单元格
    [_secondTableView registerClass:[QYfriendCell class] forCellReuseIdentifier:identifier];
    }
    return _secondTableView;
}

-(UISearchController *)searchController
{
    if (_searchController == nil) {
        //如果显示的结果在同一个视图上，那么参数传入nil
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        //设置更新
        _searchController.searchResultsUpdater = self;
    }
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.tintColor = [UIColor whiteColor];
    self.editButtonItem.target = self;
    self.editButtonItem.action = @selector(changeTableViewEdit:);
    
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds), 44);
    self.searchController.dimsBackgroundDuringPresentation = NO;

}

#pragma mark - Table view data source

//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.friendGroups.count;
}

//组内行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    friendGroup *fr = self.friendGroups[section];
    if (fr.isOpen) {
        return fr.friends.count;
    }else
    {
        return 0;
    }
}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYfriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[QYfriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //1、取出当前row所在的Section对应的模型
    friendGroup *fri = self.friendGroups[indexPath.section];
    //2、取出当前row对应的模型
    friends *f = fri.friends[indexPath.row];
    cell.fr = f;
    return cell;
}
/*
 下边设置了这里不需要在设置头标题
 */
//设置section的头部标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    friendGroup *frit = self.friendGroups[section];
//    return frit.name;
//}
//设置Section头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
//设置Section的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QYFriendSection * headerView = [QYFriendSection sectionHeaderView:tableView];
    //设置friendGroups属性
    friendGroup *frien = self.friendGroups[section];
    headerView.friendGroups = frien;
    
    headerView.headerViewClick = ^{
        //刷新表视图
        [tableView reloadData];
    };
    return headerView;
    
}

#pragma mark - 编辑删除
-(void)changeTableViewEdit:(UIBarButtonItem *)barBtnItem
{
    [self.secondTableView setEditing:!self.secondTableView.editing animated:YES];
    barBtnItem.title = self.secondTableView.editing ? @"完成":@"编辑";
}

//允许编辑
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//指定编辑样式
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

//提交编辑
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    friendGroup *group = self.friendGroups[indexPath.section];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [group.friends removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }

}
//允许移动
-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//移动单元格
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //先取出对应的行
    friendGroup *mode = self.friendGroups[sourceIndexPath.section];
    NSMutableArray *mArr = mode.friends[sourceIndexPath.row];
    [mode.friends removeObjectAtIndex:sourceIndexPath.row];
    friendGroup *Inx = self.friendGroups[destinationIndexPath.section];
    [Inx.friends insertObject:mArr atIndex:destinationIndexPath.row];
    
}


#pragma mark - 搜索
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    if (searchController.searchBar.text.length == 0) {
        friendGroup *friendGroup = self.friendGroups[_index];
        _results = friendGroup.friends;
        
        [self.tableView reloadData];
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[CD] %@",searchController.searchBar.text];
    friendGroup *frie = self.friendGroups[_index];
    _results = [frie.friends filteredArrayUsingPredicate:predicate];
    
    [self.tableView reloadData];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
