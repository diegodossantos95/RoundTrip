//
//  NotificationController.m
//  RoundTrip WatchKit Extension
//
//  Created by Marcus L. Rohden on 5/22/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "NotificationController.h"


@interface NotificationController()

@end


@implementation NotificationController

- (instancetype)init {
    self = [super init];
    if (self){
        // Initialize variables here.
        // Configure interface objects here.
        
    }
    return self;
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (void)didReceiveLocalNotification:(UILocalNotification *)localNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a local notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    
    [_textLabel setText:localNotification.alertBody];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([[localNotification.userInfo valueForKey:@"lat"] floatValue], [[localNotification.userInfo valueForKey:@"lng"] floatValue]);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.2, 0.2));
    
    [_mapView setRegion:region];
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


- (void)didReceiveRemoteNotification:(NSDictionary *)remoteNotification withCompletion:(void (^)(WKUserNotificationInterfaceType))completionHandler {
    // This method is called when a remote notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    //
    // After populating your dynamic notification interface call the completion block.
    
    [_textLabel setText:[remoteNotification valueForKey:@"customKey"]];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([[remoteNotification valueForKey:@"lat"] floatValue], [[remoteNotification valueForKey:@"lng"] floatValue]);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.2, 0.2));
    
    [_mapView setRegion:region];
    
    completionHandler(WKUserNotificationInterfaceTypeCustom);
}


@end



