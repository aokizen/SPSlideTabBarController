//
//  TableViewController.m
//  SPSlideTabBarControllerDemo
//
//  Created by Jiangwei Wu on 16/3/1.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "TableViewController.h"

#import "HomeViewController.h"
#import "ViewController.h"

@implementation TableViewController

- (BOOL)hasContainerNavigationController {
    return ([self containerNavigationController] != nil);
}

- (UINavigationController *)containerNavigationController {
    if (self.navigationController) {
        return self.navigationController;
    }
    else if (self.slideTabBarController) {
        return self.slideTabBarController.navigationController;
    }
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"section : %d", (int)section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && [self hasContainerNavigationController]) {
        return 6;
    }
    else {
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
    }
    
    if (indexPath.section == 0 && [self hasContainerNavigationController]) {
        switch (indexPath.row) {
            case 0:
                [cell.textLabel setText:@"push a new home view controller"];
                break;
            case 1:
                [cell.textLabel setText:@"push a last tab selected home view controller"];
                break;
            case 2:
                [cell.textLabel setText:@"push a sizing tab home view controller"];
                break;
            case 3:
                [cell.textLabel setText:@"push a last sizing tab selected home view controller"];
                break;
            case 4:
                [cell.textLabel setText:@"add a new view controller"];
                break;
            case 5:
                [cell.textLabel setText:@"add a new view controller at index 2"];
                break;
                
            default:
                break;
        }
    }
    else {
        [cell.textLabel setText:[NSString stringWithFormat:@"%d:%d", (int)indexPath.section, (int)indexPath.row]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && [self hasContainerNavigationController]) {
        
        if (self.slideTabBarController == nil) {
            return;
        }
        
        UINavigationController *navController = [self containerNavigationController];
        
        switch (indexPath.row) {
            case 0:
            {
                HomeViewController *vc = [[HomeViewController alloc] initWithDefaultViewControllers];
                [navController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                HomeViewController *vc = [[HomeViewController alloc] initWithDefaultViewControllersAndInitialIndex:3];
                [navController pushViewController:vc animated:YES];
                break;
            }
            case 2:
            {
                HomeViewController *vc = [[HomeViewController alloc] initWithDefaultViewControllersAndSizingTabBar:YES];
                [navController pushViewController:vc animated:YES];
                break;
            }
            case 3:
            {
                HomeViewController *vc = [[HomeViewController alloc] initWithDefaultViewControllersAndSizingTabBar:YES initialIndex:3];
                [navController pushViewController:vc animated:YES];
                break;
            }
            case 4:
            {
                ViewController *controller = [[ViewController alloc] init];
                [controller setTitle:[NSString stringWithFormat:@"%d", (int)self.slideTabBarController.viewControllers.count + 1]];
                [self.slideTabBarController addViewController:controller];
                break;
            }
            case 5:
            {
                ViewController *controller = [[ViewController alloc] init];
                [controller setTitle:[NSString stringWithFormat:@"%d", (int)self.slideTabBarController.viewControllers.count + 1]];
                [self.slideTabBarController addViewController:controller atIndex:2];
                break;
            }
            default:
                break;
        }
    }
}

@end
