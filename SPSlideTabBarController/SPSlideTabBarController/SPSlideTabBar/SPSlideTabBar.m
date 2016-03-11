//
//  SPSlideTabBar.m
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBar.h"

#import "SPSlideTabBarItem.h"
#import "SPAppearance.h"

/**
 * a custom slide tab bar whose tabs' width is fixed which is depend on the slide tab bar's width.
 *
 * 一个定制的 slide tab bar. 所有 tab 都是固定宽度的，具体宽度是多少是根据 tab bar 的宽度来均分计算的。
 */
@interface SPFixedSlideTabBar () {
    NSUInteger _selectedTabIndex;
}

@property (nonnull, strong, nonatomic) UIScrollView *scrollView;
@property (nonnull, strong, nonatomic) UIView *indicatorLine;

@property (nonnull, strong, nonatomic) NSArray <SPSlideTabBarItem *> *slideTabBarItems;

@end

@implementation SPFixedSlideTabBar

/**
 * an required method to initialize a tab bar with the array of `SPSlideTabBarItem`.
 *
 * 通过一个 `SPSlideTabBarItem` 数组的初始化方法
 */
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
    
    [self resetTabBarItemViews];
    
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


/**
 * reset all tab bar item views
 *
 * 重新生成所有的 tab bar item 视图
 */
- (void)resetTabBarItemViews {
    
    [self.slideTabBarItems enumerateObjectsUsingBlock:^(SPSlideTabBarItem *item, NSUInteger index, BOOL *stop) {
        
        [[SPAppearance appearanceForClass:[item class]] startForwarding:item];
        
        NSUInteger tag = index + 1000;
        
        UIButton *button = (UIButton *)[self.scrollView viewWithTag:tag];
        if (button == nil) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTag:tag];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
        }
        
        if (item.attibutedTitle) {
            [button setAttributedTitle:item.attibutedTitle forState:UIControlStateNormal];
        }
        else {
            [button setTitle:item.title forState:UIControlStateNormal];
            [button.titleLabel setFont:item.barItemTextFont];
            [button setTitleColor:item.barItemTextColor forState:UIControlStateNormal];
            [button setTitleColor:item.barItemSelectedTextColor forState:UIControlStateHighlighted];
            [button setTitleColor:item.barItemSelectedTextColor forState:UIControlStateSelected];
            [button setTitleColor:item.barItemSelectedTextColor forState:UIControlStateSelected | UIControlStateHighlighted];
        }

        [button setSelected:(index == self.selectedTabIndex)];
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

/**
 * layout all tab bar item subviews
 *
 * 为所有的 tab bar item 子视图布局
 */
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
            if (self.delegate && [self.delegate respondsToSelector:@selector(slideTabBar:didSelectIndex:)]) {
                [self.delegate slideTabBar:self didSelectIndex:index];
            }
            *stop = YES;
        }
    }];
}

#pragma mark - SPSlideTabBarProtocol

/**
 * insert a `SPSlideTabBarItem` at an index
 *
 * 在 index 的位置插入一个 `SPSlideTabBarItem`
 */
- (void)insertTabBarItem:(SPSlideTabBarItem *)item atIndex:(NSUInteger)index {
    NSMutableArray <SPSlideTabBarItem *> *slideTabBarItems = [NSMutableArray arrayWithArray:[self slideTabBarItems]];
    if (index <= slideTabBarItems.count) {
        [slideTabBarItems insertObject:item atIndex:index];
        [self setSlideTabBarItems:slideTabBarItems];
        [self resetTabBarItemViews];
    }
}

/**
 * reset the `SPSlideTabBarItem` at the index
 *
 * 重置某一个位置 index 的 `SPSlideTabBarItem`
 */
