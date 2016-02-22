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
    
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    [tableViewController setTitle:@"table"];
    UICollectionViewController *collectionViewController = [[UICollectionViewController alloc] init];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
