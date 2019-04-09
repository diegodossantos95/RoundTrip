//
//  AddTripViewController.m
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/30/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//


#import "DisplayActivitiesViewController.h"

@interface DisplayActivitiesViewController ()

@property AppDelegate* myAppDelegate;
@property CLLocationManager* locationManager;
@property NSMutableArray *auxPoints;
@property UILabel* counterLabel;
@property NSMutableArray* annotationsOnMap;
@property NSMutableArray* activitiesToAdd;
@property NSMutableArray* addedCellTags;
@property NSString *selectedCategory;
@property BOOL isFirstTime;

@end

@implementation DisplayActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myAppDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    _activitiesToAdd = [[NSMutableArray alloc]init];
    _annotationsOnMap = [[NSMutableArray alloc]init];
    self.map.delegate = self;
    _locationManager = [[CLLocationManager alloc]init];
    [self.locationManager requestWhenInUseAuthorization];
    self.map.showsUserLocation = YES;
    _isFirstTime = true;
}

-(void) viewWillAppear:(BOOL)animated{
    [_map removeAnnotations:_annotationsOnMap];
    [_annotationsOnMap removeAllObjects];
    if (!_isFirstTime){
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
            [self requisicaoJsonComCategoria];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self insertPinsOnMap];
                [_map showAnnotations:_annotationsOnMap animated:true];
                [_activitiesTableView reloadData];
            });
        });
    }else{
        [self directMapToCoord:_latitude withLongitude:_longitude withZoom:@"10000"];
        _isFirstTime = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)directMapToCoord:(NSString*) lat withLongitude:(NSString*) lng withZoom:(NSString*) zoom{
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake([lat floatValue], [lng floatValue]);
    MKCoordinateRegion adjustedRegion = [_map regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, [zoom floatValue] , [zoom floatValue])];
    [_map setRegion:adjustedRegion animated:YES];
}

-(void)insertPinsOnMap{
    for (Ponto *p in _auxPoints) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([p.lat floatValue], [p.lng floatValue]);
        point.title = p.name;
        [_map addAnnotation:point];
        [_annotationsOnMap addObject:point];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell"];
    Ponto* tempPonto = [_auxPoints objectAtIndex:indexPath.row];
    cell.nameLabel.text = tempPonto.name;
    cell.addButton.tag = indexPath.row;
    [cell.addButton addTarget:self action:@selector(buttonPressed:)forControlEvents:UIControlEventTouchUpInside];
    if([_activitiesToAdd containsObject:tempPonto]){
        [cell.addButton setTitle:@"-" forState:UIControlStateNormal];
    }else{
        [cell.addButton setTitle:@"+" forState:UIControlStateNormal];
    }
    return cell;
}

- (void)buttonPressed:(UIButton *)button {
    if ([self addPointCellToActivityArray:button.tag]) {
        [button setTitle:@"-" forState:UIControlStateNormal];
        //adicionado na lista, logo trocar icone para -
    }else{
        [button setTitle:@"+" forState:UIControlStateNormal];
        //removido da lista, trocar icone para +
    }
    
}

- (BOOL)addPointCellToActivityArray:(NSInteger) index{
    Ponto* tempPonto = [_auxPoints objectAtIndex:index];
    if ([_activitiesToAdd containsObject:tempPonto]){
        [_activitiesToAdd removeObject:tempPonto];
        [self updateCounterLabel];
        return false;
    }else{
        [_activitiesToAdd addObject:tempPonto];
        [self updateCounterLabel];
        return true;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _auxPoints.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Ponto* tempPonto = [_auxPoints objectAtIndex:indexPath.row];
    [self directMapToCoord:tempPonto.lat withLongitude:tempPonto.lng withZoom:@"150"];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 36)];
    view.backgroundColor = [UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f];

    _counterLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, tableView.frame.size.width-60, 20)];
    [_counterLabel setTextColor: [UIColor whiteColor]];
    [self updateCounterLabel];
    [view addSubview:_counterLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(tableView.frame.size.width-60, 0, 60,36);
    btn.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0f];
    [btn setTitle:@"Done" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sendListOfActivities:) forControlEvents:UIControlEventTouchUpInside];

    [view addSubview:btn];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_map showAnnotations:_annotationsOnMap animated:true];
}

