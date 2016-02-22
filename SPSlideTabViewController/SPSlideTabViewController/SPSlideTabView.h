//
//  SPSlideTabView.h
//  SPSlideTabViewController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPSlideTabViewProtocol.h"

@interface SPFixedSlideTabView : UIView <SPSlideTabViewProtocol>

@end

@interface SPSizingSlideTabView : SPFixedSlideTabView

@end
