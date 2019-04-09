//
//  Trip.h
//  RoundTrip
//
//  Created by Diego dos Santos on 4/28/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Trip : NSManagedObject

@property (nonatomic, retain) NSString * destination;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) NSString * lat;
@property (nonatomic, retain) NSString * lng;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numberOfDays;
@property (nonatomic, retain) NSSet *days;
@end

@interface Trip (CoreDataGeneratedAccessors)

- (void)addDaysObject:(Day *)value;
- (void)removeDaysObject:(Day *)value;
- (void)addDays:(NSSet *)values;
- (void)removeDays:(NSSet *)values;

@end
