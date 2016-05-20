//
//  ViewController.m
//  汤姆猫
//
//  Created by qingyun on 16/3/24.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

// 执行动画
- (void)staretAnimationWithImageName:(NSString *)imgName imageCount:(NSInteger)imgCount {
    //如果正在运行不能执行别的操作
    if ([_ImageView isAnimating]){
        return;
    }
    // 创建一个可变数组，来存储imageView的帧动画
    NSMutableArray *cymbalImage = [NSMutableArray array];
    for (int i = 0; i < imgCount; i++){
        NSString *cymbalImageN = [NSString stringWithFormat:@"%@_%02d", imgName, i];
        NSString *path = [[NSBundle mainBundle] pathForResource:cymbalImageN ofType:@".jpg"];
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        [cymbalImage addObject:image];
    }
    // 设置imageView的帧动画
    _ImageView.animationImages = cymbalImage;
    // 设置帧动画时间
    _ImageView.animationDuration = 0.05 * imgCount;
    // 设置帧动画的重复次数
    _ImageView.animationRepeatCount = 1;
    // 开始动画
    [_ImageView startAnimating];
    
    // 回收最后一次帧动画内存
    [self performSelector:@selector(clearMemory) withObject:nil afterDelay:_ImageView.animationDuration];
    
}


// 清除帧动画缓存
- (void)clearMemory{
    _ImageView.animationImages = nil;
}

- (IBAction)Do:(UIButton *)sender {
    switch (sender.tag) {
        case 111: //cymbal
            [self staretAnimationWithImageName:@"cymbal" imageCount:13];
            break;
        case 112: // drink
            [self staretAnimationWithImageName:@"drink" imageCount:81];
            break;
        case 113: // eat
            [self staretAnimationWithImageName:@"eat" imageCount:40];
            break;
        case 114: // fart
            [self staretAnimationWithImageName:@"fart" imageCount:28];
            break;
        case 115: // pie
            [self staretAnimationWithImageName:@"pie" imageCount:24];
            break;
        case 116: // scratch
            [self staretAnimationWithImageName:@"scratch" imageCount:56];
            break;
        case 117: // knockout
            [self staretAnimationWithImageName:@"knockout" imageCount:81];
            break;
        case 118: // stomach
            [self staretAnimationWithImageName:@"stomach" imageCount:34];
            break;
        case 119: // footLeft
            [self staretAnimationWithImageName:@"footLeft" imageCount:30];
            break;
        case 120: // footReght
            [self staretAnimationWithImageName:@"footRight" imageCount:30];
            break;
        case 121: // angry
            [self staretAnimationWithImageName:@"angry" imageCount:26];
            break;
        default:
            break;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
