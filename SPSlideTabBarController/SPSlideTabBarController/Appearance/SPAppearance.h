//
//  SPAppearance.h
//  SPSlideTabBarController
//
//  Created by Jiangwei Wu on 16/3/7.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAppearance : NSObject

+ (instancetype)appearanceForClass:(Class)thisClass;
- (void)startForwarding:(id)sender;

@end
