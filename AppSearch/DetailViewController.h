//
//  DetailViewController.h
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@protocol ModalDelegate <NSObject>

- (void)detailsViewDidDismiss: (DetailViewController*)dvc;

@end

@interface DetailViewController : UIViewController
- (IBAction)dismissBTN:(UIButton *)sender;

@property (nonatomic, weak) id <ModalDelegate> delegate;

@property (weak, nonatomic) NSString * detailTitle;
@property (weak, nonatomic) NSString * detailAuthor;
@property (weak, nonatomic) NSString * detailPrice;
@property (weak, nonatomic) NSString * detailDescription;
@property (weak, nonatomic) UIImage * detailImageBig;
@property (weak, nonatomic) UIImage * detailImageRating;

@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UIImageView *detailRanking;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAuthorLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailPriceLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailDescriptionText;

- (IBAction)addToFavorites:(UIButton *)sender;
-(void)displayDetails;


@end
