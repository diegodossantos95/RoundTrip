//
//  DetailInterfaceController.h
//  RoundTrip
//
//  Created by Marcus L. Rohden on 5/26/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "WatchDataManager.h"

@interface DetailInterfaceController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *namelLabel;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *daysLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *activitiesLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceMap *mapView;

@property WatchDataManager* dataManager;


@end
