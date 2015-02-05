//
//  TrafficIncident.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/3/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//
// ----------------
//
//  Holds data for a Traffic Incident
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TrafficIncident : NSObject


    @property (assign, nonatomic) CLLocationDegrees lat;
    @property (assign, nonatomic) CLLocationDegrees lng;
    @property (strong, nonatomic) NSString *shortDesc;
    @property (strong, nonatomic) NSString *fullDesc;
    @property (assign, nonatomic) NSInteger type;
    @property (assign, nonatomic) NSInteger severity;
    @property (assign, nonatomic) BOOL impacting;
    @property (assign, nonatomic) double delayFromTypical;
    @property (assign, nonatomic) double distance;
    @property (strong, nonatomic) NSDate *startTime;
    @property (strong, nonatomic) NSDate *endTime;

    @property (strong, nonatomic) UIImage* thumbMap;
    @property (strong, nonatomic) NSString* roadName;

/*
    -(CLLocationDegrees) getLatitude;
    -(CLLocationDegrees) getLongitude;
    -(NSString*) getDescription;
    -(NSString*) getFullDescription;
    -(NSString*) geType;
    -(NSInteger) getSeverity;
    -(BOOL) isImpactingTraffic;
    -(double) getDelay;
    -(double) getDistance;
    -(NSDate*) getStartTime;
    -(NSDate*) getEndTime;
*/

@end
