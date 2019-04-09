//
//  DataManager.m
//  RoundTrip
//
//  Created by Marcus L. Rohden on 5/22/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

- (id) init {
    self = [super init];
    _mySharedData = [[NSUserDefaults alloc] initWithSuiteName:@"group.roundtripgroup"];
    return self;
}


- (NSMutableArray *) tripsArrayToDict: (NSArray*)array
{
    NSMutableArray* resultArray = [[NSMutableArray alloc]init];
    NSMutableDictionary* dictAux;
    NSString* tempName;
    NSNumber* tempTime;
    NSString* tempImage;
    NSString* tempLat;
    NSString* tempLng;
    Trip* tripAux;
    
    for (NSInteger i = 0; i < array.count; i++) {
        dictAux = [[NSMutableDictionary alloc]init];
        tripAux = [array objectAtIndex:i];
        tempName = [tripAux valueForKey:@"name"];
        tempTime = [tripAux valueForKey:@"numberOfDays"];
        tempImage = [tripAux valueForKey:@"imageName"];
        tempLat = [tripAux valueForKey:@"lat"];
        tempLng = [tripAux valueForKey:@"lng"];
        
        
        [dictAux setValue:tempName forKey:@"tempName"];
        [dictAux setValue:tempTime forKey:@"tempDays"];
        [dictAux setValue:tempImage forKey:@"tempImage"];
        [dictAux setValue:tempLat forKey:@"tempLat"];
        [dictAux setValue:tempLng forKey:@"tempLng"];
        
        [resultArray addObject:dictAux];
    }
    return resultArray;
}

- (void)saveTripsDataToUserDefaults:(NSArray *)arrayToShare
{
    NSMutableArray * arrayToArchive;
    arrayToArchive = [self tripsArrayToDict:arrayToShare];
    [_mySharedData setObject:arrayToArchive forKey:@"sharedTripsDictionary"];
}

- (NSMutableArray*) getArrayOfTripsDicts
{
    NSMutableArray* resultArray = [_mySharedData objectForKey:@"sharedTripsDictionary"];
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