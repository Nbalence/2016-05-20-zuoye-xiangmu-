//
//  QYFriendSection.h
//  01-美食
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 GXT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class friendGroup;
@interface QYFriendSection : UITableViewHeaderFooterView

//定义一个block块
@property (nonatomic,strong) void (^headerViewClick)();

@property (nonatomic,strong) friendGroup *friendGroups;

+(instancetype) sectionHeaderView:(UITableView *)tableView;


@end
