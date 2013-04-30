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

- (IBAction)purchaseBtn:(UIButton *)sender {
    
    NSLog(@"URL: %@", self.detailBuyLink);
    
    UIAlertView *buyLinkAlert;
    
    buyLinkAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Go to the App store?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    
    [buyLinkAlert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        
        
        if (TARGET_IPHONE_SIMULATOR){
        alertView = [[UIAlertView alloc] initWithTitle:nil message:@"NOTE: iTunes App Store is not supported on the iOS simulator. Unable to open App Store page." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertView show];
        }
        
        else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.detailBuyLink]];
        }
        
    }


   
}

@end
