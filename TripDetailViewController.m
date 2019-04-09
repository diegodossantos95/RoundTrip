//
//  TripDetailViewController.m
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "AppDelegate.h"
#import "TripDetailTableViewCell.h"
#import "TripDetailViewController.h"
#import "TripDaysCollectionViewCell.h"

@interface TripDetailViewController ()

@property NSSet* amountOfDayToTableView;
@property NSArray* sortedAmountOfDays;
@property AppDelegate* myAppDelegate;
@property NSIndexPath* selectedIndex;

@end

@implementation TripDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myAppDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    _activitiesTableView.allowsMultipleSelection = NO;
    _selectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
}

-(void)viewWillAppear:(BOOL)animated{
    _sortedAmountOfDays = [[NSArray alloc] init];
    [self updateTableViewAndCollectionViewRows];
    [self setTitle:_tripDetail.name];
}

-(void)updateTableViewAndCollectionViewRows
{
    _amountOfDayToTableView = _tripDetail.days;
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"number"  ascending:YES];
    _sortedAmountOfDays = [_amountOfDayToTableView sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    [_daysCollection reloadData];
    [_activitiesTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_sortedAmountOfDays count];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Day *getDays = [_sortedAmountOfDays objectAtIndex:section];
    if ([getDays.activities count] > 0)
    {
            return [getDays.activities count];
    }else{
        return 1;
    }

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.selectedIndex){
            TripDaysCollectionViewCell *unselectCell = (TripDaysCollectionViewCell *)[collectionView cellForItemAtIndexPath:self.selectedIndex];
            unselectCell.contentView.backgroundColor = [UIColor whiteColor];
            unselectCell.daysLabel.textColor=[UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f];
    }
    TripDaysCollectionViewCell *cell = (TripDaysCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f];
    cell.daysLabel.textColor = [UIColor whiteColor];
    _selectedIndex = indexPath;
    
    NSIndexPath *indexPathToScroll = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [_activitiesTableView scrollToRowAtIndexPath:indexPathToScroll
                                atScrollPosition:UITableViewScrollPositionTop
                                        animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    sectionName = [NSString stringWithFormat:@"Day %ld",(section+1)];
    return sectionName;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripDetailTableViewCell *cellToDetail;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    cellToDetail = (TripDetailTableViewCell* )[tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];

    Day *getActivities = [_sortedAmountOfDays objectAtIndex:indexPath.section];
    NSSet *dayActivities = getActivities.activities;
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"time"  ascending:YES];
    NSArray *activities = [dayActivities sortedArrayUsingDescriptors:[NSArray arrayWithObjects:descriptor,nil]];
    Activity *act;
    
    UIFont * originalNameLabelFont = cellToDetail.nameLabel.font;
    
    if (getActivities.activities.count < 1)
    {
        cellToDetail.nameLabel.textColor = [UIColor grayColor];
        [cellToDetail.nameLabel setFont:[originalNameLabelFont fontWithSize:12.0f]];
        cellToDetail.dateLabel.text = @"";
        cellToDetail.nameLabel.text = @"Activities not added yet!";
        
    }
    else
    {
        act = [activities objectAtIndex:(indexPath.row)];
        cellToDetail.nameLabel.textColor = [UIColor blackColor];
        [cellToDetail.nameLabel setFont:[originalNameLabelFont fontWithSize:17.0f]];
        [formatter setDateFormat:@"h:mm a"];
        NSString *stringFromDate = [formatter stringFromDate:act.time];
        cellToDetail.dateLabel.text = stringFromDate;
        cellToDetail.nameLabel.text = act.name;
    }
    return cellToDetail;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_sortedAmountOfDays count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TripDaysCollectionViewCell* taskCell = [[TripDaysCollectionViewCell alloc] init];
    taskCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TripDays" forIndexPath:indexPath];
    taskCell.daysLabel.text = [[[_sortedAmountOfDays objectAtIndex:indexPath.row] number] stringValue];
    
    if([_selectedIndex isEqual:indexPath]){
        taskCell.contentView.backgroundColor = [UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f];
        taskCell.daysLabel.textColor = [UIColor whiteColor];
    }else{
        taskCell.contentView.backgroundColor = [UIColor whiteColor];
        taskCell.daysLabel.textColor=[UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f];
    }
    
    return taskCell;
}

- (IBAction)addActivity:(id)sender {
    [self performSegueWithIdentifier:@"showMap" sender:sender];
}

-(void)addActivityViewController:(DisplayActivitiesViewController *)controller didAddActivity:(Activity *)activity atDay:(NSInteger)day{
    Day *dayToAddActivity = [_sortedAmountOfDays objectAtIndex:day-1];
    [dayToAddActivity addActivitiesObject:activity];
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![_myAppDelegate.managedObjectContext save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"showMap"]){
        DisplayActivitiesViewController *davc = (DisplayActivitiesViewController *)segue.destinationViewController;
        
        davc.latitude = self.tripDetail.lat;
        davc.longitude = self.tripDetail.lng;
//        NSLog(@"Lat is: %@",davc.latitude);
//        NSLog(@"Long is: %@",davc.longitude);


    }
}

@end
