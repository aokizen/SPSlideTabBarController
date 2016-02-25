//
//  HomeViewController.m
//  SPSlideTabBarControllerDemo
//
//  Created by Spring on 16/2/22.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (instancetype)initWithDefaultViewControllers {
    
    UIViewController *tableViewController = [[UIViewController alloc] init];
    [tableViewController setTitle:@"table"];
    
    UIViewController *collectionViewController = [[UIViewController alloc] init];
    [collectionViewController setTitle:@"collection"];
    
    UIViewController *scrollViewController = [[UIViewController alloc] init];
    [scrollViewController setTitle:@"scroll"];
    
    
    UIViewController *viewController = [[UIViewController alloc] init];
    [viewController setTitle:@"general"];
    
    self = [self initWithViewController:@[viewController, scrollViewController, tableViewController, collectionViewController]];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.slideTabView setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
    
    [self.viewControllers.firstObject.view setBackgroundColor:[UIColor colorWithWhite:0.7 alpha:1]];
    [[self.viewControllers objectAtIndex:1].view setBackgroundColor:[UIColor whiteColor]];
    [[self.viewControllers objectAtIndex:2].view setBackgroundColor:[UIColor yellowColor]];
    [[self.viewControllers lastObject].view setBackgroundColor:[UIColor orangeColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)hidesBottomBarWhenPushed {
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
