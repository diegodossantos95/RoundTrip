//
//  DestinationViewController.h
//  RoundTrip
//
//  Created by Diego dos Santos on 4/12/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@class DestinationViewController;


@protocol DestinationViewControllerDelegate <NSObject>

-(void)DestinationViewController:(DestinationViewController *)controller didSelectCountryandLat:(NSString *)lat andLng:(NSString *)lng;

-(void)DestinationViewController:(DestinationViewController *)controller didSelectCountry:(NSString *)destinationName;

@end


@interface DestinationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, weak) id <DestinationViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic) NSMutableArray *dataSource;
//@property (nonatomic) NSMutableArray *tableData;
//@property (nonatomic) NSMutableArray *searchedData;

@end
