//
//  TripDetailViewController.h
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#import "Day.h"
#import "Activity.h"
#import "DisplayActivitiesViewController.h"

#import "TripDaysCollectionViewCell.h"

@interface TripDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate>

@property Trip* tripDetail;
@property (weak, nonatomic) IBOutlet UICollectionView *daysCollection;
@property (weak, nonatomic) IBOutlet UITableView *activitiesTableView;

@end
