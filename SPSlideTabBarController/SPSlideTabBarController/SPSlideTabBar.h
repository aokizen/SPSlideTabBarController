//
//  SPSlideTabBar.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSlideTabBarProtocol.h"

@protocol SPSlideTabBarDelegate <NSObject>

- (void)slideTabBar:(UIView <SPSlideTabBarProtocol> *)slideTabBar didSelectIndex:(NSUInteger)index;

@end

@interface SPFixedSlideTabBar : UIView <SPSlideTabBarProtocol>

@property (weak, nonatomic) id<SPSlideTabBarDelegate> delegate;

- (void)initializeTabBarItemViews;
- (void)layoutTabBarItemSubviews;



@end

@interface SPSizingSlideTabBar : SPFixedSlideTabBar

@end
