//
//  Activity.h
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/26/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Day;

@interface Activity : NSManagedObject

@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Day *actToDays;

@end
