//
//  SPSlideTabBarProtocol.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SPSlideTabBarItem;

/**
 * `SPSlideTabBarProtocol` is a protocol that a custom slide tab bar must follow.
 *
 * `SPSlideTabBarProtocol` 是一个 任何定制的 SlideTaBar 都需要遵循的协议
 */
@protocol SPSlideTabBarProtocol <NSObject>

@required

/**
 * an required method to initialize a tab bar with the array of `SPSlideTabBarItem`.
 *
 * 通过一个 `SPSlideTabBarItem` 数组的初始化方法
 */
- (instancetype)initWithTabBarItems:(NSArray <SPSlideTabBarItem *> *)tabBarItems;


/**
 * insert a `SPSlideTabBarItem` at an index
 *
 * 在 index 的位置插入一个 `SPSlideTabBarItem`
 */
- (void)insertTabBarItem:(SPSlideTabBarItem *)item atIndex:(NSUInteger)index;

/**
 * reset the `SPSlideTabBarItem` at the index
 *
 * 重置某一个位置 index 的 `SPSlideTabBarItem`
 */
- (void)setSlideTabBarItem:(SPSlideTabBarItem *)slideTabBarItem atIndex:(NSUInteger)index;


/**
 * get all existing `SPSlideTabBarItem`s.
 *
 * 获取所有的 `SPSlideTabBarItems`.
 *
 * @return the array of `SPSlideTabBarItem`
 * @retuen 返回 `SPSlideTabBarItem` 的数组
 */
- (NSArray <SPSlideTabBarItem *> *)slideTabBarItems;

/**
 * get the `SPSlideTabBarItem` at the inex.
 *
 * 获取具体 index 位置的 `SPSlideTabBarItem`
 */
- (SPSlideTabBarItem *)slideTabBarItemAtIndex:(NSUInteger)index;


/**
 * select the tab of index
 *
 * 选择一个 index 位置的 tab
 */
- (void)selectTabAtIndex:(NSUInteger)index;

/**
 * the current selected tab index
 *
 * 当前选中的 tab index 位置
 */
- (NSUInteger)selectedTabIndex;

/**
 * scroll indicator to the selected index
 *
 * 将 indicator 滑动到要选中的 index
 */
- (void)scrollIndicatorToIndex:(NSUInteger)selectedIndex;


/**
 * fix indicator position with the content srollView's content offset.
 *
 * 根据内容滑动界面的滑动 offset 来修正 indicator 的位置
 */
- (void)fixIndicatorWithScrollOffset:(CGFloat)offset;

@end
