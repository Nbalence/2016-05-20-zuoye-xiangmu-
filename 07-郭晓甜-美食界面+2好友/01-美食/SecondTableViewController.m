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

@interface SecondTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *friendGroups;
//@property (nonatomic,strong) UITableView *secondTableView;
@property (strong, nonatomic) IBOutlet UITableView *secondTableView;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.view addSubview:self.secondTableView];

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
     //return fr.friends.count;
    
}

//行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//     QYfriendCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
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
