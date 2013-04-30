//
//  SearchViewController.m
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchCell.h"
#import "SearchHeader.h"
#import "FetchSearchResults.h"
#import "DetailViewController.h"

@interface SearchViewController ()
{
    SearchHeader *headerView;
    NSString * searchQuery;
    FetchSearchResults * searchResults;
    NSTimer *_timer;
    
    //Current App to select
    NSString * currTitle;
    NSString * currAuthor;
    NSString * currPrice;
    NSObject * currImage;
    NSObject * currImageRating;
    
    DetailViewController *dvc2;
    
}

@end

@implementation SearchViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self searchCollectionView]setDelegate:self];
    [[self searchCollectionView]setDataSource:self];
    
    _searchTitleLabels = [[NSMutableArray alloc] init];
    _searchAuthorLabels = [[NSMutableArray alloc] init];
    _searchPriceLabels = [[NSMutableArray alloc] init];
    _searchImages = [[NSMutableArray alloc] init];
    _searchRatingsImages = [[NSMutableArray alloc] init];
    _searchRatingsInt = [[NSMutableArray alloc] init];
    _description = [[NSMutableArray alloc] init];
    _buyLink = [[NSMutableArray alloc]init];
    
    searchResults = [FetchSearchResults sharedInstance];
    _timer = [NSTimer scheduledTimerWithTimeInterval:.2f
                                              target:self
                                            selector:@selector(reload)
                                            userInfo:nil
                                             repeats:YES];

}

-(void)reload
{
    if([searchResults.arrayOfTitles count] == 50){
        [_timer invalidate];
    }
    
    _searchTitleLabels = searchResults.arrayOfTitles;
    _searchAuthorLabels = searchResults.arrayOfAuthors;
    _searchPriceLabels = searchResults.arrayOfPrices;
    _searchImages = searchResults.arrayOfImages;
    _searchRatingsImages = searchResults.arrayOfRatings;
    _searchRatingsInt = searchResults.arrayOfRatingsInt;
    _description = searchResults.arrayOfDescriptions;
    _buyLink = searchResults.arrayOfBuyLinks;

    
    [self.searchCollectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [searchResults.arrayOfTitles count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"appsLabel count: %d", [_appsLabels count]);
    //NSLog(@"ArrayofTitles count: %d", [appData.arrayOfTitles count]);
    

    static NSString *CellIndentifier = @"SearchCell";
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIndentifier forIndexPath:indexPath];
    [[cell searchTitleLabel]setText:[_searchTitleLabels objectAtIndex:indexPath.item]];
    [[cell searchAuthorLabel]setText:[_searchAuthorLabels objectAtIndex:indexPath.item]];
    [[cell searchPriceLabel]setText:[_searchPriceLabels objectAtIndex:indexPath.item]];
    [[cell searchImage]setImage:[_searchImages objectAtIndex:indexPath.item]];
    [[cell searchRatingsImage]setImage:[_searchRatingsImages objectAtIndex:indexPath.item]];
        

    return cell;
}

- (UICollectionReusableView *)collectionView:
(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                          UICollectionElementKindSectionHeader withReuseIdentifier:@"SearchHeader" forIndexPath:indexPath];
        
    headerView.searchHeaderLabel.text = searchQuery;
    //NSLog(@"IndexPAth: %d", indexPath.section);
    //NSLog(@"Header Ran");
    
    return headerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    
    
    searchQuery = searchBar.text;
    searchResults.passURL = searchQuery;
    NSLog(@"search button clicked");
    //[searchResults runQuery];
    
    
    [[headerView SearchStarImageLeft]setImage:[UIImage imageNamed:@"star.png"]];
    [[headerView SearchStarImageRight]setImage:[UIImage imageNamed:@"star.png"]];
    
    [searchBar resignFirstResponder];
    
    
    UIAlertView *sortByAlert;
    
    sortByAlert = [[UIAlertView alloc] initWithTitle:nil message:@"Sort By" delegate:self cancelButtonTitle:@"Author" otherButtonTitles:@"Rating", nil];
    
    
    [sortByAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [searchResults.arrayOfTitles removeAllObjects];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:.2f
                                              target:self
                                            selector:@selector(reload)
                                            userInfo:nil
                                             repeats:YES];
    
    
    if (buttonIndex == 0) {
        
        searchResults.sortByAuthor = YES;
        searchResults.sortByRating = NO;
        
    }
    else{
        searchResults.sortByRating = YES;
        searchResults.sortByAuthor = NO;
    }
    
    [searchResults runQuery];
    [self reload];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    dvc2.detailTitle = [_searchTitleLabels objectAtIndex:indexPath.item];
    dvc2.detailAuthor = [_searchAuthorLabels objectAtIndex:indexPath.item];
    dvc2.detailPrice = [_searchPriceLabels objectAtIndex:indexPath.item];
    dvc2.detailImageBig = [_searchImages objectAtIndex:indexPath.item];
    dvc2.detailImageRating = [_searchRatingsImages objectAtIndex:indexPath.item];
    dvc2.detailDescription = [_description objectAtIndex:indexPath.item];
    dvc2.detailBuyLink = [_buyLink objectAtIndex:indexPath.item];
    [dvc2 displayDetails];
    

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segueDetail"]){
        dvc2 = (DetailViewController*)segue.destinationViewController;
    
    }
}

- (void)detailsViewDidDismiss: (DetailViewController*)dvc
{
    //[self dismissViewControllerAnimated:YES completion:NULL];
    
}



@end

