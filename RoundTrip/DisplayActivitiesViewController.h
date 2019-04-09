//
//  AddTripViewController.h
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/30/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Activity.h"
#import "ActivityTableViewCell.h"
#import "CategoriasViewController.h"
#import "AppDelegate.h"
#import "TripDaysCollectionViewCell.h"
#import "Ponto.h"

@interface DisplayActivitiesViewController : UIViewController <MKMapViewDelegate, CategoriasViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UITableView *activitiesTableView;
@property NSString*  latitude;
@property NSString* longitude;

@end
