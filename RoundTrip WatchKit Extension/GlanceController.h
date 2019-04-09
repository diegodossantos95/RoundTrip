//
//  GlanceController.h
//  RoundTrip WatchKit Extension
//
//  Created by Marcus L. Rohden on 5/22/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "WatchDataManager.h"

@interface GlanceController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *lblTripsAmount;
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *lblDaysAmount;
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *titleGroup;
@property WatchDataManager* dataManager;
@end
