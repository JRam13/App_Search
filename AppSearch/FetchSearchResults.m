//
//  FetchSearchResults.m
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "FetchSearchResults.h"

@implementation FetchSearchResults
{
    
    NSMutableData *webData;
    NSURLConnection *connection;
    
    NSMutableArray *results;
    
}
@synthesize passURL;


static FetchSearchResults *sharedInstance = nil;

+ (FetchSearchResults *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {

    }
    
    return self;
}

-(void)runQuery
{
    
    
    NSString *replaceSpace = [passURL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *currentQuery = [NSString stringWithFormat: @"https://itunes.apple.com/search?term=%@&media=software", replaceSpace];
    NSURL *url1 = [NSURL URLWithString:currentQuery];
    NSURLRequest *request = [NSURLRequest requestWithURL:url1];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
 
    
    if(connection){
        // NSLog(@"Good Connection");
        webData = [[NSMutableData alloc] init];
        _arrayOfTitles = [[NSMutableArray alloc] init];
        _arrayOfImages = [[NSMutableArray alloc] init];
        _arrayOfAuthors = [[NSMutableArray alloc] init];
        _arrayOfPrices = [[NSMutableArray alloc] init];
        _arrayOfRatings = [[NSMutableArray alloc] init];
        _arrayOfRatingsInt = [[NSMutableArray alloc] init];
        
    }
    
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"RCV Response");
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"Start Appending Web Data");
    [webData appendData:data];
    //NSLog(@"Did recieve Search Query Data!");
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection did fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Fetch Search Results
        NSDictionary *allSearchDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
        //NSLog(@"allSearchDict OK:");
        results = [allSearchDataDictionary objectForKey:@"results"];
        //NSLog(@"results OK:");
        //NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
        
        
        NSMutableDictionary *mutableResults = [NSMutableDictionary dictionaryWithDictionary:allSearchDataDictionary];
        
        /*
         
         FOLLOWING CODE HELP BY ALEX SILVA (SORTING)
         
         */
        
        
        //sort results by rating
        NSMutableArray *resultsArray = [mutableResults[@"results"] mutableCopy];
        [resultsArray sortUsingComparator:^(NSDictionary* dict1, NSDictionary* dict2) {
            
            
            NSNumber *rating1 = [NSNumber numberWithInt:[[dict1 objectForKey:@"averageUserRating"] intValue]];
            NSNumber *rating2 = [NSNumber numberWithInt:[[dict2 objectForKey:@"averageUserRating"] intValue]];
            
            return [rating2 compare: rating1];
            
        }];
        
        
        //NSLog(@"last object: %@", resultsArray);
        for (NSDictionary *diction in resultsArray) {
            //NSLog(@"Diction: %@", diction);
            //NSLog(@"8");
            NSString *label = [diction objectForKey:@"trackName"];
            //NSLog(@"9");
            NSString *image = [diction objectForKey:@"artworkUrl60"];
            NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: image]];
            NSObject *imageObject = [UIImage imageWithData: imageData];
            
            NSString *author = [diction objectForKey:@"sellerName"];
            
            NSString *price = [diction objectForKey:@"formattedPrice"];
            
            NSUInteger rating = [[diction objectForKey:@"averageUserRating"] integerValue];
            UIImage *ratingsImage = [UIImage imageNamed:[NSString stringWithFormat:@"%dstars.png", rating]];
            NSString *ratingString = [NSString stringWithFormat:@"%d", rating];
            //NSLog(@"Number String: arrayLast %@", ratingString);
            
            
            // dispatch_sync(dispatch_get_main_queue(), ^{
            [_arrayOfTitles addObject:label];
            //NSLog(@"Rating: %d", rating);
            [_arrayOfImages addObject:imageObject];
            [_arrayOfAuthors addObject:author];
            [_arrayOfPrices addObject:price];
            [_arrayOfRatings addObject:ratingsImage];
            [_arrayOfRatingsInt addObject:ratingString];
            //});
            //NSLog(@"Title: %@", label);
            //NSLog(@"Number: arrayLast %@", _arrayOfRatingsInt.lastObject);
            // NSLog(@"Image: arrayLast %@", _arrayOfImages.lastObject);
        }
    });
    
}



@end