- (void)setSlideTabBarItem:(SPSlideTabBarItem *)slideTabBarItem atIndex:(NSUInteger)index {
    NSMutableArray <SPSlideTabBarItem *> *slideTabBarItems = [NSMutableArray arrayWithArray:[self slideTabBarItems]];
    if (index < slideTabBarItems.count) {
        [slideTabBarItems replaceObjectAtIndex:index withObject:slideTabBarItem];
        [self setSlideTabBarItems:slideTabBarItems];
        [self resetTabBarItemViews];
    }
}


/**
 * get all existing `SPSlideTabBarItem`s.
 *
 * 获取所有的 `SPSlideTabBarItems`.
 *
 * @return the array of `SPSlideTabBarItem`
 * @retuen 返回 `SPSlideTabBarItem` 的数组
 */
- (NSArray<SPSlideTabBarItem *> *)slideTabBarItems {
    return _slideTabBarItems;
}

/**
 * get the `SPSlideTabBarItem` at the inex.
 *
 * 获取具体 index 位置的 `SPSlideTabBarItem`
 */
- (SPSlideTabBarItem *)slideTabBarItemAtIndex:(NSUInteger)index {
    if (index < _slideTabBarItems.count) {
        return [_slideTabBarItems objectAtIndex:index];
    }
    return nil;
}


/**
 * select the tab of index
 *
 * 选择一个 index 位置的 tab
 */
- (void)selectTabAtIndex:(NSUInteger)index {
    NSUInteger buttonIndex = 0;
    NSArray <UIButton *> *buttons = self.tabBarButtonSubviews;
    for (UIButton *button in buttons) {
        button.selected = (buttonIndex == index);
        buttonIndex += 1;
    }
    
    _selectedTabIndex = index;
}

/**
 * the current selected tab index
 *
 * 当前选中的 tab index 位置
 */
- (NSUInteger)selectedTabIndex {
    return _selectedTabIndex;
}

/**
 * scroll indicator to the selected index
 *
 * 将 indicator 滑动到要选中的 index
 */
- (void)scrollIndicatorToIndex:(NSUInteger)selectedIndex {
    if (selectedIndex < self.tabBarButtonSubviews.count) {
        UIButton *button = [self.tabBarButtonSubviews objectAtIndex:selectedIndex];
        if (button) {
            
            CGRect frame = self.indicatorLine.frame;
            frame.size.width = button.titleLabel.intrinsicContentSize.width;
            frame.origin.x = CGRectGetMidX(button.frame) - CGRectGetWidth(frame) / 2.0;
            self.indicatorLine.frame = frame;
            
            _selectedTabIndex = selectedIndex;
            
            [UIView animateWithDuration:0.25 animations:^ {
                [self setNeedsLayout];
            }completion:^(BOOL finished) {
                [self selectTabAtIndex:selectedIndex];
            }];
        }
    }
}


/**
 * fix indicator position with the content srollView's content offset.
 *
 * 根据内容滑动界面的滑动 offset 来修正 indicator 的位置
 */
