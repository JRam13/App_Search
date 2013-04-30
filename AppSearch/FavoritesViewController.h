//
//  FavoritesViewController.h
//  AppSearch
//
//  Created by JRamos on 4/29/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *favoritesCollectionView;

@property (strong, nonatomic) NSMutableArray *favoriteTitles;
@property (strong, nonatomic) NSMutableArray *favoriteAuthors;
@property (strong, nonatomic) NSMutableArray *favoritePrices;
@property (strong, nonatomic) NSMutableArray *favoriteImages;
@property (strong, nonatomic) NSMutableArray *favoriteImageRatings;

@end
