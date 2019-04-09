//
//  InterfaceController.m
//  RoundTrip WatchKit Extension
//
//  Created by Marcus L. Rohden on 5/22/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    [self setTitle:@"RoundTrip"];

    // Configure interface objects here.
    _dataManager = [[WatchDataManager alloc]init];
    _tripsArray = [_dataManager getArrayOfTripsDicts];
    
    NSMutableDictionary* dict;
    NSString* name;
//    NSString* imageName;
//    NSNumber* numberOfDays;
    
    TripsTableRow* tripRow = [[TripsTableRow alloc]init];
    
//    NSLog(@"%@", _tripsArray);
    
    [_tripsInterfaceTable setNumberOfRows:[_tripsArray count]  withRowType:@"tripRow"];
    
    for(NSInteger i = 0; i < [_tripsArray count]; i++){
        tripRow = (TripsTableRow *)[_tripsInterfaceTable rowControllerAtIndex:i];
        
        dict = [_tripsArray objectAtIndex:i];
        name = [dict valueForKey:@"tempName"];
//        numberOfDays = [dict valueForKey:@"tempDays"];
//        imageName = [dict valueForKey:@"tempImage"];
        
        [tripRow.tripNameLabel setText:name];
    }

}

/*
 
 [self pushControllerWithName:@"DetailInterfaceController" context:[_tripsArray objectAtIndex:rowIndex]];
 
 [[_tripsArray objectAtIndex:rowIndex] valueForKey:@"tempName"];
 
 [_dataManager saveActiveTripIndexToUserDefaults:[NSNumber numberWithInteger:rowIndex]];
 
 
 */

- (id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex
{
    return [_tripsArray objectAtIndex:rowIndex];
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



