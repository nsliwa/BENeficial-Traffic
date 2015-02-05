//
//  IncidentManager.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "IncidentManager.h"
#import "MapQuestCommunicator.h"


@implementation IncidentManager

-(TrafficIncidentModel*) trafficModel {
    if(!_trafficModel)
        _trafficModel = [TrafficIncidentModel incidents];
    
    return _trafficModel;
}

-(void)fetchIncidentsNearCoordinate:(CLLocationCoordinate2D)coordinate {
    
    NSLog(@"Fetching in manager");
    [self.communicator searchIncidentsNearCoordinate:coordinate];
    
}

-(void)fetchCurrentIncidents{
    @try {
        [self.delegate didReceiveIncidents:[self.trafficModel getCurrentIncidents]];
    }
    @catch (NSException *exception) {
        [self.delegate fetchingIncidentsFailedWithError:exception];
    }
    
}

#pragma mark - MapquestCommunicatorDelegate implementation
-(void)receivedIncidentsJSON:(NSData *)incidentsAsJSON {
    
    NSError *error = nil;
    NSArray *incidents = [self.trafficModel incidentsFromJSON:incidentsAsJSON error:&error];
    //[trafficModel incidentsFromJSON:incidentsAsJSON error:&error];
    
    if (error != nil) {
        NSLog(@"error at manager");
        [self.delegate fetchingIncidentsFailedWithError:error];
        
    } else {
        NSLog(@"passed manager");
        [self.delegate didReceiveIncidents:incidents];
    }
    
}

-(void)fetchingIncidentsFailedWithError:(NSError *)error {

    [self.delegate fetchingIncidentsFailedWithError:error];
    
}

@end
