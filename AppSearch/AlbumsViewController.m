//
//  AlbumsViewController.m
//  AppSearch
//
//  Created by JRamos on 4/27/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "AlbumsViewController.h"
#import "FetchAlbumData.h"
#import "AlbumsCell.h"

@interface AlbumsViewController ()
{
    FetchAlbumData *appData;
}

@end

@implementation AlbumsViewController
{
    NSTimer *_timer;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    NSLog(@"ALBUMS ViewDidLoad start");
	// Do any additional setup after loading the view.
    
    [[self AlbumsCollectionView]setDelegate:self];
    [[self AlbumsCollectionView]setDataSource:self];
    
    _albumLabels = [[NSMutableArray alloc] initWithObjects:@"1", nil];
    _albumLabelsImage = [[NSMutableArray alloc] init];
    appData = [FetchAlbumData sharedInstance];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:.2f
                                              target:self
                                            selector:@selector(reload)
                                            userInfo:nil
                                             repeats:YES];
    
    
}

-(void)reload
{
    if([appData.arrayOfTitles count] == 10){
        [_timer invalidate];
    }
    
    _albumLabels = appData.arrayOfTitles;
    _albumLabelsImage = appData.arrayOfImages;
    
    [self.AlbumsCollectionView reloadData];
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
    
    
    static NSString *CellIndentifier = @"AlbumCell";
    AlbumsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIndentifier forIndexPath:indexPath];
    [[cell albumLabel]setText:[_albumLabels objectAtIndex:indexPath.item]];
    [[cell albumLabelImage]setImage:[_albumLabelsImage objectAtIndex:indexPath.item]];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
