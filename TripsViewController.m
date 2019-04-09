//
//  ViewController.m
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "TripsViewController.h"

@interface TripsViewController ()

@property AppDelegate* myAppDelegate;

@end

@implementation TripsViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myAppDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    _watchDataManager = [[DataManager alloc]init];
 
}

-(void)viewWillAppear:(BOOL)animated{
    _tripsTableView.delegate = self;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Trip"];
    _trips = [[_myAppDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [_tripsTableView reloadData];
    
    /*if(self.shouldGoToDetail)
    {
        [self performSegueWithIdentifier:@"ShowTripDetail" sender:nil];
    }*/
    
    [_watchDataManager saveTripsDataToUserDefaults:_trips];
    
//    NSLog(@"%@",[_watchDataManager getArrayOfTripsDicts]);
}

-(void)restoreUserActivityState:(NSUserActivity *)activity{
    NSLog(@"teste");
    [super restoreUserActivityState:activity];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowTripDetail" sender:indexPath];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdent = @"TripsCell";
    TripsTableViewCell *cell = [_tripsTableView dequeueReusableCellWithIdentifier:cellIdent];
    Trip *tripToCell = [_trips objectAtIndex:indexPath.row];
    cell.tripNameLabel.text = tripToCell.name;
    cell.flagImage.image = [UIImage imageNamed:tripToCell.imageName ];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_trips count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if([_trips count]>0)
        return @"Trips";
    return @"No trips created yet :(";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSArray *)tableView:(UITableView *)tableView
editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSManagedObjectContext *context = [self.myAppDelegate managedObjectContext];
    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         [context deleteObject:[_trips objectAtIndex:indexPath.row]];
                                         NSError *error = nil;
                                         if (![context save:&error]) {
                                             NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
                                             return;
                                         }
                                         [_trips removeObjectAtIndex:indexPath.row];
                                         [_tripsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                     }];
    button2.backgroundColor = [UIColor redColor];
    return @[button2];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowTripDetail"]){
        TripDetailViewController* tdvc = [segue destinationViewController];
        
        /*if(self.shouldGoToDetail)
        {
            tdvc.tripDetail = [_trips objectAtIndex:0];
        }
        else
        {*/
            NSIndexPath* indexPath = (NSIndexPath*) sender;
            tdvc.tripDetail = [_trips objectAtIndex:indexPath.row];
        //}
        
    }

}



@end
