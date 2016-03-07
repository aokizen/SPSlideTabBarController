//
//  SPSlideTabBarItem.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPSlideTabBarItem : NSObject <UIAppearance>

@property (nullable, copy, nonatomic, readonly) NSString *title;
@property (nullable, strong, nonatomic, readonly) NSAttributedString *attibutedTitle;

@property (nonnull, strong, nonatomic) UIColor *barItemTextColor UI_APPEARANCE_SELECTOR;
@property (nonnull, strong, nonatomic) UIColor *barItemSelectedTextColor UI_APPEARANCE_SELECTOR;
@property (nonnull, strong, nonatomic) UIFont *barItemTextFont UI_APPEARANCE_SELECTOR;


- (nonnull instancetype)initWithTitle:(nullable NSString *)title;
- (nonnull instancetype)initWithAttributedTitle:(nullable NSAttributedString *)attributedTitle;

@end
