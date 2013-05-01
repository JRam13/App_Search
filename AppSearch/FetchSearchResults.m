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
    
    NSCache *cache;
    NSDictionary *cacheDictionary;
    
    NSString *replaceSpace;
    
    
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

        cache = [[NSCache alloc]init];
    }
    
    return self;
}

-(void)runQuery
{
    
    
    //check to see if data is cached
    
    
    replaceSpace = [passURL stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *currentQuery = [NSString stringWithFormat: @"https://itunes.apple.com/search?term=%@&country=us&entity=software", replaceSpace];
    
    cacheDictionary = [cache objectForKey:[NSString stringWithFormat:@"%@", replaceSpace]];
    //NSLog(@"Contents of cacheDict 1: %@", cacheDictionary);
    
    if(cacheDictionary == NULL){
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
            _arrayOfDescriptions = [[NSMutableArray alloc]init];
            _arrayOfBuyLinks = [[NSMutableArray alloc]init];
        
        }
    }
    else{
        _arrayOfTitles = [[NSMutableArray alloc] init];
        _arrayOfImages = [[NSMutableArray alloc] init];
        _arrayOfAuthors = [[NSMutableArray alloc] init];
        _arrayOfPrices = [[NSMutableArray alloc] init];
        _arrayOfRatings = [[NSMutableArray alloc] init];
        _arrayOfRatingsInt = [[NSMutableArray alloc] init];
        _arrayOfDescriptions = [[NSMutableArray alloc]init];
        _arrayOfBuyLinks = [[NSMutableArray alloc]init];
        
        [self fetchCacheResults];
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
        cacheDictionary = allSearchDataDictionary;
        [cache setObject:cacheDictionary forKey:replaceSpace];
        NSLog(@"Contents of cacheDict 2: %@", [cache objectForKey:[NSString stringWithFormat:@"%@", replaceSpace]]);
        //NSLog(@"allSearchDict OK:");
        //results = [allSearchDataDictionary objectForKey:@"results"];
        //NSLog(@"results OK:");
        //NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
        
        
        NSMutableDictionary *mutableResults = [NSMutableDictionary dictionaryWithDictionary:allSearchDataDictionary];
        
        NSMutableArray *resultsArray;
        
        /*
         
         FOLLOWING CODE HELP BY ALEX SILVA
         --------------------------------------------------------------
         */
        
        if(_sortByRating){
        //sort results by rating
        resultsArray = [mutableResults[@"results"] mutableCopy];
        [resultsArray sortUsingComparator:^(NSDictionary* dict1, NSDictionary* dict2) {
            
            
            NSNumber *rating1 = [NSNumber numberWithInt:[[dict1 objectForKey:@"averageUserRating"] intValue]];
            NSNumber *rating2 = [NSNumber numberWithInt:[[dict2 objectForKey:@"averageUserRating"] intValue]];
            
            return [rating2 compare: rating1];
            
        }];
        }
        
        /*
         
         ---------------------------------------------------------------
         
         */
        
        if(_sortByAuthor){
        //sort by seller name
        resultsArray = [mutableResults[@"results"] mutableCopy];
        [resultsArray sortUsingComparator:^(NSDictionary* dict1, NSDictionary* dict2) {
            
            
            NSString *rating1 = [dict1 objectForKey:@"sellerName"] ;
            NSString *rating2 = [dict2 objectForKey:@"sellerName"] ;
            
            return [rating1 compare: rating2];
            
        }];
        
        }
        
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
            
            NSString *desc = [diction objectForKey:@"description"];
            
            NSString *buy = [diction objectForKey:@"trackViewUrl"];
            
            
            // dispatch_sync(dispatch_get_main_queue(), ^{
            [_arrayOfTitles addObject:label];
            //NSLog(@"Rating: %d", rating);
            [_arrayOfImages addObject:imageObject];
            [_arrayOfAuthors addObject:author];
            [_arrayOfPrices addObject:price];
            [_arrayOfRatings addObject:ratingsImage];
            [_arrayOfRatingsInt addObject:ratingString];
            [_arrayOfDescriptions addObject:desc];
            [_arrayOfBuyLinks addObject:buy];
            //NSLog(@"Description from fetch: %@", desc);
            //});
            //NSLog(@"Title: %@", label);
            //NSLog(@"Number: arrayLast %@", _arrayOfRatingsInt.lastObject);
            // NSLog(@"Image: arrayLast %@", _arrayOfImages.lastObject);
        }
    });
    
}

- (void)fetchCacheResults{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Fetch Search Results
        [cache setObject:cacheDictionary forKey:replaceSpace];
        NSLog(@"Contents of cacheDict 2: %@", [cache objectForKey:[NSString stringWithFormat:@"%@", replaceSpace]]);
        //NSLog(@"allSearchDict OK:");
        //results = [allSearchDataDictionary objectForKey:@"results"];
        //NSLog(@"results OK:");
        //NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
        
        
        NSMutableDictionary *mutableResults = [NSMutableDictionary dictionaryWithDictionary:cacheDictionary];
        
        NSMutableArray *resultsArray;
        
        /*
         
         FOLLOWING CODE HELP BY ALEX SILVA
         --------------------------------------------------------------
         */
        
        if(_sortByRating){
            //sort results by rating
            resultsArray = [mutableResults[@"results"] mutableCopy];
            [resultsArray sortUsingComparator:^(NSDictionary* dict1, NSDictionary* dict2) {
                
                
                NSNumber *rating1 = [NSNumber numberWithInt:[[dict1 objectForKey:@"averageUserRating"] intValue]];
                NSNumber *rating2 = [NSNumber numberWithInt:[[dict2 objectForKey:@"averageUserRating"] intValue]];
                
                return [rating2 compare: rating1];
                
            }];
        }
        
        /*
         
         ---------------------------------------------------------------
         
         */
        
        if(_sortByAuthor){
            //sort by seller name
            resultsArray = [mutableResults[@"results"] mutableCopy];
            [resultsArray sortUsingComparator:^(NSDictionary* dict1, NSDictionary* dict2) {
                
                
                NSString *rating1 = [dict1 objectForKey:@"sellerName"] ;
                NSString *rating2 = [dict2 objectForKey:@"sellerName"] ;
                
                return [rating1 compare: rating2];
                
            }];
            
        }
        
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
            
            NSString *desc = [diction objectForKey:@"description"];
            
            NSString *buy = [diction objectForKey:@"trackViewUrl"];
            
            
            // dispatch_sync(dispatch_get_main_queue(), ^{
            [_arrayOfTitles addObject:label];
            //NSLog(@"Rating: %d", rating);
            [_arrayOfImages addObject:imageObject];
            [_arrayOfAuthors addObject:author];
            [_arrayOfPrices addObject:price];
            [_arrayOfRatings addObject:ratingsImage];
            [_arrayOfRatingsInt addObject:ratingString];
            [_arrayOfDescriptions addObject:desc];
            [_arrayOfBuyLinks addObject:buy];
            //NSLog(@"Description from fetch: %@", desc);
            //});
            //NSLog(@"Title: %@", label);
            //NSLog(@"Number: arrayLast %@", _arrayOfRatingsInt.lastObject);
            // NSLog(@"Image: arrayLast %@", _arrayOfImages.lastObject);
        }
    });
}



@end
