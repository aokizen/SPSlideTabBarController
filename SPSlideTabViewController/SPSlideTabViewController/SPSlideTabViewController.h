//
//  SPSlideTabViewController.h
//  SPSlideTabViewController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSlideTabViewProtocol.h"

@interface SPSlideTabViewController : UIViewController

@property (strong, nonatomic, nonnull) UIView<SPSlideTabViewProtocol> *slideTabView;
@property (strong, nonatomic, readonly, nonnull) UIScrollView *contentScrollView;

@property (strong, nonatomic, nullable) NSArray <UIViewController *> *viewControllers;

@property (assign, nonatomic, readonly) NSUInteger selectedTabIndex;

- (nonnull instancetype)initWithViewController:(nonnull NSArray <UIViewController *> *)viewControllers;
- (nonnull instancetype)initWithViewController:(nonnull NSArray <UIViewController *> *)viewControllers initTabIndex:(NSUInteger)initTabIndex;

- (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated;
- (void)addViewController:(nonnull UIViewController *) viewController;
- (void)addViewController:(nonnull UIViewController *) viewController atIndex:(NSUInteger)tabIndex;

@end
