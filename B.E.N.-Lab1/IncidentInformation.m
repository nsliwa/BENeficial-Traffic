//
//  IncidentInformation.m
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "IncidentInformation.h"

//@property (assign, nonatomic) NSString street;
//@property (assign, nonatomic) NSString description;
//@property (assign, nonatomic) NSString severity;
//@property (assign, nonatomic) NSString delay;
//@property (assign, nonatomic) NSString type;

@implementation IncidentInformation

-(NSString*) street {
    if(!_street)
        _street = @"";
    
    return _street;
}

-(NSString*) desc {
    if(!_desc)
        _desc= @"";
    
    return _desc;
}

-(NSString*) severity {
    if(!_severity)
        _severity = @"";
    
    return _severity;
}

-(NSString*) delay {
    if(!_delay)
        _delay = @"";
    
    return _delay;
}

-(NSString*) type {
    if(!_type)
        _type = @"";
    
    return _type;
}

@end