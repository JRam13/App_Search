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



@end
