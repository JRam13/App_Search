//
//  FetchAppData.h
//  AppSearch
//
//  Created by JRamos on 4/27/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchAppData : NSObject <NSURLConnectionDataDelegate>


@property (strong, nonatomic) NSMutableArray *arrayOfTitles;
@property (strong, nonatomic) NSMutableArray *arrayOfImages;

+ (id)sharedInstance;


@end
