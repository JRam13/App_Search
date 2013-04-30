//
//  FavoritesViewController.m
//  AppSearch
//
//  Created by JRamos on 4/29/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "FavoritesViewController.h"
#import "AppDelegate.h"
#import "FavoritesCell.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self favoritesCollectionView]setDelegate:self];
    [[self favoritesCollectionView]setDataSource:self];
    
    _favoriteTitles = [[NSMutableArray alloc] init];
    _favoriteAuthors = [[NSMutableArray alloc] init];
    _favoriteImageRatings = [[NSMutableArray alloc] init];
    _favoriteImages = [[NSMutableArray alloc] init];
    
    
    [self fetchData];
        
    //_albumLabelsImage = [[NSMutableArray alloc] init];
    //_albumButtonImages = [[NSMutableArray alloc]init];
    //appData = [FetchAlbumData sharedInstance];
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:.2f
//                                              target:self
//                                            selector:@selector(reload)
//                                            userInfo:nil
//                                             repeats:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    //NSLog(@"Draw Stuff here");
    [self fetchData];
}

-(void)fetchData
{
    NSLog(@"Fetching Favorites from Core Data");
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    
    //create entoty object
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Apps" inManagedObjectContext:appDelegate.managedObjectContext];
    
    //create fetch request
    NSFetchRequest *fetchReq = [[NSFetchRequest alloc]init];
    [fetchReq setEntity:entity];
    
    //Get all rows
    NSMutableArray *array = [[appDelegate.managedObjectContext executeFetchRequest:fetchReq error:nil] mutableCopy];
    
    [_favoriteTitles removeAllObjects];
    [_favoriteAuthors removeAllObjects];
    [_favoriteImageRatings removeAllObjects];
    [_favoriteImages removeAllObjects];
    
    for(NSManagedObject *obj in array){
        //NSLog(@"Name: %@\n", [obj valueForKey:@"title"]);
        ///NSLog(@"Author: %@\n", [obj valueForKey:@"author"]);
        //NSLog(@"Rating: %@\n", [obj valueForKey:@"rating"]);
        //NSLog(@"Image: %@\n", [obj valueForKey:@"image"]);
        NSString *title = [obj valueForKey:@"title"];
        NSString *author = [obj valueForKey:@"author"];
        
        NSData *rating = [obj valueForKey:@"rating"];
        UIImage *ratingimage = [UIImage imageWithData:rating];
        
        NSData *dataImage = [obj valueForKey:@"image"];
        UIImage *image = [UIImage imageWithData:dataImage];
        [_favoriteTitles addObject:title];
        [_favoriteAuthors addObject:author];
        [_favoriteImageRatings addObject:ratingimage];
        [_favoriteImages addObject:image];
       // NSLog(@"Array name %@" , [_favoriteTitles lastObject]);
    }
    
    [self.favoritesCollectionView reloadData];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_favoriteTitles count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"appsLabel count: %d", [_appsLabels count]);
    //NSLog(@"ArrayofTitles count: %d", [appData.arrayOfTitles count]);
    
    
    static NSString *CellIndentifier = @"FavoriteCell";
    FavoritesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIndentifier forIndexPath:indexPath];
    [[cell favoriteTitle]setText:[_favoriteTitles objectAtIndex:indexPath.item]];
    [[cell favoriteAuthor]setText:[_favoriteAuthors objectAtIndex:indexPath.item]];
    [[cell favoriteRating]setImage:[_favoriteImageRatings objectAtIndex:indexPath.item]];
    [[cell favoriteImage]setImage:[_favoriteImages objectAtIndex:indexPath.item]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
