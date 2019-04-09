//
//  CategoriasViewController.m
//  RoundTrip
//
//  Created by Matheus Becker on 30/03/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "CategoriasViewController.h"
#import "CategoriTableViewCell.h"

@interface CategoriasViewController ()

@property NSArray *dataSourceCategorias;
@property NSArray *dataSourceCategoriasAux;
@property NSMutableArray *icons;
@property (strong, nonatomic) IBOutlet UIView *tableView;

@end

@implementation CategoriasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableViewCategorias setDelegate:self];
    
    [self populateCategories];
    
    
    _icons = [[NSMutableArray alloc]init];
    
    [self popFlagIcons];
}

-(void) populateCategories{
    self.dataSourceCategorias = [[NSArray alloc]initWithObjects:@"Arts & Entertainment",@"College & University",@"Event", @"Food", @"Nightlife Spot",@"Outdoors & Recreation", @"Professional & Other Places",@"Shop & Service", @"Travel & Transport",nil];
    
    
//    self.dataSourceCategoriasAux = [[NSArray alloc]initWithObjects:@"Aeroporto",@"Cafe",@"Cinema", @"Entretenimento", @"Evento",@"Festa",@"Hotel", @"Igreja",@"Loja", @"Museu",@"Padaria", @"Parque",@"Restaurante", @"Shopping", nil];
}


- (void) popFlagIcons
{
    NSString *img;
    
    for (int i = 1; i <= 9; i++) {
        img = [NSString stringWithFormat:@"%i.png", i];
        [_icons addObject:img];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - TableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceCategorias.count;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"Line %lu - Section %lu",(long)indexPath.row,(long)indexPath.section);
    
    _categoriaCVC = _dataSourceCategorias[indexPath.row];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate categoriasViewController:self didSelectCategory:_categoriaCVC];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoriTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    NSString *categoriaStr = [_dataSourceCategorias objectAtIndex:indexPath.row];
    
    
    cell.label.text = categoriaStr;
    [cell.image setImage:([UIImage imageNamed:[_icons objectAtIndex:indexPath.row]])];
    
    
    
    if([self.dataSourceCategorias[indexPath.row] isEqualToString:_categoriaCVC])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

@end
