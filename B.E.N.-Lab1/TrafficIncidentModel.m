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


-(NSMutableArray*) currentIncidents {
    if (!_currentIncidents)
    {
        _currentIncidents = [[NSMutableArray alloc] init];
    }
    return _currentIncidents;
}

-(NSArray*) getCurrentIncidents {
    
    return _currentIncidents;
    
}

- (NSArray *)incidentsFromJSON:(NSData *)incidentsAsJSON error:(NSError **)error {
    
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
    
    [self.currentIncidents removeAllObjects];
    
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
        
        for(TrafficIncident* inc in self.currentIncidents) {
            if([inc.shortDesc isEqualToString:incident.shortDesc])
                unique = NO;
        }
        if(unique)
            [self.currentIncidents addObject:incident];
        
        NSLog([NSString stringWithFormat:@"%lu, %@", (unsigned long)[self.currentIncidents count], incident.roadName]);
        
    }
    
    NSLog([NSString stringWithFormat:@"after adding %lu", (unsigned long)[self.currentIncidents count]]);
    
    
    return self.currentIncidents;
}

@end
