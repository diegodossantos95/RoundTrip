//
//  TripDaysCollectionViewCell.m
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/24/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "TripDaysCollectionViewCell.h"

@implementation TripDaysCollectionViewCell

- (void)awakeFromNib
{
    // [UIColor colorWithRed:56.0f/255 green:120.0f/255 blue:222.0f/255 alpha:1.0f]
    [self.layer setBorderWidth:1.0f];
    [self.layer setBorderColor:[UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f].CGColor];
    [self.layer setBackgroundColor: [UIColor whiteColor].CGColor];
    
}

@end
