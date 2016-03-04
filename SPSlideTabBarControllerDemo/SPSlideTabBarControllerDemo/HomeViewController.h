//
//  HomeViewController.h
//  SPSlideTabBarControllerDemo
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBarController.h"

@interface HomeViewController : SPSlideTabBarController

@property (assign, nonatomic) BOOL sizingTabBar;

- (instancetype)initWithDefaultViewControllers;
- (instancetype)initWithDefaultViewControllersAndInitialIndex:(NSUInteger)initialIndex;
- (instancetype)initWithDefaultViewControllersAndSizingTabBar:(BOOL)sizingTabBar;
- (instancetype)initWithDefaultViewControllersAndSizingTabBar:(BOOL)sizingTabBar initialIndex:(NSUInteger)initialIndex;

@end
