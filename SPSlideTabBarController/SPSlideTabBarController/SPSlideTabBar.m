//
//  SPSlideTabBar.m
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBar.h"

#import "SPSlideTabBarItem.h"

@interface SPFixedSlideTabBar () {
    NSUInteger _selectedTabIndex;
}

@property (nonnull, strong, nonatomic) UIScrollView *scrollView;
@property (nonnull, strong, nonatomic) UIView *indicatorLine;

@property (nonnull, strong, nonatomic) NSArray <SPSlideTabBarItem *> *slideTabBarItems;

@end

@implementation SPFixedSlideTabBar

- (instancetype)initWithTabBarItems:(NSArray<SPSlideTabBarItem *> *)tabBarItems {
    self = [self init];
    if (self) {
        _slideTabBarItems = tabBarItems;
        [self initialize];
    }
    return self;
}

- (void)initialize {

    UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 1, CGRectGetWidth(self.bounds), 1)];
    [separatorLine setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth];
    [separatorLine setBackgroundColor:[UIColor grayColor]];
    [self addSubview:separatorLine];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.scrollView];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setScrollEnabled:NO];
    
    [self initializeTabBarItemViews];
    
    [self bringSubviewToFront:separatorLine];
    
    _indicatorLine = [UIView new];
    [self.indicatorLine setBackgroundColor:[UIColor blueColor]];
    [self.indicatorLine setFrame:CGRectMake(0, 0, 0, 2)];
    [self.scrollView addSubview:self.indicatorLine];
    
    UIButton *firstButton = self.tabBarButtonSubviews.firstObject;
    if (firstButton) {
        [self.indicatorLine setFrame:CGRectMake(0, CGRectGetHeight(self.scrollView.bounds) - CGRectGetHeight(self.indicatorLine.bounds), firstButton.intrinsicContentSize.width, CGRectGetHeight(self.indicatorLine.bounds))];
        self.indicatorLine.center = CGPointMake(firstButton.center.x, self.indicatorLine.center.y);
    }
}

- (void)initializeTabBarItemViews {
    
    [self.slideTabBarItems enumerateObjectsUsingBlock:^(SPSlideTabBarItem *item, NSUInteger index, BOOL *stop) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (item.attibutedTitle) {
            [button setAttributedTitle:item.attibutedTitle forState:UIControlStateNormal];
        }
        else {
            [button setTitle:item.title forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:button];
        
        [button setSelected:(index == 0)];
    }];
    
    [self setNeedsLayout];
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutTabBarItemSubviews];
    
    if ([self selectedTabIndex] < self.tabBarButtonSubviews.count) {
        UIButton *button = [self.tabBarButtonSubviews objectAtIndex:[self selectedTabIndex]];
        CGRect frame = self.indicatorLine.frame;
        frame.origin.y = CGRectGetHeight(self.frame) - CGRectGetHeight(frame);
        frame.size.width = button.titleLabel.intrinsicContentSize.width;
        frame.origin.x = CGRectGetMidX(button.frame) - CGRectGetWidth(frame) / 2.0;
        self.indicatorLine.frame = frame;
    }
}

- (void)layoutTabBarItemSubviews {
    
    NSArray <UIButton *> *buttons = [self tabBarButtonSubviews];
    NSUInteger tabCount = buttons.count;
    
    [buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger index, BOOL *stop) {
        [button sizeToFit];
        button.center = CGPointMake((CGRectGetWidth(self.frame) / 2.0) * ((1.0 / (CGFloat)tabCount) + (1 / (tabCount / 2.0) * (CGFloat)index)), CGRectGetHeight(self.frame) / 2.0);
    }];
}
     
#pragma mark - action

- (IBAction)buttonAction:(UIButton *)sender {
    NSArray <UIButton *> *buttons = self.tabBarButtonSubviews;
    [buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger index, BOOL *stop) {
        if (button == sender) {
            [self selectTabAtIndex:index];
            
            
            *stop = YES;
        }
    }];
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
    _selectedTabIndex = index;
}

- (NSUInteger)selectedTabIndex {
    return _selectedTabIndex;
}

- (void)scrollIndicatorToIndex:(NSUInteger)selectedIndex {
    
}

- (void)fixIndicatorWithScrollOffset:(CGFloat)offset {
    
}

#pragma mark - getter

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, 44);
}

- (NSArray <UIButton *> *)tabBarButtonSubviews {
    NSMutableArray <UIButton *> *buttons = [NSMutableArray array];
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [buttons addObject:(UIButton *)view];
        }
    }
    return buttons;
}

@end

@implementation SPSizingSlideTabBar


@end
