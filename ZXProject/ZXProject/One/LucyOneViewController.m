//
//  LucyOneViewController.m
//  ZXProject
//
//  Created by Mr.X on 2016/12/6.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "LucyOneViewController.h"

@interface LucyOneViewController ()

@end

@implementation LucyOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setView];
}

#pragma mark -- 初始化视图
-(void)setView{
    self.view.backgroundColor = [UIColor blackColor];

    //设置回退按键
    [self dismissVC];
}


#pragma mark -- 回退按键
-(void)dismissVC{
  
    UIButton *dissBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, kScreen_Height-50, kScreen_Width, 50)];
    [dissBtn setTitle:@"返回"];
    [dissBtn setTitleColor:[UIColor whiteColor]];
    [dissBtn addTarget:self action:@selector(exit)];
    [self.view insertSubview:dissBtn atIndex:99];

}

#pragma mark -- 回退功能
-(void)exit{

    [self dismissViewControllerAnimated:YES completion:nil];

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
