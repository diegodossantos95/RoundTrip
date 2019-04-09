//
//  ShredDataManager.h
//  EasyDay
//
//  Created by Marcus L. Rohden on 4/30/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WatchDataManager : NSObject

@property NSUserDefaults *mySharedData;

- (NSMutableArray*) getArrayOfTripsDicts;
- (void)saveActiveTripIndexToUserDefaults:(NSNumber *)index;
- (NSNumber*)getActiveTripFromUserDefaults;



@end
