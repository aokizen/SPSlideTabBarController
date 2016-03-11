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

- (void)_resizeScrollViewContentSizeWithScrollBoundsSize:(CGSize)size;

@end

@implementation SPSlideTabBarController (ViewControllers)

/**
 * add a viewController to the slideTabBarController
 *
 * 为当前的 slideTabBarController 增加一个 viewController
 *
 * @discussion the viewController and the tab bar item will be added at the last index by default.
 * @discussion 待加入的 viewController 和 tab bar item 会被默认加到最后一个
 */
- (void)addViewController:(nonnull UIViewController *)viewController {
    [self addViewController:viewController atIndex:self.viewControllers.count];
}

/**
 * add a viewController to the slideTabBarController at the index
 *
 * 为当前的 slideTabBarController 增加一个 viewController，添加到 index 的位置
 */
- (void)addViewController:(nonnull UIViewController *)viewController atIndex:(NSUInteger)tabIndex {
    
    NSUInteger index = tabIndex;
    if (index > self.viewControllers.count) {
        index = self.viewControllers.count;
    }
    
    NSMutableArray <UIViewController *> *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
    [viewControllers insertObject:viewController atIndex:index];
    self.viewControllers = viewControllers;
    
    if (self.slideTabView != nil) {
        [self.slideTabView insertTabBarItem:viewController.slideTabBarItem atIndex:index];
    }
    
    if ([self isViewLoaded]) {
        
    }
}

- (void)_childViewControllerAtIndex:(NSUInteger)index willAppear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        [viewController beginAppearanceTransition:YES animated:animated];
    }
}

- (void)_childViewControllerAtIndex:(NSUInteger)index didAppear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        [viewController endAppearanceTransition];
    }
}

- (void)_childViewControllerAtIndex:(NSUInteger)index willDisappear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        if ([self.childViewControllers containsObject:viewController]) {
            [viewController beginAppearanceTransition:NO animated:animated];
        }
    }
}

- (void)_childViewControllerAtIndex:(NSUInteger)index didDisappear:(BOOL)animated {
    if (index < self.viewControllers.count) {
        UIViewController *viewController = [self.viewControllers objectAtIndex:index];
        if ([self.childViewControllers containsObject:viewController]) {
            [viewController endAppearanceTransition];
        }
    }
}

#pragma mark - child controller

/**
 * make the view controller at index visible
 *
 * 让一个在 index 位置上的 viewController 显示出来
 *
 * @discussion make the previous viewController disappear and the current viewCotnroller appear.
 * @discussion 让之前的 viewController disappear, 并且让当前的 viewController appear.
 */
- (void)_makeViewControllerVisibleAtIndex:(NSUInteger)index {
    
    if (index >= self.viewControllers.count) {
        return;
    }
    
    NSUInteger currentIndex = self.selectedTabIndex;
    
    if (currentIndex != index) {
        [self _childViewControllerAtIndex:currentIndex willDisappear:NO];
    }
    [self _childViewControllerAtIndex:index willAppear:NO];
    
    UIViewController *viewController = [self.viewControllers objectAtIndex:index];
    if (![self.childViewControllers containsObject:viewController]) {
        [self _addViewControllerToContainer:viewController];
        [self _resizeScrollViewContentSizeWithScrollBoundsSize:self.contentScrollView.bounds.size];
    }
    
    if (currentIndex != index) {
        [self _childViewControllerAtIndex:currentIndex didDisappear:NO];
    }
    [self _childViewControllerAtIndex:index didAppear:NO];
}

/**
 * add a viewController to the container in the SPSlideTabBarController
 *
 * 将一个 viewController 添加到 SPSlideTabBarController 的容器内
 */
