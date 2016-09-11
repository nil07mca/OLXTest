//
//  Categories.h
//  OLXTest
//
//  Created by Macbook on 11/09/16.
//  Copyright © 2016 Macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Categories : NSObject
@property(nonatomic,assign) int visitCount;
@property(nonatomic,assign) int categoryWeight;
@property(nonatomic,strong) NSString* categoryName;
@property(nonatomic,assign) BOOL isRecentVisited ;
@property(nonatomic,strong) NSString* imageURL;
@property(nonatomic,strong) NSString* imageTag;
@end
