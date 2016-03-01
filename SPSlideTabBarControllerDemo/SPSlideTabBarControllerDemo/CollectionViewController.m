//
//  CollectionViewController.m
//  SPSlideTabBarControllerDemo
//
//  Created by Jiangwei Wu on 16/3/1.
//  Copyright © 2016年 aokizen. All rights reserved.
//

#import "CollectionViewController.h"

static NSString *collectionViewCellIdentifier = @"collectionViewCellIdentifier";

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    layout.itemSize = CGSizeMake(84, 84);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 4;
    [layout invalidateLayout];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectionViewCellIdentifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 60;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
    [cell setBackgroundColor:[[UIColor yellowColor] colorWithAlphaComponent:0.7]];
    return cell;
}

@end
