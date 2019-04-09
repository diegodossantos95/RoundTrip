//
//  DetailInterfaceController.m
//  RoundTrip
//
//  Created by Marcus L. Rohden on 5/26/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "DetailInterfaceController.h"
 

@interface DetailInterfaceController ()

@end

@implementation DetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    _dataManager = [[WatchDataManager alloc]init];
    
    NSDictionary* dictToHandoff;
    [dictToHandoff setValue:@0 forKey:@"tripIndex"];
    NSLog(@"%@",dictToHandoff);
    
    [self setupAllComponents:context];
    
    [self updateUserActivity:@"com.roundTrip.handoff" userInfo:dictToHandoff webpageURL:nil];
    
    //    NSDictionary* dict = context;
    
    //    NSLog(@"%@", [dict valueForKey:@"tempName"]);
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)setupAllComponents: (NSMutableDictionary*) dictionary
{
    NSString* name = [dictionary valueForKey:@"tempName"];
    NSNumber* numberOfDays = [dictionary valueForKey:@"tempDays"];
    NSString* lat = [dictionary valueForKey:@"tempLat"];
    NSString* lng = [dictionary valueForKey:@"tempLng"];
    
    [_namelLabel setText:name];
    [_daysLabel setText:[NSString stringWithFormat:@"%@ Days", numberOfDays.stringValue]];
    
    [self setupMapComponents:lat withLongitude:lng];
}

- (void)setupMapComponents: (NSString*)lat withLongitude: (NSString*) lng
{
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
    MKCoordinateRegion region = MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.2, 0.2));
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500, 500);
    [_mapView setRegion:region];
}

@end



