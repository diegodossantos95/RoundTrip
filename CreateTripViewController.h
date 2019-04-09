//
//  CreateTripViewController.h
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "IconViewController.h"
#import "PickFlagTableViewCell.h"
#import "CreateTripTableViewCell.h"
#import "Trip.h"
#import "Day.h"
#import "DestinationViewController.h"

@interface CreateTripViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate ,IconViewControllerDelegate, DestinationViewControllerDelegate>

@property NSString* tripName;
@property NSString* destination;
@property NSString* numberOfDays;
@property NSString* iconName;
@property NSNumber* convertedNumberOfDays;
@property NSString* lat;
@property NSString* lng;


@end
