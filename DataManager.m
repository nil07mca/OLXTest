//
//  DataManager.m
//  OLXTest
//
//  Created by Macbook on 11/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import "DataManager.h"
#include <AFNetworking/AFNetworking.h>

#define IMAGE_LIST_URL @"https://pixabay.com/api/?key=3277496-ec420ab1eaae161af264bcc2d&q=flowers&image_type=photo&per_page=6"

@interface DataManager() {
    
}
@property (nonatomic) NSMutableArray* arrItems;
@end
@implementation DataManager

+ (instancetype)sharedManager
{
    static DataManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)fetchCategoryList {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:IMAGE_LIST_URL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self parseData:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)parseData:(NSDictionary*)response {
    _arrItems  = [NSMutableArray array];
    NSArray* arrCategories = [response objectForKey:@"hits"];
    for (NSDictionary* dict in arrCategories) {
        Categories* categories = [[Categories alloc] init];
        categories.categoryWeight = 1;
        categories.imageURL = [dict objectForKey:@"previewURL"];
        categories.imageTag = [dict objectForKey:@"tags"];
        [_arrItems addObject:categories];
    }
    [self dataLoadCompleted];
}

- (void)dataLoadCompleted {
    if([self.delegate respondsToSelector:@selector(dataLoadCompletedWithData:)]) {
        [self.delegate dataLoadCompletedWithData:_arrItems];
    }
}

- (Categories*)getRecentCategoty {
    Categories* categories;
    for (Categories *cat in _arrItems) {
        if (cat.categoryWeight == 3) {
            categories = cat ;
            break;
        }else if (cat.isRecentVisited) {
            categories = cat ;
            break;
        }
    }
    return categories;
}

- (NSArray*)categoryList {
    return _arrItems;
}
@end
