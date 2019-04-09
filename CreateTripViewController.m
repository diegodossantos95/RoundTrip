//
//  CreateTripViewController.m
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/23/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//



#import "CreateTripViewController.h"


@interface CreateTripViewController ()

@property AppDelegate* myAppDelegate;
@property (strong, nonatomic) IBOutlet UITableView *NewTripTableView;
@property NSMutableArray* tripNames;

@end

@implementation CreateTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tripNames = [[NSMutableArray alloc]init];
    _myAppDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Trip"];
        NSMutableArray* trips = [[_myAppDelegate.managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
        for(int i = 0; i<trips.count; i++){
            Trip *trip = [trips objectAtIndex:i];
//            NSLog(trip.name);
            [_tripNames addObject:trip.name];
        }
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma Table View

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row ==1){
        UITableViewCell *destinationCell = [_NewTripTableView dequeueReusableCellWithIdentifier:@"destinationCell"];
       if(_destination)
            destinationCell.textLabel.text =_destination;
        else
            destinationCell.textLabel.text =@"Destination";
        return destinationCell;
    
    }else if(indexPath.row == 3){
        PickFlagTableViewCell* cellIcon;
        cellIcon = (PickFlagTableViewCell *) [_NewTripTableView dequeueReusableCellWithIdentifier:@"iconCell"];
        cellIcon.pickIconLabel.text = @"Icon";
        cellIcon.iconImageView.image = [UIImage imageNamed:_iconName];
        return cellIcon;
    } else{
        CreateTripTableViewCell* cellInfo;
        cellInfo = (CreateTripTableViewCell *) [_NewTripTableView dequeueReusableCellWithIdentifier:@"AddTripCell"];
        if(indexPath.row == 2){
            cellInfo.textFieldCell.placeholder = @"Total Days";
            cellInfo.textFieldCell.keyboardType =  UIKeyboardTypeNumberPad;
        }else{
            cellInfo.textFieldCell.placeholder = @"Trip Name";
        }
        return cellInfo;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)verifyTripName:(NSString *)tripName{
   if([_tripNames containsObject:tripName]){
        return true;
    }else if([tripName isEqualToString:@""]){
        return true;
    }else{
        return false;
    }
}

- (IBAction)addTrip:(UIBarButtonItem *)sender {
    CreateTripTableViewCell *cellTripInfo;
    UITableViewCell *destinationCell;
    for(int i = 0; i < 3; i++){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if(indexPath.row != 1){
        cellTripInfo = (CreateTripTableViewCell *) [_NewTripTableView cellForRowAtIndexPath:indexPath];
        switch (i) {
            case 0:
                self.tripName = cellTripInfo.textFieldCell.text;
                break;
            case 2:
                self.numberOfDays = cellTripInfo.textFieldCell.text;
                break;
            }
        }else{
            destinationCell =[_NewTripTableView cellForRowAtIndexPath:indexPath];
            self.destination = destinationCell.textLabel.text;
            }
            
        }
    
//    NSString* tripNameTest = [self.tripName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* tripDestinationTest = [self.destination stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString* tripNumberOfDaysTest = [self.numberOfDays stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    _convertedNumberOfDays = [NSNumber numberWithInteger:([_numberOfDays integerValue])];
    
   /* if ([tripNameTest isEqualToString:@""]){
        UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Trip Name must be filled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertMsg show];
    }else*/
    if([self verifyTripName:_tripName]){
        UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Trip Name must be different" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertMsg show];
    }
    else if([tripDestinationTest isEqualToString:@""]){
       UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Destination must be filled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
        [alertMsg show];
    }
    else if ([tripNumberOfDaysTest isEqualToString:@""]){
        UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of days must be filled" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertMsg show];
    }
    else if (_iconName == nil) {
        UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You must pick an icon" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertMsg show];
    }
    else if([tripNumberOfDaysTest integerValue] == 0){
        UIAlertView *alertMsg = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Number of days must be a number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alertMsg show];
    }
    else{
    
        Trip *newTrip =  [NSEntityDescription insertNewObjectForEntityForName:@"Trip" inManagedObjectContext:_myAppDelegate.managedObjectContext];
        
        [newTrip setValue:[NSNumber numberWithBool:NO] forKey:@"isDone"];
        [newTrip setValue:_tripName forKey:@"name"];
        [newTrip setValue:_destination forKey:@"destination"];
        [newTrip setValue:_convertedNumberOfDays forKey:@"numberOfDays"];
        [newTrip setValue:_iconName forKey:@"imageName"];
        [newTrip setValue:_lat forKey:@"lat"];
        [newTrip setValue:_lng forKey:@"lng"];
        
        for(NSInteger i = 0; i < [_convertedNumberOfDays integerValue]; i++){
            Day *day =  [NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:_myAppDelegate.managedObjectContext];
            day.number =[ NSNumber numberWithInteger:(i+1)];
            [newTrip addDaysObject:day];
        }

        NSError *error = nil;
        // Save the object to persistent store
        if (![_myAppDelegate.managedObjectContext save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        //Create notification - JUST FOR THE PRESENTATION
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        if (notification){
            NSDate* date = [NSDate date];
            NSDateComponents* comps = [[NSDateComponents alloc]init];
            comps.minute = 1; //1 minute
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDate* newDate = [calendar dateByAddingComponents:comps toDate:date options:nil];
            
            notification.fireDate = newDate;
            notification.timeZone = [NSTimeZone defaultTimeZone];
            notification.alertBody = [NSString  stringWithFormat: @"Please finish your %@ plan! We are waiting for you!" ,_tripName];
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.category = @"finishNotification";
            [notification.userInfo setValue:_lat forKey:@"lat"];
            [notification.userInfo setValue:_lng forKey:@"lng"];
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"iconSegue"]) {
        IconViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"destinationSegue"]) {
        DestinationViewController *controller = segue.destinationViewController;
        controller.delegate = self;
//        controller.dataSource = self.countries;
    }
}

-(void)DestinationViewController:(DestinationViewController *)controller didSelectCountryandLat:(NSString *)lat andLng:(NSString *)lng{
    _lat = lat;
    _lng = lng;
}

-(void)DestinationViewController:(DestinationViewController *)controller didSelectCountry:(NSString *)destinationName{
    _destination = destinationName;
    [self.tableView reloadData];
}

-(void)iconViewController:(IconViewController *)controller didSelectIcon:(NSString *)iconName{
    _iconName = iconName;
    [self.navigationController popViewControllerAnimated:YES];
    [self.tableView reloadData];
}

@end
