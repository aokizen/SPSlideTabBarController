# SPSlideTabViewController

A TabBarController with top TabBar and slide content view.

-----

## Usage

1. SPSlideTabBarController

  - initialize

    ```objc
    TableViewController *tableViewController = [[TableViewController alloc] init];
    [tableViewController setTitle:@"table"];

    CollectionViewController *collectionViewController = [[CollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    [collectionViewController setTitle:@"collection"];

    ScrollViewController *scrollViewController = [[ScrollViewController alloc] init];
    [scrollViewController setTitle:@"scroll"];

    ViewController *viewController = [[ViewController alloc] init];
    [viewController setTitle:@"general"];

    SPSlideTabBarController *slideTabBarController = [[SPSlideTabBarController alloc] initWithViewController:@[tableViewController, collectionViewController, scrollViewController, viewController] initTabIndex:2];
    ```

  - selected a tab

    ```objc
    - (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated；
    ```

  - add a UIViewController

    ```objc
    /**
     * add a viewController to the slideTabBarController
     *
     * 为当前的 slideTabBarController 增加一个 viewController
     *
     * @discussion the viewController and the tab bar item will be added at the last index by default.
     * @discussion 待加入的 viewController 和 tab bar item 会被默认加到最后一个
     */
    - (void)addViewController:(nonnull UIViewController *)viewController;

    /**
     * add a viewController to the slideTabBarController at the index
     *
     * 为当前的 slideTabBarController 增加一个 viewController，添加到 index 的位置
     */
    - (void)addViewController:(nonnull UIViewController *)viewController atIndex:(NSUInteger)tabIndex;
    ```

2. custom a slide tab bar

  a easy way to define a custom slide tab bar is to define a view which follows the protocol `SPSlideTabBarProtocol`.

  There are two defined custom slide tab bar already.

  - `SPFixedSlideTabBar`

    ```objc
    /**
     * a custom slide tab bar whose tabs' width is fixed which is depend on the slide tab bar's width.
     *    
     * 一个定制的 slide tab bar. 所有 tab 都是固定宽度的，具体宽度是多少是根据 tab bar 的宽度来均分计算的。
     */
    @interface SPFixedSlideTabBar : UIView <SPSlideTabBarProtocol>
    @end
    ```

  - `SPSizingSlideTabBar`

    ```objc
    /**
     * a custom slide tab bar whose tabs' width is depend on the content size of the tab.
     *
     * 一个定制的 slide tab bar. 所有 tab 的宽度都是根据 tab 的内容来自适应的。
     */
    @interface SPSizingSlideTabBar : SPFixedSlideTabBar
    @end
    ```

3. style slide tab bar item

  ```objc
  [[SPSlideTabBarItem appearance] setBarItemSelectedTextColor:[UIColor blueColor]];
  ```

-----

## The screenshots for demo

![demo]<./SPSlideTabBarControllerDemo/screenshots/demo.gif>

![1]<./SPSlideTabBarControllerDemo/screenshots/1.png>

![2]<./SPSlideTabBarControllerDemo/screenshots/2.png>

![3]<./SPSlideTabBarControllerDemo/screenshots/3.png>
