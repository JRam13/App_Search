//
//  FetchAlbumData.h
//  AppSearch
//
//  Created by JRamos on 4/28/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FetchAlbumData : NSObject

@property (strong, nonatomic) NSMutableArray *arrayOfTitles;
@property (strong, nonatomic) NSMutableArray *arrayOfImages;

+ (id)sharedInstance;

@end
