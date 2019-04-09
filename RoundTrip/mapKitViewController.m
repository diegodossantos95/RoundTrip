//
//  mapKitViewController.m
//  RoundTrip
//
//  Created by Matheus Becker on 13/04/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "mapKitViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

#define MINIMUM_ZOOM_ARC 0.014 //approximately 1 miles (1 degree of arc ~= 69 miles)
#define ANNOTATION_REGION_PAD_FACTOR 1.15
#define MAX_DEGREES_ARC 360



@implementation mapKitViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.map.delegate = self;
//    self.map.showsUserLocation = YES;
    
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(loc.coordinate.latitude, loc.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = [_map regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 3000 , 3000)];
    [_map setRegion:adjustedRegion animated:YES];

}

@end
