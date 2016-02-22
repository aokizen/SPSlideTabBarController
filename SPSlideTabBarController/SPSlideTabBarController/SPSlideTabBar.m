//
//  SPSlideTabBar.m
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBar.h"

@interface SPFixedSlideTabBar ()

@property (nonnull, strong, nonatomic) NSArray <SPSlideTabBarItem *> *slideTabBarItems;

@end

@implementation SPFixedSlideTabBar

- (instancetype)initWithTabBarItems:(NSArray<SPSlideTabBarItem *> *)tabBarItems {
    self = [self init];
    if (self) {
        _slideTabBarItems = tabBarItems;
    }
    return self;
}

- (void)configureTabBarItemViews {
    
}

- (void)layoutTabBarItemSubviews {
    
}

#pragma mark - SPSlideTabBarProtocol

- (void)setSlideTabBarItem:(SPSlideTabBarItem *)slideTabBarItem atIndex:(NSUInteger)index {
    
}

- (NSArray<SPSlideTabBarItem *> *)slideTabBarItems {
    return _slideTabBarItems;
}

- (SPSlideTabBarItem *)slideTabBarItemAtIndex:(NSUInteger)index {
    if (index < _slideTabBarItems.count) {
        return [_slideTabBarItems objectAtIndex:index];
    }
    return nil;
}

- (void)selectTabAtIndex:(NSUInteger)index {
    
}

- (void)scrollIndicatorToIndex:(NSUInteger)selectedIndex {
    
}

- (void)fixIndicatorWithScrollOffset:(CGFloat)offset {
    
}

#pragma mark - getter

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 44);
}



@end

@implementation SPSizingSlideTabBar


@end
