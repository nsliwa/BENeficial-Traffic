//
//  IncidentManager.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "TrafficIncidentModel.h"
#import "IncidentManagerDelegate.h"
#import "MapQuestCommunicatorDelegate.h"

// forward class declaration
@class MapquestCommunicator;

// forward declaration of delegate
@protocol MeetupManagerDelegate;

// delegate for MapquestCommunicator; implements MapquestCommunicatorDelagate
@interface IncidentManager : NSObject<MapquestCommunicatorDelagate>
    @property (strong, nonatomic) MapquestCommunicator *communicator;
    @property (strong, nonatomic) TrafficIncidentModel *trafficModel;
    @property (weak, nonatomic) id<IncidentManagerDelegate> delegate;

    - (void)fetchIncidentsNearCoordinate:(CLLocationCoordinate2D)coordinate;
@end

