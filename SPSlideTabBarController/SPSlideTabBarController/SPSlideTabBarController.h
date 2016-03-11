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

/**
 * the slide tab bar view on the top
 *
 * 顶部的 slide tab bar 视图
 */
@property (nonnull, strong, nonatomic) UIView<SPSlideTabBarProtocol> *slideTabView;

/**
 * the content scroll view
 *
 * 滑动的内容页
 */
@property (nonnull, strong, nonatomic, readonly) UIScrollView *contentScrollView;

/**
 * all viewControllers for all scroll page
 *
 * 所有滑动页面的 viewController
 */
@property (nullable, strong, nonatomic) NSArray <UIViewController *> *viewControllers;

/**
 * current selected tab index
 *
 * 当前选中的 tab index
 */
@property (assign, nonatomic, readonly) NSUInteger selectedTabIndex;


/**
 * 初始化方法
 *
 * @param viewControllers all viewControllers for all scroll page
 * @param viewControllers 所有滑动页面的 viewController
 */
- (nonnull instancetype)initWithViewController:(nonnull NSArray <UIViewController *> *)viewControllers;

/**
 * 初始化方法
 *
 * @param viewControllers all viewControllers for all scroll page
 * @param viewControllers 所有滑动页面的 viewController
 *
 * @param initTabIndex the selected tab index at the initialized time
 * @param initTabIndex 初始化的时候选中的 tab index
 */
- (nonnull instancetype)initWithViewController:(nonnull NSArray <UIViewController *> *)viewControllers initTabIndex:(NSUInteger)initTabIndex;

@end

@interface SPSlideTabBarController (ViewControllers)

/**
 * add a viewController to the slideTabBarController 
 * 
 * 为当前的 slideTabBarController 增加一个 viewController
 *
 * @discussion the viewController and the tab bar item will be added at the last index by default.
 * @discussion 待加入的 viewController 和 tab bar item 会被默认加到最后一个
 */
- (void)addViewController:(nonnull UIViewController *)viewController;

/**
 * add a viewController to the slideTabBarController at the index
 *
 * 为当前的 slideTabBarController 增加一个 viewController，添加到 index 的位置
 */
- (void)addViewController:(nonnull UIViewController *)viewController atIndex:(NSUInteger)tabIndex;

@end

@interface SPSlideTabBarController (SPSlideTabBar)

/**
 * initialize the slide tab view
 *
 * 初始化 slide tab bar 视图
 */
- (void)configureSlideTabView;

/**
 * call the controller to select tab index
 * 
 * 调用这个方法来选择某一个 tab
 */
- (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated;

#pragma mark - did scroll

/**
 * notify that the controller did scroll to tab of `index`
 *
 * 用于标识 controller 以及滑动到某一个 index 的 tab
 *
 * @discussion no concrete implementation. this method is only for override.
 * @discussion 没有具体的实现，这个方法仅为继承提供的
 */
- (void)didScrollToTabIndex:(NSUInteger)tabIndex;

@end

@class SPSlideTabBarItem;

@interface UIViewController (SPSlideTabBarItem)

/**
 * get the slide tab bar item for a viewController
 *
 * 获取一个 viewController 的 slide tab bar item
 */
@property(null_resettable, nonatomic, strong) SPSlideTabBarItem *slideTabBarItem;

/**
 * get the slideTabBarController for a viewController; if none, return nil
 *
 * 获取一个 viewController 的 slideTabBarController； 如果不存在，则返回nil
 */
@property(nullable, nonatomic, readonly, strong) SPSlideTabBarController *slideTabBarController;

@end
