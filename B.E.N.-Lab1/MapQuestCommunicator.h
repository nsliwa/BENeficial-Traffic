//
//  MapQuestCommunicator.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// forward declaration of delegate
@protocol MapquestCommunicatorDelagate;
 
@interface MapquestCommunicator : NSObject
    // keeps track of the delegate
    @property (weak, nonatomic) id<MapquestCommunicatorDelagate> delegate;

    // searches for incidents near a specific location
    -(void) searchIncidentsNearCoordinate:(CLLocationCoordinate2D) coordinate;

    +(UIImage*) getThumbMap:(double)lat lng:(double)lon;
    +(UIImage*) getIncidentMap:(double)lat lng:(double)lon;
@end