- (void)_addViewControllerToContainer:(UIViewController *)viewController {
    
    [viewController willMoveToParentViewController:self];
    [self addChildViewController:viewController];
    [viewController.view setFrame:self.contentScrollView.bounds];
    [self.contentScrollView addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

@end


@implementation SPSlideTabBarController

#pragma mark - initialize 

- (instancetype)init {
    self = [super init];
    if (self) {
        _isFirstLoading = YES;
    }
    return self;
}

/**
 * 初始化方法
 *
 * @param viewControllers all viewControllers for all scroll page
 * @param viewControllers 所有滑动页面的 viewController
 */
- (nonnull instancetype)initWithViewController:(nonnull NSArray<UIViewController *> *)viewControllers {
    self = [self init];
    if (self) {
        _viewControllers = viewControllers;
        
        _initTabIndex = 0;
    }
    return self;
}

/**
 * 初始化方法
 *
 * @param viewControllers all viewControllers for all scroll page
 * @param viewControllers 所有滑动页面的 viewController
 *
 * @param initTabIndex the selected tab index at the initialized time
 * @param initTabIndex 初始化的时候选中的 tab index
 */
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

#pragma mark - subviews

/**
 * initialize and configure all subviews
 *
 * 初始化和配置所有的子视图
 */
- (void)_configureSubviews {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self configureSlideTabView];
    [self.view addSubview:self.slideTabView];
    
    [self _configureContentScrollView];
    [self.view addSubview:self.contentScrollView];
    
    [self.view bringSubviewToFront:self.slideTabView];
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

/**
 * intialize and configure the content scrollView
 *
 * 初始化和配置内容滑动界面
 */
- (void)_configureContentScrollView {
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
    
    [self _configureSubviews];
    
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
            [self _addViewControllerToContainer:shouldInitViewController];
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
    
    [self _childViewControllerAtIndex:self.selectedTabIndex willAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self _childViewControllerAtIndex:self.selectedTabIndex didAppear:animated];
    
    [self selectTabIndex:self.selectedTabIndex animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self _childViewControllerAtIndex:self.selectedTabIndex willDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self _childViewControllerAtIndex:self.selectedTabIndex didDisappear:animated];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self _resizeScrollViewContentSizeWithScrollBoundsSize:self.contentScrollView.bounds.size];
}

#pragma mark - content container

//- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    return CGSizeMake(parentSize.width, parentSize.height - CGRectGetHeight(self.slideTabView.frame));
//}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinator> context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [self _resizeScrollViewContentSizeWithScrollBoundsSize:CGSizeMake(size.width, size.height - CGRectGetHeight(self.slideTabView.frame))];
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
    [self _resizeScrollViewContentSizeWithScrollBoundsSize:self.contentScrollView.bounds.size];
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
    [self _makeViewControllerVisibleAtIndex:page];
    
    _selectedTabIndex = page;
    
    [self didScrollToTabIndex:page];
}


#pragma mark - SPSlideTabBarDelegate

/**
 * tell the delegate the the slide tab bar did select the tab of `index`.
 *
 * slide tab bar 通知代理已经选择了某一个 index 的 tab
 */
- (void)slideTabBar:(UIView<SPSlideTabBarProtocol> *)slideTabBar didSelectIndex:(NSUInteger)index {
    
    [self.contentScrollView sp_scrollToPage:index];
    [self _makeViewControllerVisibleAtIndex:index];
    _selectedTabIndex = index;
    
    [self didScrollToTabIndex:index];
}

#pragma mark -
#pragma mark - private
#pragma mark -

#pragma mark - size

/**
 * resize scroll view content size and the page view controller frame with the scroll bounds size
 *
 * 根据 scrollView 的 bounds size 来重新设置 scrollView 的 contentSize 和所有 viewController 的 view frame
 */
- (void)_resizeScrollViewContentSizeWithScrollBoundsSize:(CGSize)size {
    
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

@end

@implementation SPSlideTabBarController (SPSlideTabBar)

/**
 * initialize the slide tab view
 *
 * 初始化 slide tab bar 视图
 */
- (void)configureSlideTabView {
    
    if (self.slideTabView == nil) {
        NSMutableArray <SPSlideTabBarItem *> *slideTabBarItems = [NSMutableArray array];
        [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger index, BOOL *stop) {
            [slideTabBarItems addObject:viewController.slideTabBarItem];
        }];
        self.slideTabView = [[SPFixedSlideTabBar alloc] initWithTabBarItems:slideTabBarItems];
    }
    [self.slideTabView setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), self.slideTabView.intrinsicContentSize.height)];
    [self.slideTabView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth];
    [((SPFixedSlideTabBar *)self.slideTabView) setDelegate:self];
}

/**
 * call the controller to select tab index
 *
 * 调用这个方法来选择某一个 tab
 */
- (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated {
    [self.slideTabView selectTabAtIndex:tabIndex];
    _selectedTabIndex = tabIndex;
    [self.contentScrollView setContentOffset:CGPointMake(CGRectGetWidth(self.contentScrollView.bounds) * tabIndex, 0) animated:animated];
}

#pragma mark - did scroll

/**
 * notify that the controller did scroll to tab of `index`
 *
 * 用于标识 controller 以及滑动到某一个 index 的 tab
 *
 * @discussion no concrete implementation. this method is only for override.
 * @discussion 没有具体的实现，这个方法仅为继承提供的
 */
- (void)didScrollToTabIndex:(NSUInteger)tabIndex {
    
}

@end

#import <objc/runtime.h>
#import "SPSlideTabBarItem.h"

@implementation UIViewController (SPSlideTabBarItem)

@dynamic slideTabBarItem;

/**
 * get the slide tab bar item for a viewController
 *
 * 获取一个 viewController 的 slide tab bar item
 */
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

/**
 * get the slideTabBarController for a viewController; if none, return nil
 *
 * 获取一个 viewController 的 slideTabBarController； 如果不存在，则返回nil
 */
- (SPSlideTabBarController *)slideTabBarController {
    UIViewController *parentViewController = self.parentViewController;
    if (parentViewController && [parentViewController isKindOfClass:[SPSlideTabBarController class]]) {
        return (SPSlideTabBarController *)parentViewController;
    }
    return nil;
}

@end
