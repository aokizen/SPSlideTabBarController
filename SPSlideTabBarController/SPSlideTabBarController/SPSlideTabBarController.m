//
//  SPSlideTabBarController.m
//  SPSlideTabBarController
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "SPSlideTabBarController.h"

@interface UIScrollView (SPSlidePage)

- (NSUInteger)sp_currentPage;
- (void)sp_scrollToPage:(NSUInteger)page;

@end

@implementation UIScrollView (SBScrollViewPage)

- (NSUInteger)sp_currentPage {
    return (NSUInteger)(self.contentOffset.x / CGRectGetWidth(self.frame));
}

- (void)sp_scrollToPage:(NSUInteger)page {
    CGFloat offsetX = CGRectGetWidth(self.frame) * (CGFloat)page;
    CGPoint currentOffset = self.contentOffset;
    [self setContentOffset:CGPointMake(offsetX, currentOffset.y) animated:YES];
}

@end


#import "SPSlideTabBar.h"

@interface SPSlideTabBarController () <UIScrollViewDelegate, SPSlideTabBarDelegate> {
    BOOL _isFirstLoading;
}

@property (assign, nonatomic) NSUInteger initTabIndex;

@end

@implementation SPSlideTabBarController

@synthesize contentScrollView = _contentScrollView;

#pragma mark - initialize 

- (instancetype)init {
    self = [super init];
    if (self) {
        _isFirstLoading = YES;
    }
    return self;
}

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
        self.viewControllers = viewControllers;
    }
}

- (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated {
    [self.slideTabView selectTabAtIndex:tabIndex];
    _selectedTabIndex = tabIndex;
    [self.contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.contentScrollView.bounds) * tabIndex, 0) animated:animated];
}

#pragma mark - did scroll

/**
 for override
 */
- (void)didScrollToTabIndex:(NSUInteger)tabIndex {
    
}

#pragma mark - subviews

- (void)configureSubviews {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self configureSlideTabView];
    [self.view addSubview:self.slideTabView];
    
    [self configureContentScrollView];
    [self.view addSubview:self.contentScrollView];
    
    [self.view bringSubviewToFront:self.slideTabView];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)configureSlideTabView {
    
    NSMutableArray <SPSlideTabBarItem *> *slideTabBarItems = [NSMutableArray array];
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
        [slideTabBarItems addObject:viewController.slideTabBarItem];
    }];
    
    _slideTabView = [[SPFixedSlideTabBar alloc] initWithTabBarItems:slideTabBarItems];;
    [self.slideTabView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.slideTabView.intrinsicContentSize.height)];
    [self.slideTabView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    [((SPFixedSlideTabBar *)self.slideTabView) setDelegate:self];
}

- (void)configureContentScrollView {
    _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.contentScrollView setScrollEnabled:YES];
    [self.contentScrollView setPagingEnabled:YES];
    [self.contentScrollView setDirectionalLockEnabled:YES];
    
    [self.contentScrollView setDelegate:self];
    [self.contentScrollView setShowsHorizontalScrollIndicator:NO];
    [self.contentScrollView setShowsVerticalScrollIndicator:NO];
    [self.contentScrollView setFrame:CGRectMake(0, CGRectGetMaxY(self.slideTabView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(self.slideTabView.frame))];
    [self.contentScrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
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
            
            [self.slideTabView selectTabAtIndex:_selectedTabIndex];
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
    
    [self resizeScrollViewContentSizeWithScrollBoundsSize:self.contentScrollView.bounds.size];
}

#pragma mark - content container

//- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    return CGSizeMake(parentSize.width, parentSize.height - CGRectGetHeight(self.slideTabView.frame));
//}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinator> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self resizeScrollViewContentSizeWithScrollBoundsSize:CGSizeMake(size.width, size.height - CGRectGetHeight(self.slideTabView.frame))];
        [self.contentScrollView sp_scrollToPage:self.selectedTabIndex];
    }];
    
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
        if ([self.childViewControllers containsObject:viewController]) {
            [viewController viewWillTransitionToSize:CGSizeMake(size.width, size.height - CGRectGetHeight(self.slideTabView.frame)) withTransitionCoordinator:coordinator];
        }
    }];
}

#pragma mark - rotate for iOS7

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self resizeScrollViewContentSizeWithScrollBoundsSize:self.contentScrollView.bounds.size];
    [self.contentScrollView sp_scrollToPage:self.selectedTabIndex];
    
    
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.slideTabView fixIndicatorWithScrollOffset:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSUInteger page = self.contentScrollView.sp_currentPage;
    [self.slideTabView selectTabAtIndex:page];
    [self makeViewControllerVisibleAtIndex:page];
    
    _selectedTabIndex = page;
    
    [self didScrollToTabIndex:page];
}


#pragma mark - SPSlideTabBarDelegate

- (void)slideTabBar:(UIView<SPSlideTabBarProtocol> *)slideTabBar didSelectIndex:(NSUInteger)index {
    
    [self.contentScrollView sp_scrollToPage:index];
    [self makeViewControllerVisibleAtIndex:index];
    _selectedTabIndex = index;
    
    [self didScrollToTabIndex:index];
}

#pragma mark -
#pragma mark - private
#pragma mark -

#pragma mark - size

- (void)resizeScrollViewContentSizeWithScrollBoundsSize:(CGSize)size {
    
    self.contentScrollView.contentSize = CGSizeMake(size.width * self.viewControllers.count, size.height);
    
    for (NSUInteger index = 0; index < self.viewControllers.count; index ++) {
        UIViewController *controller = [self.viewControllers objectAtIndex:index];
        if ([self.childViewControllers containsObject:controller]) {
            controller.view.frame = CGRectMake(size.width * (CGFloat)index, 0, size.width, size.height);
        }
    }
}

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
        [self resizeScrollViewContentSizeWithScrollBoundsSize:self.contentScrollView.bounds.size];
    }
    
    if (currentIndex != index) {
        [self childViewControllerAtIndex:currentIndex didDisappear:NO];
    }
    [self childViewControllerAtIndex:index didAppear:NO];
}

- (void)addViewControllerToContainer:(UIViewController *)viewController {

    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [viewController.view setFrame:self.contentScrollView.bounds];
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