-(void) sendListOfActivities:(UIButton*)sender
{
    NSLog(@"you clicked on button");
}

- (void) updateCounterLabel{
    self.counterLabel.text = [@"Activities Selected: " stringByAppendingString:[NSString stringWithFormat:@"%lu", _activitiesToAdd.count]];
}

- (IBAction)filter:(id)sender {
    [self performSegueWithIdentifier:@"DefineCategory" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual:@"DefineCategory"]){
        CategoriasViewController *cvc = segue.destinationViewController;
        cvc.delegate = self;
    }
}

-(void)categoriasViewController:(CategoriasViewController *)controller didSelectCategory:(NSString *)category{
    _selectedCategory = category;
}

-(void)requisicaoJsonComCategoria{
    
    NSString* lat = _latitude;
    NSString* lng = _longitude;
    
 
    if ([_selectedCategory  isEqual: @"Arts & Entertainment"]) {
        _selectedCategory = @"4d4b7104d754a06370d81259";
    }
    if ([_selectedCategory  isEqual: @"College & University"]) {
        _selectedCategory = @"4d4b7105d754a06372d81259";
    }
    if ([_selectedCategory  isEqual: @"Event"]) {
        _selectedCategory = @"4d4b7105d754a06373d81259";
    }
    if ([_selectedCategory  isEqual: @"Food"]) {
        _selectedCategory = @"4d4b7105d754a06374d81259";
    }
    if ([_selectedCategory  isEqual: @"Nightlife Spot"]) {
        _selectedCategory = @"4d4b7105d754a06376d81259";
    }
    if ([_selectedCategory  isEqual: @"Outdoors & Recreation"]) {
        _selectedCategory = @"4d4b7105d754a06377d81259";
    }
    if ([_selectedCategory  isEqual: @"Professional & Other Places"]) {
        _selectedCategory = @"4d4b7105d754a06375d81259";
    }
    if ([_selectedCategory  isEqual: @"Shop & Service"]) {
        _selectedCategory = @"4d4b7105d754a06378d81259";
    }
    if ([_selectedCategory  isEqual: @"Travel & Transport"]) {
        _selectedCategory = @"4d4b7105d754a06379d81259";
    }
    
    
    _auxPoints = [[NSMutableArray alloc]init];
    NSString *url;
    if(_selectedCategory != nil){
        url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=EEAB2IUSJGB5IEXTFNHBF4MVNTTOFO3UIHBN2MCVEVRPT3CZ&client_secret=XATVQ5HV45P1IOM2K2S5TSD04QYFD43S3UMT3NYHHMKVKA42&v=20130815&categoryId=%@&ll=%@,%@",_selectedCategory, lat, lng];
    }//20130815
    else{
        url = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=EEAB2IUSJGB5IEXTFNHBF4MVNTTOFO3UIHBN2MCVEVRPT3CZ&client_secret=XATVQ5HV45P1IOM2K2S5TSD04QYFD43S3UMT3NYHHMKVKA42&v=20130815&ll=%@,%@", lat, lng];
    }
    
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultados = [NSJSONSerialization JSONObjectWithData:jsonData
                                                               options:NSJSONReadingMutableContainers error:&error];
    if(!error){
        
        NSDictionary * dicionario = (NSDictionary *)[resultados objectForKey: @"response"];
        for (NSDictionary *dictLocations in dicionario[@"venues"]) {
                Ponto *p = [[Ponto alloc]init];
                p.name = dictLocations[@"name"];
                NSDictionary * dicGeo = (NSDictionary *)[dictLocations objectForKey: @"location"];
                p.lat = dicGeo [@"lat"];
                p.lng = dicGeo [@"lng"];
                [_auxPoints addObject:p];
        }
        
    }else{
        NSLog(@"Erro %@", error);
    }
}



@end
