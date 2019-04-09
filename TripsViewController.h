//
//  ViewController.h
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "TripsTableViewCell.h"
#import "TripDetailViewController.h"
//#import "CreateTripViewController.h"
#import "AppDelegate.h"
#import "Trip.h"

@interface TripsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSMutableArray *trips;
@property (strong, nonatomic) IBOutlet UITableView *tripsTableView;
@property DataManager* watchDataManager;
//@property BOOL shouldGoToDetail;

//@property NSString  *latitudeMain;
//@property NSString *longitudeMain;
//@property (nonatomic) BOOL localizando;


//-(void)getLocation;


@end

