//
//  QYStoryboardSegue.m
//  04-传值
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYStoryboardSegue.h"

@implementation QYStoryboardSegue

-(void)perform {
    if ([self.identifier isEqualToString:@"login"]) {
        UIViewController *sourceVC = self.sourceViewController;
        UIViewController *destVC = self.destinationViewController;

        NSString *userName = [sourceVC valueForKeyPath:@"userNameTF.text"];
        NSString *passWord = [sourceVC valueForKeyPath:@"passWordTF.text"];
        //判断用户名和密码不能为空
        if (userName.length == 0 || passWord.length == 0) {
            [self showAlert:@"用户名或密码不能为空"];
        }
        
        //判断用户名和密码是否正确
        if ([userName isEqualToString:@"q"] && [passWord isEqualToString:@"1"]) {
            [destVC setValue:userName forKey:@"userName"];
            //视图切换的动画效果
            //destVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
            [sourceVC.navigationController pushViewController:destVC animated:YES];
            [sourceVC setValue:nil forKeyPath:@"userNameTF.text"];
            [sourceVC setValue:nil forKeyPath:@"passWordTF.text"];
            
            
        }else{
            [self showAlert:@"用户名或密码错误，请重新输入！"];
        }
    }
}

-(void)showAlert:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:action];
    
    [self.sourceViewController presentViewController:alertController animated:YES completion:nil];
}









@end
