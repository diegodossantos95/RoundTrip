//
//  GlanceController.m
//  RoundTrip WatchKit Extension
//
//  Created by Marcus L. Rohden on 5/22/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@end

@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    _dataManager = [[WatchDataManager alloc]init];
    NSArray* tripsArray = _dataManager.getArrayOfTripsDicts;
    NSLog(@"%@", tripsArray);
    NSDictionary* tripDict;
    NSInteger amountOfDays = 0;
    
    for (int i = 0; i < tripsArray.count; i++){
        tripDict = [tripsArray objectAtIndex:i];
        amountOfDays += [[tripDict valueForKey:@"tempDays"] integerValue];
    }
    
    [self.lblDaysAmount setText:[NSString stringWithFormat:@"%ld Days",(long)amountOfDays]];
    [self.lblTripsAmount setText:[NSString stringWithFormat:@"%ld Trips",(long)tripsArray.count]];
    
    NSNumber* lastIndex = 0;
    NSDictionary* dictToHandoff;
    [dictToHandoff setValue:lastIndex forKey:@"tripIndex"];

    [self updateUserActivity:@"com.roundTrip.handoff" userInfo:dictToHandoff webpageURL:nil];
    
    [_titleGroup setBackgroundImageNamed:@"Animation"];
}

- (void)willActivate {
    [super willActivate];
    
    [_titleGroup startAnimatingWithImagesInRange: NSMakeRange(0, 59) duration:1.5 repeatCount:1];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}
@end