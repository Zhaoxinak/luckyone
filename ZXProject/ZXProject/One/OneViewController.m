//
//  OneViewController.m
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "OneViewController.h"
#import "UIImage+GIF.h"
#import "LucyOneViewController.h"

@interface OneViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, strong) UIButton *luckyBtn;
@property (nonatomic, strong) LucyOneViewController *lucyOneVC;



@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setView];
    
}

#pragma mark -- 初始化数据
-(void)initData{
    //抽奖的控制器
    self.lucyOneVC = [[LucyOneViewController alloc]init];
    [self.lucyOneVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
}

#pragma mark -- 初始化视图
-(void)setView{
    
    //设置logo
    [self setLogo];
    //设置设置按钮
    [self setBtn];
    //设置gif图
    [self setGifView];
}

#pragma mark -- 设置logo
-(void)setLogo{
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width/2-50, 50, 100, 100)];
    logoView.image = [UIImage imageNamed:@"meloinfo"];
    [self.view insertSubview:logoView atIndex:1];
    
}

#pragma mark -- 设置gif图
-(void)setGifView{
    
    _gifImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hkdg" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    _gifImageView.image = image;
    _gifImageView.alpha = 0;
    [self.view insertSubview:_gifImageView atIndex:2];
    
}


#pragma mark -- 设置设置按钮
-(void)setBtn{
    
    _luckyBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/2-70, kScreen_Height/2, 140, 140)];
    [_luckyBtn setTitle:@"luckyOne"];
    [_luckyBtn setTitleColor:[UIColor blackColor]];
    [_luckyBtn setBackgroundColor:[UIColor redColor]];
    [_luckyBtn addTarget:self action:@selector(luckyOne)];
    [self.view insertSubview:_luckyBtn atIndex:1];
    
}

#pragma mark -- 执行抽奖按钮
-(void)luckyOne{
    _luckyBtn.enabled = NO;
    
    NSLog(@"抽奖");
    //简单的动画效果
    [UIView animateWithDuration:5.0 animations:^{
        _gifImageView.alpha = 1;
    } completion:^(BOOL finished) {
        
        /***************************/
        //简单的动画效果
        [UIView animateWithDuration:5.0 animations:^{
            
            //跳转
            _gifImageView.alpha = 0;
            [self presentViewController:self.lucyOneVC animated:YES completion:nil];
            
            
        } completion:^(BOOL finished) {
            
            _luckyBtn.enabled = YES;
        }];
        
        /***************************/
        
    }];
    
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
