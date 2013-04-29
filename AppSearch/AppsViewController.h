//
//  AppsViewController.h
//  AppSearch
//
//  Created by JRamos on 4/26/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppsViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *AppsCollectionView;
@property (strong, nonatomic) NSMutableArray *appsLabels;
@property (strong, nonatomic) NSMutableArray *appsButtonImages;

@end
