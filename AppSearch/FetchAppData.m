//
//  FetchAppData.m
//  AppSearch
//
//  Created by JRamos on 4/27/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "FetchAppData.h"
#import <Foundation/NSJSONSerialization.h> 
#import "AppsViewController.h"

@implementation FetchAppData
{
    NSMutableData *webData;
    NSURLConnection *connection;
    
    NSDictionary *feed;
    
}


static FetchAppData *sharedInstance = nil;

+ (FetchAppData *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/rss/topfreeapplications/limit=25/json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
        if(connection){
            webData = [[NSMutableData alloc] init];
            _arrayOfTitles = [[NSMutableArray alloc] init];
            _arrayOfImages = [[NSMutableArray alloc] init];
            
        }
        

    }
    
    return self;
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    NSLog(@"Did recieve App Data!");
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Connection did fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
    //Fetch App Title & Image
    NSDictionary *allAppDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    feed = [allAppDataDictionary objectForKey:@"feed"];
    NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    
    for (NSDictionary *diction in arrayOfEntry) {
        NSDictionary *title = [diction objectForKey:@"im:name"];
        NSString *label = [title objectForKey:@"label"];
        
        NSArray *image = [diction objectForKey:@"im:image"];
        NSDictionary *imageSize = [image objectAtIndex:2];
        NSString *labelImage = [imageSize objectForKey:@"label"];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: labelImage]];
        NSObject *imageObject = [UIImage imageWithData: imageData];

        
        dispatch_sync(dispatch_get_main_queue(), ^{
        [_arrayOfTitles addObject:label];
        [_arrayOfImages addObject:imageObject];
            });
        //NSLog(@"Title: %@", label);
        //NSLog(@"Title: arrayLast %@", _arrayOfTitles.lastObject);
       // NSLog(@"Image: arrayLast %@", _arrayOfImages.lastObject);
    }
        
    });
    
    //[avc.AppsCollectionView reloadData];
    //avc = [[AppsViewController alloc] init];
    
    

}

//dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//    // No explicit autorelease pool needed here.
//    // The code runs in background, not strangling
//    // the main run loop.
//    [self doSomeLongOperation];
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        // This will be called on the main thread, so that
//        // you can update the UI, for example.
//        [self longOperationDone];
//    });
//});



@end
