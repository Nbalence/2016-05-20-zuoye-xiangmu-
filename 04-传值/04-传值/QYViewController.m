//
//  QYViewController.m
//  04-传值
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "QYViewController.h"

@interface QYViewController ()

@property (weak, nonatomic) IBOutlet UILabel *welcome;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end

@implementation QYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _welcome.text = [NSString stringWithFormat:@"欢迎您：%@",_userName];
}
- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"changeDesc"]) {
        //目标视图控制器、
        UIViewController *destVC = segue.destinationViewController;
        
        //传递个性签名
        [destVC setValue:_descLabel.text forKey:@"descString"];
        
        //声明并创建一个block来更改个性签名的文本
        void (^changeText)(NSString *text) = ^(NSString *value)
        {
            _descLabel.text = value;
        };
        
        //对VIewController3进行赋值
        [destVC setValue:changeText forKey:@"changeDesc"];
    }
    
}


@end
