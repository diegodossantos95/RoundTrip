//
//  Day.h
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/26/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Activity, Trip;

@interface Day : NSManagedObject

@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSSet *activities;
@property (nonatomic, retain) Trip *trips;
@end

@interface Day (CoreDataGeneratedAccessors)

- (void)addActivitiesObject:(Activity *)value;
- (void)removeActivitiesObject:(Activity *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

@end
