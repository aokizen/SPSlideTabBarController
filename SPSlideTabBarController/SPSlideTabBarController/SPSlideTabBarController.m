//
//  SPSlideTabBarController.m
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBarController.h"

#import "SPSlideTabBar.h"

@interface SPSlideTabBarController () <UIScrollViewDelegate>

@property (assign, nonatomic) NSUInteger initTabIndex;

@end

@implementation SPSlideTabBarController

@synthesize contentScrollView = _contentScrollView;

#pragma mark - initialize 

- (nonnull instancetype)initWithViewController:(nonnull NSArray<UIViewController *> *)viewControllers {
    self = [self init];
    if (self) {
        _viewControllers = viewControllers;
        
        _initTabIndex = 0;
    }
    return self;
}

- (nonnull instancetype)initWithViewController:(nonnull NSArray <UIViewController *> *)viewControllers initTabIndex:(NSUInteger)initTabIndex {
    self = [self initWithViewController:viewControllers];
    if (self) {
        _initTabIndex = initTabIndex;
        if (_initTabIndex >= self.viewControllers.count) {
            _initTabIndex = self.viewControllers.count - 1;
        }
    }
    return self;
}

#pragma mark - public

- (void)addViewController:(nonnull UIViewController *)viewController {
    [self addViewController:viewController atIndex:self.viewControllers.count];
}

- (void)addViewController:(nonnull UIViewController *)viewController atIndex:(NSUInteger)tabIndex {
    if ([self isViewLoaded]) {
        
    }
    else {
        NSMutableArray <UIViewController *> *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
        [viewControllers insertObject:viewController atIndex:tabIndex];
    }
}

- (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated {
    
    
    _selectedTabIndex = tabIndex;
    [self.contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.contentScrollView.bounds) * tabIndex, 0) animated:animated];
}

#pragma mark - subviews

- (void)configureSubviews {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.slideTabView];
    [self.view addSubview:self.contentScrollView];
    
    [self.view bringSubviewToFront:self.slideTabView];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (UIView<SPSlideTabBarProtocol> *)slideTabView {
    if (!_slideTabView) {
        
        NSMutableArray <SPSlideTabBarItem *> *slideTabBarItems = [NSMutableArray array];
        [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
            [slideTabBarItems addObject:viewController.slideTabBarItem];
        }];
        
        _slideTabView = [[SPFixedSlideTabBar alloc] initWithTabBarItems:slideTabBarItems];;
        [_slideTabView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), _slideTabView.intrinsicContentSize.height)];
        [_slideTabView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    }
    return _slideTabView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        [_contentScrollView setPagingEnabled:YES];;
        [_contentScrollView setDelegate:self];
        [_contentScrollView setShowsHorizontalScrollIndicator:NO];
        [_contentScrollView setShowsVerticalScrollIndicator:NO];
        [_contentScrollView setFrame:CGRectMake(0, CGRectGetMaxY(self.slideTabView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.slideTabView.frame))];
        [_contentScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return _contentScrollView;
}

#pragma mark - life cycle

- (void)loadView {
    [super loadView];
    
    [self configureSubviews];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
        if ([self.viewControllers containsObject:viewController]) {
            if (![self.contentScrollView.subviews containsObject:viewController.view]) {
                [self.contentScrollView addSubview:viewController.view];
            }
        }
    }];
    
    if (self.initTabIndex < self.viewControllers.count) {
        UIViewController *shouldInitViewController = [self.viewControllers objectAtIndex:self.initTabIndex];
        if (![self.childViewControllers containsObject:shouldInitViewController]) {
            [self addViewControllerToContainer:shouldInitViewController];
            _selectedTabIndex = self.initTabIndex;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self childViewControllerAtIndex:self.selectedTabIndex willAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self childViewControllerAtIndex:self.selectedTabIndex didAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self childViewControllerAtIndex:self.selectedTabIndex willDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self childViewControllerAtIndex:self.selectedTabIndex didDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - content container

- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
    
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeMake(parentSize.width, parentSize.height - CGRectGetHeight(self.slideTabView.frame));
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinator> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {

    }];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
        if ([self.childViewControllers containsObject:viewController]) {
            [viewController viewWillTransitionToSize:CGSizeMake(size.width, size.height - CGRectGetHeight(self.slideTabView.frame)) withTransitionCoordinator:coordinator];
        }
    }];
}

#pragma mark - rotate for iOS7

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
}

#pragma mark -
#pragma mark - private
#pragma mark -

#pragma mark - appearance

- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}

- (void)childViewControllerAtIndex:(NSUInteger)index willAppear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        [viewController beginAppearanceTransition:YES animated:animated];
    }
}

- (void)childViewControllerAtIndex:(NSUInteger)index didAppear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        [viewController endAppearanceTransition];
    }
}

- (void)childViewControllerAtIndex:(NSUInteger)index willDisappear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        if ([self.childViewControllers containsObject:viewController]) {
            [viewController beginAppearanceTransition:NO animated:animated];
        }
    }
}

- (void)childViewControllerAtIndex:(NSUInteger)index didDisappear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        if ([self.childViewControllers containsObject:viewController]) {
            [viewController endAppearanceTransition];
        }
    }
}

#pragma mark - child controller

- (void)makeViewControllerVisibleAtIndex:(NSUInteger)index {
    
    if (index >= self.viewControllers.count) {
        return;
    }
    
    NSUInteger currentIndex = self.selectedTabIndex;
    
    if (currentIndex != index) {
        [self childViewControllerAtIndex:currentIndex willDisappear:NO];
    }
    [self childViewControllerAtIndex:index willAppear:NO];
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    if (![self.childViewControllers containsObject:viewController]) {
        [self addViewControllerToContainer:viewController];
    }
    
    if (currentIndex != index) {
        [self childViewControllerAtIndex:currentIndex didDisappear:NO];
    }
    [self childViewControllerAtIndex:index didAppear:NO];
}

- (void)addViewControllerToContainer:(UIViewController *)viewController {

    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [self.contentScrollView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

@end


#import <objc/runtime.h>
#import "SPSlideTabBarItem.h"

@implementation UIViewController (SPSlideTabBarItem)

@dynamic slideTabBarItem;

- (SPSlideTabBarItem *)slideTabBarItem {
    SPSlideTabBarItem *tabBarItem = objc_getAssociatedObject(self, @selector(slideTabBarItem));
    if (tabBarItem == nil) {
        tabBarItem = [[SPSlideTabBarItem alloc] initWithTitle:self.title];
    }
    return tabBarItem;
}

- (void)setSlideTabBarItem:(SPSlideTabBarItem *)slideTabBarItem {
    objc_setAssociatedObject(self, @selector(setSlideTabBarItem:), slideTabBarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SPSlideTabBarController *)slideTabBarController {
    UIViewController *parentViewController = self.parentViewController;
    if (parentViewController && [parentViewController isKindOfClass:[SPSlideTabBarController class]]) {
        return (SPSlideTabBarController *)parentViewController;
    }
    return nil;
}

@end
