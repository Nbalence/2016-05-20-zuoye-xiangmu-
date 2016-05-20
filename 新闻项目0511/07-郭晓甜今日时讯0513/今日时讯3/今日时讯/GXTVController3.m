//
//  GXTVController3.m
//  今日时讯
//
//  Created by qingyun on 16/4/24.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import "GXTVController3.h"
#import "GXTTableViewCell3.h"
#import "GXTMessModel.h"

@interface GXTVController3 ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation GXTVController3
static NSString *messIdentifer = @"messCell";

-(NSArray *)datas {
    if (_datas == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            GXTMessModel *meModel = [GXTMessModel messModelWithDictionary:dic];
            [models addObject:meModel];
        }
        _datas = models;
    }
    return _datas;
}
//懒加载tableView
-(UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        //设置数据源和代理
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //设置行高
        _tableView.rowHeight = 200;
        
        //使用第二种获取闲置单元格的方式，必须注册单元格
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GXTTableViewCell3 class]) bundle:nil] forCellReuseIdentifier:messIdentifer];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    GXTTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:messIdentifer forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[NSBundle mainBundle] loadNibNamed:@"GXTTableViewCell3" owner:self options:nil][0];
//        cell.messModel = self.datas[indexPath.row];
//    }
    GXTTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:messIdentifer forIndexPath:indexPath];
    cell.messModel = self.datas[indexPath.row];
    
    return cell;
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
