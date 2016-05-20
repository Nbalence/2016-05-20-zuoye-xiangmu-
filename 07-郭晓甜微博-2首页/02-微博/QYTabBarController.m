//
//  QYTabBarController.m
//  02-微博
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYTabBarController.h"

@interface QYTabBarController ()

@end


/*
 
 子类化tabBarController
 
 */



@implementation QYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首先自定义中间的TabBarItem
    [self setMidTabBarItem];
    
}


-(void)setMidTabBarItem
{
    //1、添加中间tabBarItem按钮（宽度是50，高度 40）
    CGFloat btnW = 50;
    CGFloat btnH = 40;
    CGFloat btnX = (CGRectGetWidth(self.tabBar.frame) - btnW) / 2.0;
    CGFloat btnY = (CGRectGetHeight(self.tabBar.frame) - btnH) / 2.0;
    
    //2、设置并添加中间的加号按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tabBar addSubview:btn];
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    //3、设置图片背景和颜色
    [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor orangeColor]];
    
    //4、添加监听事件
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //5、设置圆角
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
}

-(void)btnClick
{
    NSLog(@"%s",__func__);
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
