//
//  SPSlideTabBarItem.h
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPSlideTabBarItem : NSObject

@property (nullable, copy, nonatomic, readonly) NSString *title;
@property (nullable, strong, nonatomic, readonly) NSAttributedString *attibutedTitle;

- (nonnull instancetype)initWithTitle:(nullable NSString *)title;
- (nonnull instancetype)initWithAttributedTitle:(nullable NSAttributedString *)attributedTitle;

@end
