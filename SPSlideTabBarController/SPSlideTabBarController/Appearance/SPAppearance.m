//
//  SPAppearance.m
//  SPSlideTabBarController
//
//  Created by Jiangwei Wu on 16/3/7.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPAppearance.h"

@interface SPAppearance ()

@property (nonnull, strong, nonatomic) Class mainClass;
@property (nonnull, strong, nonatomic) NSMutableArray *invocations;

@end

static NSMutableDictionary *dictionaryOfClasses = nil;

@implementation SPAppearance

+ (instancetype)appearanceForClass:(Class)thisClass {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^() {
        if (!dictionaryOfClasses) {
            dictionaryOfClasses = [NSMutableDictionary dictionary];
        }
        
    });
    
    id thisAppearance = [dictionaryOfClasses objectForKey:NSStringFromClass(thisClass)];
    if (thisAppearance == nil) {
        thisAppearance = [[self alloc] initWithClass:thisClass];
        [dictionaryOfClasses setObject:thisAppearance forKey:NSStringFromClass(thisClass)];
    }
    return thisAppearance;
}


- (instancetype)initWithClass:(Class)thisClass {
    self = [self initPrivate];
    if (self) {
        self.mainClass = thisClass;
        self.invocations = [NSMutableArray array];
    }
    return self;
}

- (instancetype)init {
    [NSException exceptionWithName:@"InvalidOperation" reason:@"Cannot invoke init. Use appearanceForClass: method" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation retainArguments];
    [self.invocations addObject:anInvocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.mainClass instanceMethodSignatureForSelector:aSelector];
}

- (void)startForwarding:(id)sender {
    for (NSInvocation *invocation in self.invocations) {
        [invocation setTarget:sender];
        [invocation invoke];
    }
    
    // We now need to also set the properties of the superclass
    Class sc = [sender superclass];
    
    while (sc != [NSObject class]) {
        [[[self class] appearanceForClass:sc] startForwardingInternal:sender];
        sc = [sc superclass];
    }
}

- (void)startForwardingInternal:(id)sender {
    for (NSInvocation *invocation in self.invocations) {
        [invocation setTarget:sender];
        [invocation invoke];
    }
}

@end
