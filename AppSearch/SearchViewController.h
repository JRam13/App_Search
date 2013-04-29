//
//  SearchViewController.h
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface SearchViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, ModalDelegate>
{
    DetailViewController *dvc;
}


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *searchCollectionView;

@property (strong, nonatomic) NSMutableArray *searchTitleLabels;
@property (strong, nonatomic) NSMutableArray *searchAuthorLabels;
@property (strong, nonatomic) NSMutableArray *searchPriceLabels;
@property (strong, nonatomic) NSMutableArray *searchImages;
@property (strong, nonatomic) NSMutableArray *searchRatingsImages;
@property (strong, nonatomic) NSMutableArray *searchRatingsInt;




@end
