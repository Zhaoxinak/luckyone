//
//  LucyOneViewController.m
//  ZXProject
//
//  Created by Mr.X on 2016/12/6.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#import "LucyOneViewController.h"
#import "iCarousel.h"



@interface LucyOneViewController ()<iCarouselDataSource, iCarouselDelegate>

@property (nonatomic, strong) UIButton *startBtn; //滚动栏
@property (nonatomic, strong) iCarousel *carousel; //滚动栏
@property (nonatomic, strong) NSMutableArray *staff; //所有员工

@end

@implementation LucyOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setView];
}

#pragma mark -- 初始化数据
-(void)initData{
 
    self.staff = [NSMutableArray array];
    for (int i = 0; i < 15; i++)
    {
        [_staff addObject:@(i)];
    }
    
}


#pragma mark -- 初始化视图
-(void)setView{
    self.view.backgroundColor = [UIColor blackColor];

    //设置滚动栏
    [self setCarousel];
    
    //设置开始／停止按钮
    [self setStartBtn];
    
    //设置回退按键
    [self dismissVC];
   
}

#pragma mark -- 设置开始／停止按钮
-(void)setStartBtn{
    
    _startBtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width/2-80, 80, 160, 80)];
    [_startBtn setTitle:@"start"];
    [_startBtn setTitleColor:[UIColor whiteColor]];
    [_startBtn addTarget:self action:@selector(startLucky:)];
    [self.view insertSubview:_startBtn atIndex:99];
    
}

#pragma mark -- 滚动栏
-(void)setCarousel{

    //create carousel
    _carousel = [[iCarousel alloc] initWithFrame:self.view.bounds];
    _carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _carousel.type = iCarouselTypeRotary;
    _carousel.delegate = self;
    _carousel.dataSource = self;
    //add carousel to view
    [self.view insertSubview:_carousel atIndex:2];
    
    
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


#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_staff count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_staff[index] stringValue];
    
    return view;
}

#pragma mark -- 开始抽奖
- (void)startLucky:(UIButton *)button{
    _startBtn.selected = !_startBtn.selected;
    
    if (!_startBtn.selected) {
        [_startBtn setTitle:@"start"];
        
        
    }else{
        
        [_startBtn setTitle:@"stop"];
    }
    
    
    
}

#pragma mark -- 注销代理
- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    _carousel.delegate = nil;
    _carousel.dataSource = nil;
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
