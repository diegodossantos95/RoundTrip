//
//  TripsTableViewCell.h
//  RoundTrip
//
//  Created by Marcus L. Rohden on 3/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *flagImage;
@property (strong, nonatomic) IBOutlet UILabel *tripNameLabel;

@end
