//
//  TrafficIncident.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/3/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "TrafficIncident.h"

/*
@interface TrafficIncident()

    @property (assign, nonatomic) CLLocationDegrees lat;
    @property (assign, nonatomic) CLLocationDegrees lng;
    @property (strong, nonatomic) NSString *shortDesc;
    @property (strong, nonatomic) NSString *fullDesc;
    @property (strong, nonatomic) NSString *type;
    @property (assign, nonatomic) NSInteger severity;
    @property (assign, nonatomic) BOOL impacting;
    @property (assign, nonatomic) double delayFromTypical;
    @property (assign, nonatomic) double distance;
    @property (strong, nonatomic) NSDate *startTime;
    @property (strong, nonatomic) NSDate *endTime;

@end
 */


@implementation TrafficIncident

-(CLLocationDegrees) lat {
    if(!_lat)
        _lat = 123.3;
    
    return _lat;
}

-(CLLocationDegrees) lng {
    if(!_lng)
        _lng = 123.3;
    
    return _lng;
}

-(NSString*) shortDesc {
    if(!_shortDesc)
        _shortDesc = @"short description";
    
    return _shortDesc;
}

-(NSString*) fullDesc {
    if(! _fullDesc)
        _fullDesc = @"full description";
    
    return _fullDesc;
}

-(NSString*) type {
    if(! _type)
        _type = @"incident type";
    
    return _type;
}

-(NSInteger) severity {
    if(! _severity)
        _severity = 0;
    
    return _severity;
}

-(BOOL) impacting {
    if(! _impacting)
        _impacting = NO;
    
    return _impacting;
}

-(double) delayFromTypical {
    if(! _delayFromTypical)
        _delayFromTypical = 0;
    
    return _delayFromTypical;
}

-(double) distance {
    if(! _distance)
        _distance = 0;
    
    return _distance;
}

-(NSDate*) startTime {
    if(! _startTime)
        _startTime = [NSDate dateWithTimeIntervalSinceNow:5];
    
    return _startTime;
}

-(NSDate*) endTime {
    if(! _endTime)
        _endTime = [NSDate dateWithTimeIntervalSinceNow:0];
    
    return _endTime;
}

/*
-(CLLocationDegrees) getLatitude{ return _lat; }
-(CLLocationDegrees) getLongitude{ return _lng; }
-(NSString*) getDescription{ return _shortDesc; }
-(NSString*) getFullDescription{ return _fullDesc; }
-(NSString*) geType{ return _type; }
-(NSInteger) getSeverity{ return _severity; }
-(BOOL) isImpactingTraffic{return _impacting; }
-(double) getDelay{ return _delayFromTypical; }
-(double) getDistance{ return _distance; }
-(NSDate*) getStartTime{ return _startTime; }
-(NSDate*) getEndTime{ return _endTime; }
 */

@end
