//
//  SPSlideTabBarItem.m
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBarItem.h"

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

@end
