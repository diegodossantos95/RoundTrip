//
//  CategoriasViewController.h
//  RoundTrip
//
//  Created by Matheus Becker on 30/03/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoriasViewController;

@protocol CategoriasViewControllerDelegate <NSObject>

-(void)categoriasViewController:(CategoriasViewController*)controller didSelectCategory:(NSString*) category;

@end

@interface CategoriasViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSString *categoriaCVC;
@property (weak) id <CategoriasViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableViewCategorias;


@end
