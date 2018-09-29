//
//  ViewController.m
//  CNPageControl
//
//  Created by Mac2 on 2018/9/29.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "ViewController.h"
#import "CNPageControl.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CNPageControl *pageControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpScrollView];
}

- (void)setUpScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, 300);
    [self.view addSubview:self.scrollView];
    
    for (int i=0; i<5; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, 300)];
        view.backgroundColor = [UIColor colorWithRed:50.0 * i / 255.0 green:0.5 + 20 * i / 255.0 blue:0.6 alpha:1];
        [self.scrollView addSubview:view];
    }
    
    self.pageControl = [[CNPageControl alloc] initWithFrame:CGRectMake(0, 270, SCREEN_WIDTH, 30) pageStyle:CNPageControlStyleDefalut];
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    [self.view addSubview:self.pageControl];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollView.contentOffset.x == 0) {
        self.pageControl.currentPage = 0;
    }
    if (self.scrollView.contentOffset.x == SCREEN_WIDTH) {
        self.pageControl.currentPage = 1;
    }
    if (self.scrollView.contentOffset.x == SCREEN_WIDTH * 2) {
        self.pageControl.currentPage = 2;
    }
    if (self.scrollView.contentOffset.x == SCREEN_WIDTH * 3) {
        self.pageControl.currentPage = 3;
    }
    if (self.scrollView.contentOffset.x == SCREEN_WIDTH * 4) {
        self.pageControl.currentPage = 4;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
