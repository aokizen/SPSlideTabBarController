//
//  SPAppearance.h
//  SPSlideTabBarController
//
//  Created by Jiangwei Wu on 16/3/7.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A `SPAppearance` is a global appearance setter.
 *
 * `SPAppearance` 是一个全局的外观设置器。
 *
 * NOTE: The reference implementation of this Appearance is from (here)[http://stackoverflow.com/questions/15732885/uiappearance-proxy-for-custom-objects/15734256#15734256].
 */
@interface SPAppearance : NSObject

/**
 * Get a `SPAppearance` instance for the concrete `Class`.
 *
 * 为一个具体的 类 获取 `SPAppearance` 的一个 实例。
 *
 * @return the same object instance for each different class
 */
+ (instancetype)appearanceForClass:(Class)thisClass;


/**
 * start forward the appearance setting for the sender.
 *
 * 开始为 sender 转发设置。
 *
 * @param sender the instance the appearance of which is need to be forwarded.
 * @param sender 具体需要转发的实例
 */
- (void)startForwarding:(id)sender;

@end
