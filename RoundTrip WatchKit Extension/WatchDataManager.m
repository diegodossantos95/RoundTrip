//
//  ShredDataManager.m
//  EasyDay
//
//  Created by Marcus L. Rohden on 4/30/15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "WatchDataManager.h"

@implementation WatchDataManager

- (id) init {
    self = [super init];
    if (self) {
        NSLog(@"_init: %@", self);
    }
    _mySharedData = [[NSUserDefaults alloc] initWithSuiteName: @"group.roundtripgroup"];
    return(self);
}


- (NSMutableArray*) getArrayOfTripsDicts
{
    NSMutableArray* resultArray = [_mySharedData objectForKey:@"sharedTripsDictionary"];
    NSLog(@"ArrayOfDicts%@", resultArray);
    return resultArray;
}


- (void)saveActiveTripIndexToUserDefaults:(NSNumber *)index
{
    [_mySharedData setObject:index forKey:@"activTrip"];
}

- (NSNumber*)getActiveTripFromUserDefaults
{
    NSMutableArray* resultNumber = [_mySharedData objectForKey:@"activTrip"];
    NSNumber* res = resultNumber.firstObject;
    return res;
}

@end
