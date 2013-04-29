//
//  AppsViewController.m
//  AppSearch
//
//  Created by JRamos on 4/26/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "AppsViewController.h"
#import "AppsCell.h"
#import "FetchAppData.h"

@interface AppsViewController ()
{
    FetchAppData *appData;
}

@end

@implementation AppsViewController
{
    NSTimer *_timer;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    NSLog(@"APPS ViewDidLoad start");
	// Do any additional setup after loading the view.
    
    [[self AppsCollectionView]setDelegate:self];
    [[self AppsCollectionView]setDataSource:self];
    
    _appsLabels = [[NSMutableArray alloc] init];
    _appsButtonImages = [[NSMutableArray alloc] init];
    appData = [FetchAppData sharedInstance];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:.2f
                                              target:self
                                            selector:@selector(reload)
                                            userInfo:nil
                                             repeats:YES];

    
}

-(void)reload
{
    if([appData.arrayOfTitles count] == 25){
        [_timer invalidate];
    }
    
    _appsLabels = appData.arrayOfTitles;
    _appsButtonImages = appData.arrayOfImages;
    
    [self.AppsCollectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [appData.arrayOfTitles count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"appsLabel count: %d", [_appsLabels count]);
    //NSLog(@"ArrayofTitles count: %d", [appData.arrayOfTitles count]);
    
    
    static NSString *CellIndentifier = @"AppCell";
    AppsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIndentifier forIndexPath:indexPath];
    [[cell appsLabel]setText:[_appsLabels objectAtIndex:indexPath.item]];
    [[cell appsButtonImage]setImage:[_appsButtonImages objectAtIndex:indexPath.item] forState:UIControlStateNormal];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
