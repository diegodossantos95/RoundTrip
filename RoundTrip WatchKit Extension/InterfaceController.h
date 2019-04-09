//
//  InterfaceController.h
//  RoundTrip WatchKit Extension
//
//  Created by Marcus L. Rohden on 5/22/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "WatchDataManager.h"
#import "TripsTableRow.h"

@interface InterfaceController : WKInterfaceController
@property WatchDataManager* dataManager;
@property (strong, nonatomic) IBOutlet WKInterfaceTable *tripsInterfaceTable;
@property WKInterfaceController* destionationScreen;
@property NSArray* tripsArray;
@end
