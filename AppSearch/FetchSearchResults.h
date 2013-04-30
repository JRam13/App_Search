//
//  FetchSearchResults.h
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchSearchResults : NSObject
@property (strong, nonatomic) NSMutableArray *arrayOfTitles;
@property (strong, nonatomic) NSMutableArray *arrayOfImages;
@property (strong, nonatomic) NSMutableArray *arrayOfPrices;
@property (strong, nonatomic) NSMutableArray *arrayOfRatings;
@property (strong, nonatomic) NSMutableArray *arrayOfAuthors;
@property (strong, nonatomic) NSMutableArray *arrayOfRatingsInt;
@property (strong, nonatomic) NSMutableArray *arrayOfDescriptions;
@property (strong, nonatomic) NSMutableArray *arrayOfBuyLinks;
@property (weak, nonatomic) NSString * passURL;

@property (nonatomic) BOOL sortByAuthor;
@property (nonatomic) BOOL sortByRating;


+ (id)sharedInstance;
- (void)runQuery;

@end
