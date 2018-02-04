//
//  HomeViewController.m
//  SPSlideTabBarControllerDemo
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "HomeViewController.h"

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "ScrollViewController.h"
#import "ViewController.h"

#import "SPSlideTabBar.h"
#import "SPSlideTabBarItem.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (instancetype)initWithDefaultViewControllers {
    self = [self initWithDefaultViewControllersAndInitialIndex:0];
    if (self) { }
    return self;
}

- (instancetype)initWithDefaultViewControllersAndInitialIndex:(NSUInteger)initialIndex {
    self = [self initWithDefaultViewControllersAndSizingTabBar:NO initialIndex:initialIndex];
    if (self) { }
    return self;
}

- (instancetype)initWithDefaultViewControllersAndSizingTabBar:(BOOL)sizingTabBar {
    self = [self initWithDefaultViewControllersAndSizingTabBar:sizingTabBar initialIndex:0];
    if (self) { }
    return self;
}

- (instancetype)initWithDefaultViewControllersAndSizingTabBar:(BOOL)sizingTabBar initialIndex:(NSUInteger)initialIndex {
    
    [[SPSlideTabBarItem appearance] setBarItemSelectedTextColor:[UIColor whiteColor]];
    
    TableViewController *tableViewController = [[TableViewController alloc] init];
    [tableViewController setTitle:@"table"];
    
    CollectionViewController *collectionViewController = [[CollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    [collectionViewController setTitle:@"collection"];
    
    ScrollViewController *scrollViewController = [[ScrollViewController alloc] init];
    [scrollViewController setTitle:@"scroll"];
    
    ViewController *viewController = [[ViewController alloc] init];
    [viewController setTitle:@"general"];
    
    self = [self initWithViewController:@[tableViewController, collectionViewController, scrollViewController, viewController] initTabIndex:initialIndex];
    
    
    if (self) {
        _sizingTabBar = sizingTabBar;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.slideTabView setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:1]];
    [self.slideTabView changeIndicatorColor:[UIColor whiteColor]];
    [self setTitle:@"homeViewController"];
}

- (void)configureSlideTabView {
    if (_sizingTabBar) {
        
        NSMutableArray <SPSlideTabBarItem *> *slideTabBarItems = [NSMutableArray array];
        [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
            [slideTabBarItems addObject:viewController.slideTabBarItem];
        }];
        
        self.slideTabView = [[SPSizingSlideTabBar alloc] initWithTabBarItems:slideTabBarItems];
    }

    [super configureSlideTabView];

}

- (BOOL)hidesBottomBarWhenPushed {
    if (self.navigationController == nil) {
        return NO;
    }
    
    if (self.navigationController.viewControllers.firstObject == self) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
