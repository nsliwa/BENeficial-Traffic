//
//  CollectionViewController.h
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TrafficIncidentModel.h"

@interface CollectionViewController : UICollectionViewController

//@property (strong, nonatomic) NSArray *thumbMaps;
@property (strong, nonatomic) TrafficIncidentModel *trafficModel;
@property (strong, nonatomic) NSMutableArray *trafficData;

@end