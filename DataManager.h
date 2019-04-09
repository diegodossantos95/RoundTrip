//
//  DataManager.h
//  RoundTrip
//
//  Created by Marcus L. Rohden on 5/22/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Trip.h"

@interface DataManager : NSObject

@property NSUserDefaults *mySharedData;

- (void) saveTripsDataToUserDefaults: (NSArray*) arrayToShare;
- (NSMutableArray*) getArrayOfTripsDicts;
- (void)saveActiveTripIndexToUserDefaults:(NSNumber *)index;
- (NSNumber*)getActiveTripFromUserDefaults;

@end
