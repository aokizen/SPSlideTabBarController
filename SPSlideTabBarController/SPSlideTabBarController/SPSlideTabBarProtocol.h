//
//  SPSlideTabBarProtocol.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SPSlideTabBarProtocol <NSObject>

@required
- (instancetype)initWithTabTitles:(NSArray <NSString *> *)titles;

//- (void)updateColors;
//- (void)configureTagViews;
//- (void)layoutTagSubviews;

- (void)modifyTabTitle:(NSString *)title atIndex:(NSUInteger)index;
- (void)modifyTabAttributedTitle:(NSAttributedString *)attributedTitle atIndex:(NSUInteger)index;

- (void)fixIndicatorOffset:(CGFloat)offset;
- (void)selectTabAtIndex:(NSUInteger)index;
- (void)scrollIndicatorToIndex:(NSUInteger)selectedIndex;

@end