- (void)fixIndicatorWithScrollOffset:(CGFloat)offset {
    NSArray <UIButton *> *buttons = self.tabBarButtonSubviews;
    NSUInteger selectedIndex = self.selectedTabIndex;
    
    if (selectedIndex < buttons.count) {
        
        UIButton *button = [buttons objectAtIndex:selectedIndex];
        CGFloat pageOffset = offset - CGRectGetWidth(self.frame) * selectedIndex;
        
        NSInteger indexOffset = pageOffset / CGRectGetWidth(self.frame);
        if (((NSInteger)pageOffset % (NSInteger)CGRectGetWidth(self.frame)) != 0) {
            indexOffset += ((offset > CGRectGetWidth(self.frame) * selectedIndex) ? 1 : -1);
        }
        NSInteger targetIndex = selectedIndex + indexOffset;
        
        if (targetIndex < 0) {
            targetIndex = 0;
        }
        else if (targetIndex >= buttons.count) {
            targetIndex = buttons.count - 1;
        }
        
        UIButton *targetButton = [buttons objectAtIndex:targetIndex];
        
        if (targetButton == nil) {
            return;
        }
        
        if (targetButton == button) {
            CGRect frame = self.indicatorLine.frame;
            frame.size.width = targetButton.titleLabel.intrinsicContentSize.width;
            frame.origin.x = CGRectGetMidX(targetButton.frame) - CGRectGetWidth(frame) / 2.0;
            self.indicatorLine.frame = frame;
            return;
        }
        
        CGFloat denominator = ((CGFloat)(abs((int)targetIndex - (int)selectedIndex) * CGRectGetWidth(self.frame)));
        if (denominator == 0) {
            return;
        }
        
        CGFloat percentage = ((CGFloat)fabs(pageOffset)) / denominator;
        
        CGRect frame = self.indicatorLine.frame;
        frame.size.width = button.titleLabel.intrinsicContentSize.width + (targetButton.titleLabel.intrinsicContentSize.width - button.titleLabel.intrinsicContentSize.width) * percentage;
        frame.origin.x = CGRectGetMidX(button.frame) - CGRectGetWidth(frame) / 2.0 + (CGRectGetMidX(targetButton.frame) - CGRectGetMidX(button.frame)) *percentage;
        self.indicatorLine.frame = frame;
    }
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


/**
 * a custom slide tab bar whose tabs' width is depend on the content size of the tab.
 *
 * 一个定制的 slide tab bar. 所有 tab 的宽度都是根据 tab 的内容来自适应的。
 */
@implementation SPSizingSlideTabBar

/**
 * an required method to initialize a tab bar with the array of `SPSlideTabBarItem`.
 *
 * 通过一个 `SPSlideTabBarItem` 数组的初始化方法
 */
- (instancetype)initWithTabBarItems:(NSArray<SPSlideTabBarItem *> *)tabBarItems {
    self = [super initWithTabBarItems:tabBarItems];
    if (self) {
        [self.scrollView setScrollEnabled:YES];
        self.scrollView.bounces = NO;
    }
    return self;
}

/**
 * reset all tab bar item views
 *
 * 重新生成所有的 tab bar item 视图
 */
- (void)resetButtonPadding {
    NSArray <UIButton *> *buttons = self.tabBarButtonSubviews;
    CGFloat padding = ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 16 : 8);
    [buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger index, BOOL *stop) {
        [button setContentEdgeInsets:UIEdgeInsetsMake(8, padding, 8, padding)];
    }];
    
    [self setNeedsLayout];
}


/**
 * layout all tab bar item subviews
 *
 * 为所有的 tab bar item 子视图布局
 */
- (void)layoutTabBarItemSubviews {
    NSArray <UIButton *> *buttons = self.tabBarButtonSubviews;
    CGFloat padding = ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 16 : 8);
    
    __block UIButton *lastButton = nil;
    [buttons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger index, BOOL *stop) {
       
        [button sizeToFit];
        
        CGRect frame = button.frame;
        frame.origin.y = 0;
        frame.size.height = CGRectGetHeight(self.frame);
        if (lastButton == nil) {
            frame.origin.x = padding;
        }
        else {
            frame.origin.x = CGRectGetMaxX(lastButton.frame) + padding;
        }
        button.frame = frame;
        lastButton = button;
    }];
    
    [self.scrollView setContentSize:CGSizeMake(CGRectGetMaxX(lastButton.frame) + padding, CGRectGetHeight(self.frame))];
}


#pragma mark - SPSlideTabBarProtocol

/**
 * select the tab of index
 *
 * 选择一个 index 位置的 tab
 */
- (void)selectTabAtIndex:(NSUInteger)index {
    [super selectTabAtIndex:index];
    
    CGFloat padding = ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 16 : 8);
    if (self.selectedTabIndex < self.tabBarButtonSubviews.count) {
        UIButton *button = [self.tabBarButtonSubviews objectAtIndex:self.selectedTabIndex];
        [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetMinX(button.frame) - padding, CGRectGetMinY(button.frame), CGRectGetWidth(button.frame) + padding * 2, CGRectGetHeight(button.frame)) animated:YES];
    }
}

@end
