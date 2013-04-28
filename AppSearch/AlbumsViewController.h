//
//  AlbumsViewController.h
//  AppSearch
//
//  Created by JRamos on 4/27/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *AlbumsCollectionView;
@property (strong, nonatomic) NSMutableArray *albumLabels;
@property (strong, nonatomic) NSMutableArray *albumLabelsImage;

@end
