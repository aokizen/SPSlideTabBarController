//
//  SPSlideTabBarItem.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * a `SPSlideTabBarItem` defines the content and style of  a tab of a slide tab bar
 * 一个 `SPSlideTabBarItem` 定义了一个 slide tab bar 的一个 tab 的内容和样式
 */
@interface SPSlideTabBarItem : NSObject <UIAppearance>

/**
 * the plain text title of a slide tab bar item
 * 
 * 标题文字，纯文字
 */
@property (nullable, copy, nonatomic, readonly) NSString *title;

/**
 * the attributed text title of a slide tab bar item
 *
 * 标题文字，带属性的文字
 */
@property (nullable, strong, nonatomic, readonly) NSAttributedString *attibutedTitle;


/**
 * the text color of the bar item
 * bar item 的文字颜色
 */
@property (nonnull, strong, nonatomic) UIColor *barItemTextColor UI_APPEARANCE_SELECTOR;

/**
 * the selected text color of the bar item
 * bar item 被选中的文字颜色
 */
@property (nonnull, strong, nonatomic) UIColor *barItemSelectedTextColor UI_APPEARANCE_SELECTOR;

/**
 * the font of the bar item
 * bar item 的文字字体
 */
@property (nonnull, strong, nonatomic) UIFont *barItemTextFont UI_APPEARANCE_SELECTOR;


- (nonnull instancetype)initWithTitle:(nullable NSString *)title;
- (nonnull instancetype)initWithAttributedTitle:(nullable NSAttributedString *)attributedTitle;

@end
