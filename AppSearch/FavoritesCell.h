//
//  FavoritesCell.h
//  AppSearch
//
//  Created by JRamos on 4/29/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoritesCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *favoriteAuthor;
@property (weak, nonatomic) IBOutlet UILabel *favoriteTitle;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteRating;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;

@end
