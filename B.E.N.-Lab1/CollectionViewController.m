//
//  CollectionViewController.m
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//
// much adapted from Flipped classroom 1

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
#pragma mark <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSLog(@"counting.............");
    return MIN(self.trafficModel.getCurrentIncidents.count, [TrafficIncidentModel incidentLimit]);
//    return self.trafficModel.getCurrentIncidents.count;
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



#pragma mark - IncidentManagerDelegate implementation
/*
-(void)didReceiveIncidents:(NSArray *)incidents {
    
    NSLog(@"did receive incidents");
    _incidents = incidents;
    [self.tableView reloadData];
    NSLog(@"did load incidents");
    
}

-(void)fetchingIncidentsFailedWithError:(NSError *)error {
    
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    
}
*/
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepare for segue");
    
    if([segue.identifier isEqualToString:@"sequeFromCollectionToIncident"]) {
        CollectionViewCell* cell = (CollectionViewCell*)sender;
        IncidentViewController *ivc =  [segue destinationViewController];
        
        ivc.incident = [self.trafficModel getIncidentWithShortDescription:cell.descView.text];
        
        //[self.navigationController pushViewController:ivc animated:YES];
    }
}

@end
