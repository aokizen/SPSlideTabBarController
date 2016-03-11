# SPSlideTabViewController

A TabBarController with top TabBar and slide content view.

------

## Usage

1. SPSlideTabBarController

  - initialize

  ```Objecitve-C

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

  ```Objecitve-C
  - (void)selectTabIndex:(NSUInteger)tabIndex animated:(BOOL)animated；
  ```

  - add a UIViewController

  ```Objecitve-C
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

a easy way to define a custom slide tab bar is to define a view which respond to the protocol `SPSlideTabBarProtocol`

3. style slide tab bar item

```objc
[[SPSlideTabBarItem appearance] setBarItemSelectedTextColor:[UIColor blueColor]];
```
