//
//  SPSlideTabBar.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSlideTabBarProtocol.h"

@interface SPFixedSlideTabBar : UIView <SPSlideTabBarProtocol>

@end

@interface SPSizingSlideTabBar : SPFixedSlideTabBar

@end
