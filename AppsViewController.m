//
//  AppsViewController.m
//  AppSearch
//
//  Created by JRamos on 4/26/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "AppsViewController.h"
#import "AppsCell.h"

@interface AppsViewController ()
{
    NSArray *appsLabels;
}

@end

@implementation AppsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self AppsCollectionView]setDelegate:self];
    [[self AppsCollectionView]setDataSource:self];
    
    appsLabels = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [appsLabels count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIndentifier = @"AppCell";
    AppsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIndentifier forIndexPath:indexPath];
    [[cell appsLabel]setText:[appsLabels objectAtIndex:indexPath.item]];
     return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
