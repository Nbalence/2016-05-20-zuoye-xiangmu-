//
//  ViewController.m
//  1601-青云猜图
//
//  Created by qingyun on 16/3/28.
//  Copyright © 2016年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"
#import "QYQuestion.h"
#import "QYAnswerView.h"
#import "QYOptionView.h"
@interface ViewController (){
    NSInteger currentIndex;                                 //当前题目的索引(从0开始)
}
@property (weak, nonatomic) IBOutlet UIButton *coinBtn;     //金币按钮
@property (weak, nonatomic) IBOutlet UILabel *numLabel;     //题号
@property (weak, nonatomic) IBOutlet UILabel *descLabel;    //当前题目的描述
@property (weak, nonatomic) IBOutlet UIImageView *imageView;//题目的图片
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (nonatomic, strong) QYAnswerView *answerView;     //答案区域视图
@property (nonatomic, strong) QYOptionView *optionView;     //选择区域视图

@property (nonatomic, strong) NSArray *questions;           //所有题目的数据集合

@end

@implementation ViewController

//懒加载questions
-(NSArray *)questions{
    if (_questions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        //遍历array中的字典，转化成模型question
        for (NSDictionary *dict in array) {
            QYQuestion *question = [QYQuestion questionWithDictionary:dict];
            [models addObject:question];
        }
        _questions = models;
    }
    return _questions;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化界面
    [self updateUI];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)btnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 101://提示
            [self hint];
            break;
        case 102://大图
            [self bigImage];
            break;
        case 103://帮助
            
            break;
        case 104://下一题
            [self next];
            break;
            
        default:
            break;
    }
}

#pragma mark -大图
-(void)bigImage{
    //创建并添加蒙版btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    //设置frame
    btn.frame = self.view.frame;
    //背景颜色
    btn.backgroundColor = [UIColor orangeColor];
    //透明度
    btn.alpha = 0.0;
    //添加事件监听（点击事件）
    [btn addTarget:self action:@selector(smallImage:) forControlEvents:UIControlEventTouchUpInside];
    //把imageView置顶
    [self.view bringSubviewToFront:_imageView];
    [UIView animateWithDuration:1 animations:^{
        _imageView.transform = CGAffineTransformScale(_imageView.transform, 1.5, 1.5);
        btn.alpha = 0.5;
    }];
}

-(void)smallImage:(UIButton *)sender{
    [UIView animateWithDuration:1 animations:^{
        _imageView.transform = CGAffineTransformIdentity;
        sender.alpha = 0.0;
    } completion:^(BOOL finished) {
        //注意：动画完成之后，需要把蒙版btn从父视图中移除，因为每次点击大图的时候，都添加了一个蒙版btn
        [sender removeFromSuperview];
    }];
}

#pragma mark -下一题
//下一题
-(void)next{
    _nextBtn.enabled = YES;
    currentIndex++;
    [self updateUI];
}

//更新UI界面
-(void)updateUI{
    //判断当前题目的索引有效，使题目循环
    if (currentIndex == self.questions.count) {
        currentIndex = 0;
    }
    
    //取出当前题目对应的模型
    QYQuestion *question = self.questions[currentIndex];
    //更新numLabel的文本
    _numLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentIndex + 1,self.questions.count];
    //更新descLabel的文本
    _descLabel.text = question.title;
    //更新imageView的图片
    NSString *path = [[NSBundle mainBundle] pathForResource:question.icon ofType:@"png"];
    _imageView.image = [UIImage imageWithContentsOfFile:path];
    
    //添加答案区域视图answerView
    [_answerView removeFromSuperview];
    QYAnswerView *answerView = [QYAnswerView answerViewWithAnswerLength:question.length];
    [self.view addSubview:answerView];
    //frame
    answerView.frame = CGRectMake(0, 350, 0, 0);
    _answerView = answerView;
    //block内部使用视图控制器self，必须用weak修饰，防止发成循环引用
    __weak ViewController *weakSelf = self;
    answerView.answerAction = ^(UIButton *answerBtn){
        [weakSelf answerBtnClick:answerBtn];
    };
    
    //添加选择区域视图optionView
    [_optionView removeFromSuperview];
    QYOptionView *optionView = [QYOptionView optionView];
    [self.view addSubview:optionView];
    //frame
    optionView.frame = CGRectMake(0, 450, 0, 0);
    //设置标题
    optionView.titles = question.options;
    _optionView = optionView;
    
    optionView.optionAction = ^(UIButton *optionBtn){
        [weakSelf optionBtnClick:optionBtn];
    };
}

