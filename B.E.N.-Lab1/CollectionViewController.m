//
//  CollectionViewController.m
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "IncidentViewController.h"

@implementation CollectionViewController

-(TrafficIncidentModel*) trafficModel {
    if(!_trafficModel)
        _trafficModel = [TrafficIncidentModel incidents];
    
    return _trafficModel;
}

/*-(NSArray*) thumbMaps {
    if (!_thumbMaps) {
        _thumbMaps.
    }
}*/

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"counting.............");
    return self.trafficModel.getCurrentIncidents.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSLog(@"sectioning.............");
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"population.............");
    CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    UIImage* trafficImage = [[UIImage alloc] init];
    NSString* trafficDesc = [[NSString alloc] init];
    
    trafficImage = [[self.trafficModel.getCurrentIncidents objectAtIndex:indexPath.row] thumbMap];
    trafficDesc = [[self.trafficModel.getCurrentIncidents objectAtIndex:indexPath.row] shortDesc];
    //cell.backgroundColor = [UIColor blueColor];
    cell.imageView.image = trafficImage;
    cell.descView.text = trafficDesc;
    
    
    return cell;
}

-(void)viewDidLoad {
    NSLog(@"loading............");
    [super viewDidLoad];
}

/*-(void)prepareForSeque:(UIStoryboardSegue *)seque sender:(id)sender {
    if([seque.identifier isEqualToString:@"segueFromCollectionToIncident"])
    {
        
    }
}*/

#pragma mark <UICollectionViewDataSource>

/*- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    cell.imageView.image = [self.myImageModel getImageWithIndex:(int)indexPath.row];
    //cell.imageView.image = [self.myImageModel getImageWithName:self.myImageModel.imageNames[indexPath.row]];
    
    return cell;
}*/

@end
