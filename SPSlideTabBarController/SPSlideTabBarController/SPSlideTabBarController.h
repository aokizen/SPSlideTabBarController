//
//  SPSlideTabBarController.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSlideTabBarProtocol.h"

@interface SPSlideTabBarController : UIViewController

@property (nonnull, strong, nonatomic) UIView<SPSlideTabBarProtocol> *slideTabView;
@property (nonnull, strong, nonatomic, readonly) UIScrollView *contentScrollView;

@property (nullable, strong, nonatomic) NSArray <UIViewController *> *viewControllers;

@property (assign, nonatomic, readonly) NSUInteger selectedTabIndex;

- (nonnull instancetype)initWithViewController:(nonnull NSArray <UIViewController *> *)viewControllers;
- (nonnull instancetype)initWithViewController:(nonnull NSArray <UIViewController *> *)viewControllers initTabIndex:(NSUInteger)initTabIndex;

@end

@interface SPSlideTabBarController (ViewControllers)

- (void)addViewController:(nonnull UIViewController *) viewController;
- (void)addViewController:(nonnull UIViewController *) viewController atIndex:(NSUInteger)tabIndex;

@end

@interface SPSlideTabBarController (SPSlideTabBar)

- (void)configureSlideTabView;

- (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated;

#pragma mark - did scroll

/**
 for override
 */
- (void)didScrollToTabIndex:(NSUInteger)tabIndex;

@end

@class SPSlideTabBarItem;

@interface UIViewController (SPSlideTabBarItem)

@property(null_resettable, nonatomic, strong) SPSlideTabBarItem *slideTabBarItem;
@property(nullable, nonatomic, readonly, strong) SPSlideTabBarController *slideTabBarController;

@end
