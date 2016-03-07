//
//  SPSlideTabBarProtocol.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSlideTabBarItem;

@protocol SPSlideTabBarProtocol <NSObject>

@required
- (instancetype)initWithTabBarItems:(NSArray <SPSlideTabBarItem *> *)tabBarItems;

- (void)insertTabBarItem:(SPSlideTabBarItem *)item atIndex:(NSUInteger)index;
- (void)setSlideTabBarItem:(SPSlideTabBarItem *)slideTabBarItem atIndex:(NSUInteger)index;

- (NSArray <SPSlideTabBarItem *> *)slideTabBarItems;
- (SPSlideTabBarItem *)slideTabBarItemAtIndex:(NSUInteger)index;

- (void)selectTabAtIndex:(NSUInteger)index;
- (NSUInteger)selectedTabIndex;
- (void)scrollIndicatorToIndex:(NSUInteger)selectedIndex;

- (void)fixIndicatorWithScrollOffset:(CGFloat)offset;

@end