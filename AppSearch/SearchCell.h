//
//  SearchCell.h
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *searchTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchImage;
@property (weak, nonatomic) IBOutlet UILabel *searchAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *searchRatingsImage;

@end
