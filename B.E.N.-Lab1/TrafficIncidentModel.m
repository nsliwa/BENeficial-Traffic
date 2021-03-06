//
//  TrafficIncidentModel.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "TrafficIncidentModel.h"
#import "TrafficIncident.h"
#import "MapQuestCommunicator.h"

@interface TrafficIncidentModel()

    @property (strong, nonatomic) NSMutableArray* currentIncidents;
    @property (strong, nonatomic) NSMutableArray* tempIncidents;



@end


@implementation TrafficIncidentModel


// static variable: holds all incidents from last API call
//static NSMutableArray* incidents = nil;


// shared instance
+(TrafficIncidentModel*)incidents{
    static TrafficIncidentModel * _incidents = nil;
    
    // alloc/init once; then just return pointer to instance
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{
        _incidents = [[TrafficIncidentModel alloc] init];
    });
    
    return _incidents;
}


static int incidentLimit = 10;
+(int) incidentLimit {
    @synchronized(self) { return incidentLimit; }
}
+(void)setIncidentLimit:(int)incidentLim {
    @synchronized(self) { incidentLimit = incidentLim; }
}
+(int)getIncidentLimit {
    return incidentLimit;
}

static int severityLimit = 0;
+(int) severityLimit {
    @synchronized(self) { return severityLimit; }
}
+(void)setSeverityLimit:(int)severityLim {
    @synchronized(self) { severityLimit = severityLim; }
}
+(int)getSeverityLimit {
    return severityLimit;
}

static int incidentTypeLimit = 0;
+(int) incidentTypeLimit {
    @synchronized(self) { return incidentTypeLimit; }
}
+(void)setIncidentTypeLimit:(int)incidentTypeLim {
    @synchronized(self) { incidentTypeLimit = incidentTypeLim; }
}
+(int)getIncidentTypeLimit {
    return incidentTypeLimit;
}

/*
-(CLLocationCoordinate2D)currentLocation {
    if(!_currentLocation.longitude || !_currentLocation.latitude) {
        _currentLocation = ((CLLocationCoordinate2D){ .latitude = 0.0, .longitude = 0.0 });
    }
    return _currentLocation;
}

-(CLLocationCoordinate2D)getCurrentLocation {
    return self.currentLocation;
}

-(void)setCurrentLocation:(CLLocationCoordinate2D)coordinate {
    @try {
        
    if(!_currentLocation.longitude || !_currentLocation.latitude) {
        _currentLocation = ((CLLocationCoordinate2D){ .latitude = 0.0, .longitude = 0.0 });
    }
    self.currentLocation = coordinate;
    }
    @catch (NSException *exception) {
        NSLog(@"ERRRRRRORRRRR: %@", exception.debugDescription);
    }
}
*/

-(TrafficIncident*) getIncidentWithShortDescription:(NSString*)descr {
    for(TrafficIncident* inc in self.currentIncidents) {
        if([inc.shortDesc isEqualToString:descr])
            return inc;
    }
    return nil;
}

-(NSMutableArray*) currentIncidents {
    if (!_currentIncidents)
    {
        _currentIncidents = [[NSMutableArray alloc] init];
    }
    return _currentIncidents;
}

-(NSMutableArray*) tempIncidents {
    if (!_tempIncidents)
    {
        _tempIncidents = [[NSMutableArray alloc] init];
    }
    return _tempIncidents;
}

-(NSArray*) getCurrentIncidents {
    
    return [self.currentIncidents copy]	;
    
}

- (NSArray *)incidentsFromJSON:(NSData *)incidentsAsJSON error:(NSError **)error {
    
    @try {
    
    NSError *internalError = nil;
    
    NSString *jsonString = [[NSString alloc] initWithData:incidentsAsJSON encoding:NSUTF8StringEncoding];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"handleIncidentsResponse(" withString:@""];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@");" withString:@""];
    incidentsAsJSON = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    //NSLog(jsonString);
    
    NSDictionary *parsedIncidents = [NSJSONSerialization JSONObjectWithData:incidentsAsJSON options:0 error:&internalError];
    
    if (internalError != nil) {
        NSLog(@"internal error at model");
        *error = internalError;
        return nil;
    }
    
    int empty = 0;
    
    NSLog(@"incident count, general: %lu, %lu", (unsigned long)self.currentIncidents.count, (unsigned long)[self.currentIncidents count]);
    
    /*
    if([self.currentIncidents count] && !empty){
        NSLog(@"incident count, bad_exec: %lu, %lu", (unsigned long)self.currentIncidents.count, (unsigned long)[self.currentIncidents count]);
        [self.currentIncidents removeAllObjects];
        empty = 1;
    }
     */
    self.tempIncidents = [[NSMutableArray alloc] init];
    //NSMutableArray* currIncidents = [[NSMutableArray alloc] init];
    //currIncidents = [self.currentIncidents copy];
    //NSMutableArray* currIncidents = [self.currentIncidents copy];

    
    //only need incidents but:
    //  mqURL key-val pair provides url for traffic map of current location
    
    NSDictionary *results = [parsedIncidents valueForKey:@"incidents"];
    
    NSArray *icon = [results valueForKey:@"iconURL"];
    
    NSLog(@"params: %@, %f", icon, icon.count);
    
    
    NSLog(@"Count %lu", (unsigned long)results.count);
    
    for (NSDictionary *incidentDict in results) {
        TrafficIncident *incident = [[TrafficIncident alloc] init];
                
        for (NSString *key in incidentDict) {
            if ([incident respondsToSelector:NSSelectorFromString(key)]) {
                [incident setValue:[incidentDict valueForKey:key] forKey:key];
            }
            
            if([key  isEqual: @"parameterizedDescription"]) {
                [incident setValue:[[incidentDict valueForKey:key] valueForKey:@"roadName"] forKey:@"roadName"];
            }
        }
        
        [incident setValue:[MapquestCommunicator getThumbMap:incident.lat lng:incident.lng] forKey:@"thumbMap"];
        
        BOOL unique = YES;
        
        //TODO: CHECK THIS ERROR BAD ACCESS
        for(TrafficIncident* inc in self.tempIncidents) {
            if([inc.shortDesc isEqualToString:incident.shortDesc])
                unique = NO;
        }
        if(unique)
            [self.tempIncidents addObject:incident];
        
        NSLog([NSString stringWithFormat:@"%lu, %@", (unsigned long)[self.tempIncidents count], incident.roadName]);
        
    }
    
    NSLog([NSString stringWithFormat:@"after adding %lu", (unsigned long)[self.tempIncidents count]]);
    
    [self.currentIncidents setArray:self.tempIncidents];
    return self.tempIncidents;
        
    }
    @catch (NSException *exception) {
        NSLog(@"ERRRORRR: %@", exception.debugDescription);
        return @[];
    }
}

@end
