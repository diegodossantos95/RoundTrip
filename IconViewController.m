//
//  IconViewController.m
//  RoundTrip
//
//  Created by Luis Filipe Campani on 3/25/15.
//  Copyright (c) 2015 Luis Filipe Novo Campani da Silva. All rights reserved.
//

#import "IconViewController.h"

@interface IconViewController ()

@end

@implementation IconViewController
{
    NSMutableArray *_icons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _icons = [[NSMutableArray alloc]init];
    [self popFlagIcons];
}

- (void) popFlagIcons
{
    NSString *img;
    
    for (int i = 29; i <= 48; i++) {
        img = [NSString stringWithFormat:@"%i.png", i];
        [_icons addObject:img];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_icons count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIImageView *flag = (UIImageView *)[cell viewWithTag:100];
    _icon = _icons [indexPath.row];
    
    flag.image = [UIImage imageNamed:_icon];
    return cell;
}

-(void)collectionView:(IconViewController *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *iconName = _icons[indexPath.row];
    [self.delegate iconViewController:self didSelectIcon:iconName];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
