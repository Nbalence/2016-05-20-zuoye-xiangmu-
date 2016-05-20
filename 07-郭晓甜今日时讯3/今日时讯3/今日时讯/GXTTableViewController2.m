//
//  GXTTableViewController2.m
//  今日时讯
//
//  Created by qingyun on 16/4/24.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTTableViewController2.h"
#import "GXTMessModel.h"
#import "GXTTableViewCell3.h"

@interface GXTTableViewController2 ()<UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) NSArray *datas;
//@property (strong, nonatomic) IBOutlet UITableView *tableViews;

@end

@implementation GXTTableViewController2
static NSString *messIdentifier = @"meCell";
//首先懒加载数据
-(NSArray *)datas
{
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            GXTMessModel *messageModels = [GXTMessModel messModelWithDictionary:dic];
            [models addObject:messageModels];
        }
        _datas = models;
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1、设置数据源和代理
//    _tableViews.delegate = self;
//    _tableViews.dataSource = self;
    
    //获取单元格
////    [_tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([GXTTableViewCell3 class]) bundle:nil] forCellReuseIdentifier:messIdentifier];
//    [_tableViews registerNib:[UINib nibWithNibName:NSStringFromClass([GXTTableViewCell3 class]) bundle:nil] forCellReuseIdentifier:messIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.datas.count;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GXTTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:messIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"GXTTableViewCell3" owner:self options:nil][0];
        cell.messModel = self.datas[indexPath.row];
    }
    
    return cell;
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

@end
