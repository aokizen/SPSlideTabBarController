//
//  ScrollViewController.m
//  SPSlideTabBarControllerDemo
//
//  Created by Jiangwei Wu on 16/3/1.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "ScrollViewController.h"

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.2]];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds), CGRectGetHeight(self.scrollView.bounds) * 2)];
}

@end
