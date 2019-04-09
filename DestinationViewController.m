//
//  DestinationViewController.m
//  RoundTrip
//
//  Created by Diego dos Santos on 4/12/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "DestinationViewController.h"

//static NSString *geoNamesAccountName = @"roundtrip";

@interface DestinationViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
//@property NSDictionary *dictionary;
@property NSArray *autocomplete;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _searchedData = self.dataSource;
    
    _searchBar.layer.borderWidth = .5f;
    _searchBar.layer.borderColor = [[UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f] CGColor];
    _searchBar.barTintColor = [UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f];
    _searchBar.backgroundColor = [UIColor colorWithRed:74.0f/255 green:144.0f/255 blue:226.0f/255 alpha:1.0f];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"Shape"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [navigationBar setShadowImage:[UIImage new]];
    
    _searchBar.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma TableViewCell Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_autocomplete count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if([_autocomplete count]==0)
        return @"";
    return @"Results";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"countryCell" forIndexPath:indexPath];
    NSDictionary* dict = _autocomplete[indexPath.row];
    cell.textLabel.text = [dict valueForKey:@"description"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary* dict = _autocomplete[indexPath.row];
    
    NSString *destinationName = [dict valueForKey:@"description"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        
        NSArray* latlng = [self jsonRequisition:destinationName];
        [self.delegate DestinationViewController:self didSelectCountryandLat:latlng[0] andLng:latlng[1]];
        
    });
    [self.delegate DestinationViewController:self didSelectCountry:destinationName];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma SeachBar Delegate

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    if([searchText isEqualToString:@""]||searchText==nil){
//        _searchedData = _dataSource;
//    }else if(searchText.length >2){
////        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",searchText];
////        _searchedData = [NSMutableArray arrayWithArray:[_dataSource filteredArrayUsingPredicate:predicate]];
//        
//        
//        [self autocompleteJson:searchText];
//        
//        
//    }
//    
//    
//    
//    
//    
//    [_tableView reloadData];
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString* text = self.searchBar.text;
    if(text.length > 0){
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
            [self autocompleteJson:text];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.tableView reloadData];
            });
        });
        
    }
}

/*
- (IBAction)goSearch:(UIButton *)sender {
    NSString* text = self.searchBar.text;
    if(text.length > 0){
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
        [self autocompleteJson:text];
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.tableView reloadData];
            });
        });
        
    }
}
*/


#pragma Json Requisition


-(void)autocompleteJson:(NSString*) text{
    
    NSData *data = [text dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *newStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=%@&types=(cities)&key=AIzaSyDVtKwDvuDfzTYqKcktmJ09THBn19oXQHI",newStr];
    
    NSString *newUrl = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:newUrl]];
    
    NSError *error;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments error:&error];
    
    self.autocomplete = [json valueForKey:@"predictions"];

}

-(NSArray*)jsonRequisition:(NSString*) country{
    
    NSData *data = [country dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *newStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=false",newStr];
    
    
    NSString *newUrl = [url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:newUrl]];
    
    NSError *error;
    
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingAllowFragments error:&error];
    
    NSDictionary* results = [json valueForKey:@"results"];
    
    NSDictionary* geometry = [results valueForKey:@"geometry"];
    
    NSDictionary* location = [geometry valueForKey:@"location"];
    
    NSArray* latArray = [location valueForKey:@"lat"];
    NSArray* lngArray = [location valueForKey:@"lng"];
    
    
    
    NSString* lat = [NSString stringWithFormat:@"%@",latArray[0]];
    NSString* lng = [NSString stringWithFormat:@"%@",lngArray[0]];
    
    NSArray* latLng = [[NSArray alloc] initWithObjects:lat, lng, nil];
    
    return latLng;
    
}




@end
