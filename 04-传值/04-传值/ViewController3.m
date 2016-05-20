//
//  ViewController3.m
//  04-传值
//
//  Created by qingyun on 16/4/6.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController3.h"

@interface ViewController3 ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    _textField.text = _descString;
}
- (IBAction)back:(UIBarButtonItem *)sender {
    
    if (_changeDesc) {
        _changeDesc(_textField.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