//处理optionBtn的点击事件
-(void)optionBtnClick:(UIButton *)optionBtn {
    NSLog(@"你点击的是:%@",optionBtn.currentTitle);
    /*
     判断有需要填充的answerBtn(answerView.answerBtnIndexs不为空)
     {
        隐藏点击的optionBtn
        把optionBtn的标题显示在需要填写的answerBtn上（需要遵循左->右）
     }
     判断是否填充完毕，需要判断答案是否正确（(answerView.answerBtnIndexs为空）
     
     正确:
            更改字体颜色为绿色
            加金币（当前题目没有被提示过）
            标识当前题目已经回答过
            延迟跳转下一题
     错误:
            更改字体颜色为红色
     */
    
    if (_answerView.answerBtnIndexs.count > 0) {
        optionBtn.hidden = YES;
        //获取需要填写的answerBtn在_answerView.subviews中的索引
        NSInteger willFillAnswerBtnIndex = [_answerView.answerBtnIndexs.firstObject integerValue];
        //获取需要填写的answerBtn
        UIButton *answerBtn = _answerView.subviews[willFillAnswerBtnIndex];
        //设置answerBtn的标题为optionBtn的标题
        [answerBtn setTitle:optionBtn.currentTitle forState:UIControlStateNormal];
        //从_answerView.answerBtnIndexs中移除当前设置的answerBtn的索引（确保answerBtnIndexs中的索引和界面需要填写的answerBtn一致）
        [_answerView.answerBtnIndexs removeObjectAtIndex:0];
        answerBtn.tag = optionBtn.tag = 100 + willFillAnswerBtnIndex;
    }
    
    //answerView中已经填充完整，判断答案是否正确
    if (_answerView.answerBtnIndexs.count == 0) {
        NSMutableString *answerString = [NSMutableString string];
        [_answerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIButton class]]) {
                UIButton *answerBtn = obj;
                [answerString appendString:answerBtn.currentTitle];
            }
        }];
        //NSLog(@"%@",answerString);
        QYQuestion *question = self.questions[currentIndex];
        if ([answerString isEqualToString:question.answer]) {//答案正确
            [self changeAnswerBtnTitleColor:[UIColor greenColor]];
            if (!question.isHint) {
                [self changeCoinNum:1000];
            }
            question.isFinish = YES;
            //延迟跳转下一题
            _nextBtn.enabled = NO;
            [self performSelector:@selector(next) withObject:nil afterDelay:1];
            
        }else{//答案错误
            [self changeAnswerBtnTitleColor:[UIColor redColor]];
        }
    }
    
}

//更改answerView中所有的answerBtn的标题颜色
-(void)changeAnswerBtnTitleColor:(UIColor *)color{
    for (UIButton *answerBtn in _answerView.subviews) {
        [answerBtn setTitleColor:color forState:UIControlStateNormal];
    }
}

//更改金币数
-(void)changeCoinNum:(NSInteger)num{
    NSString *currentTitle = _coinBtn.currentTitle;
    NSInteger result = [currentTitle integerValue] + num;
    NSString *resultString = [@(result) stringValue];
    [_coinBtn setTitle:resultString forState:UIControlStateNormal];
}


//处理answerBtn的点击事件
-(void)answerBtnClick:(UIButton *)answerBtn {
    NSLog(@"你点击的是:%@",answerBtn.currentTitle);
    
    /*
     判断当前answerBtn的标题为空，直接return
     
     显示optionBtn（之前点击）
     
     answerBtn的标题置空
     
     更改所有的answerBtn的字体颜色为黑色
     
     把点击的answerBtn在answerView的subViews中对应的索引添加在answerView的answerBtnIndexs中
     
     对answerBtnIndexs进行排序
     
     */
    
    if (answerBtn.currentTitle.length == 0) return;
    
    UIButton *optionBtn = [_optionView viewWithTag:answerBtn.tag];
    optionBtn.hidden = NO;
    optionBtn.tag = answerBtn.tag = 0;
    
    [answerBtn setTitle:nil forState:UIControlStateNormal];
    
    [self changeAnswerBtnTitleColor:[UIColor blackColor]];
    
    
    NSInteger willEmptyAnswerBtnIndex = [_answerView.subviews indexOfObject:answerBtn];
    [_answerView.answerBtnIndexs addObject:@(willEmptyAnswerBtnIndex)];
    
    NSArray *sortedArray = [_answerView.answerBtnIndexs sortedArrayUsingSelector:@selector(compare:)];
    _answerView.answerBtnIndexs = [NSMutableArray arrayWithArray:sortedArray];
}


-(void)hint{
    /*
     判断金币数足够消费
     
     找到需要填充的answerBtn
     
     在模型中的answer中截取对应的正确答案
     
     拿正确答案，从optionView中找到标题相同的optionBtn
     
     模拟点击optionBtn
     
     标识当前题目被提示
     
     减去1000金币
     
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
