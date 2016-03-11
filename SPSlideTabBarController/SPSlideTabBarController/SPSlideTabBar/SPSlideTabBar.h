//
//  SPSlideTabBar.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSlideTabBarProtocol.h"

/**
 * the delegate of a `SPSlideTabBar`
 *
 * 一个 `SPSlideTabBar` 的代理
 */
@protocol SPSlideTabBarDelegate <NSObject>

@required

/**
 * tell the delegate the the slide tab bar did select the tab of `index`.
 *
 * slide tab bar 通知代理已经选择了某一个 index 的 tab
 */
- (void)slideTabBar:(nonnull UIView <SPSlideTabBarProtocol> *)slideTabBar didSelectIndex:(NSUInteger)index;

@end


/**
 * a custom slide tab bar whose tabs' width is fixed which is depend on the slide tab bar's width.
 *
 * 一个定制的 slide tab bar. 所有 tab 都是固定宽度的，具体宽度是多少是根据 tab bar 的宽度来均分计算的。
 */
@interface SPFixedSlideTabBar : UIView <SPSlideTabBarProtocol>

@property (weak, nonatomic) id<SPSlideTabBarDelegate> delegate;

/**
 * reset all tab bar item views
 *
 * 重新生成所有的 tab bar item 视图
 */
- (void)resetTabBarItemViews;

/**
 * layout all tab bar item subviews
 *
 * 为所有的 tab bar item 子视图布局
 */
- (void)layoutTabBarItemSubviews;

@end


/**
 * a custom slide tab bar whose tabs' width is depend on the content size of the tab.
 *
 * 一个定制的 slide tab bar. 所有 tab 的宽度都是根据 tab 的内容来自适应的。
 */
@interface SPSizingSlideTabBar : SPFixedSlideTabBar

@end
