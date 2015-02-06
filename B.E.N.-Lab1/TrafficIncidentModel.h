//
//  TrafficIncidentModel.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TrafficIncident.h"

@interface TrafficIncidentModel : NSObject

    //@property (assign) CLLocationCoordinate2D currentLocation;

    + (TrafficIncidentModel *)incidents;
    - (NSArray *)incidentsFromJSON:(NSData *)objectNotation error:(NSError **)error;
    - (NSArray *)getCurrentIncidents;
    -(TrafficIncident*) getIncidentWithShortDescription:(NSString*)descr;

    +(int) incidentLimit;
    +(void)setIncidentLimit:(int)incidentLim;
    +(double)getIncidentLimit;

    +(double) severityLimit;
    +(void)setSeverityLimit:(double)severityLim;
    +(double)getSeverityLimit;

    +(double) incidentTypeLimit;
    +(void)setIncidentTypeLimit:(double)incidentTypeLim;
    +(double)getIncidentTypeLimit;
    //-(CLLocationCoordinate2D)getCurrentLocation;
    //ß-(void)setCurrentLocation:(CLLocationCoordinate2D)coordinate;
    //+ (NSMutableArray*) currentIncidents;

@end
