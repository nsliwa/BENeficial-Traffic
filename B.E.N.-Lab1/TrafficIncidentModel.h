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

    + (TrafficIncidentModel *)incidents;
    - (NSArray *)incidentsFromJSON:(NSData *)objectNotation error:(NSError **)error;
    - (NSArray *)getCurrentIncidents;
    -(TrafficIncident*) getIncidentWithShortDescription:(NSString*)descr;
    //+ (NSMutableArray*) currentIncidents;

@end
