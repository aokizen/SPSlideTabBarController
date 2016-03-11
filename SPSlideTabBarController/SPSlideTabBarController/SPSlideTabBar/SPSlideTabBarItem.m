//
//  SPSlideTabBarItem.m
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBarItem.h"
#import "SPAppearance.h"

@implementation SPSlideTabBarItem

- (nonnull instancetype)initWithTitle:(nullable NSString *)title {
    self = [self init];
    if (self) {
        _title = title;
    }
    return self;
}

- (nonnull instancetype)initWithAttributedTitle:(nullable NSAttributedString *)attributedTitle {
    self = [self init];
    if (self) {
        _attibutedTitle = attributedTitle;
        if (_attibutedTitle) {
            _title = _attibutedTitle.string;
        }
    }
    return self;
}

+ (instancetype)appearance {
    return (SPSlideTabBarItem *)[SPAppearance appearanceForClass:self];
}

+ (instancetype)appearanceWhenContainedIn:(Class<UIAppearanceContainer>)ContainerClass, ... {
    return [self appearance];
}

- (UIFont *)barItemTextFont {
    if (_barItemTextFont == nil) {
        return [UIFont systemFontOfSize:15];
    }
    return _barItemTextFont;
}

- (UIColor *)barItemTextColor {
    if (_barItemTextColor == nil) {
        return [UIColor whiteColor];
    }
    return _barItemTextColor;
}

- (UIColor *)barItemSelectedTextColor {
    if (_barItemSelectedTextColor == nil) {
        return [UIColor blackColor];
    }
    return _barItemSelectedTextColor;
}

@end
