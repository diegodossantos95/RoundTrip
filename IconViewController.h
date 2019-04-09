//
//  IconViewController.h
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/25/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconViewController;


@protocol IconViewControllerDelegate <NSObject>

-(void)iconViewController:(IconViewController *)controller didSelectIcon:(NSString *)iconName;

@end


@interface IconViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) id <IconViewControllerDelegate> delegate;
@property NSString *icon;

@end