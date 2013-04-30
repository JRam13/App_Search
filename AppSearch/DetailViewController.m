//
//  DetailViewController.m
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

-(void)displayDetails
{
    //NSLog(@"%@", _detailTitle);
    self.detailTitleLabel.text = self.detailTitle;
    self.detailAuthorLabel.text = self.detailAuthor;
    self.detailPriceLabel.text = self.detailPrice;
    [[self detailImage]setImage:self.detailImageBig];
    [[self detailRanking]setImage:self.detailImageRating];
    self.detailDescriptionText.text = self.detailDescription;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dismissBTN:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addToFavorites:(UIButton *)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    //Entity
    NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Apps" inManagedObjectContext:appDelegate.managedObjectContext];
    [entity setValue:self.detailTitle forKey:@"title"];
    [entity setValue:self.detailAuthor forKey:@"author"];
    NSData *imageData = UIImagePNGRepresentation(self.detailImageRating);
    [entity setValue:imageData forKey:@"rating"];
    imageData = UIImagePNGRepresentation(self.detailImageBig);
    [entity setValue:imageData forKey:@"image"];
    
    NSError *error;
    BOOL isSaved = [appDelegate.managedObjectContext save:&error];
    NSLog(@"Successfully saved flag %d", isSaved);
    
                                   
}

@end
