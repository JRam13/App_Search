//
//  SearchHeader.h
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHeader : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *SearchStarImageRight;
@property (weak, nonatomic) IBOutlet UIImageView *SearchStarImageLeft;
@property (weak, nonatomic) IBOutlet UILabel *searchHeaderLabel;

@end
