//
//  DataManager.h
//  OLXTest
//
//  Created by Macbook on 11/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Categories.h"

@protocol DataManagerDelegate
@required
- (void)dataLoadCompletedWithData:(NSArray*)data;
@end
@interface DataManager : NSObject

/**
 Returns singleton instance of DataManager
 */
+ (instancetype)sharedManager;

/**
 Make network call to fetch categories
 */
- (void)fetchCategoryList;

/**
 Return recently visited category
 @return Category object
 */
- (Categories*)getRecentCategoty;

/**
 Return list of categories
 @return NSarray of Category object
 */
- (NSArray*)categoryList;
@property (nonatomic, weak) NSObject<DataManagerDelegate>* delegate;
@end
