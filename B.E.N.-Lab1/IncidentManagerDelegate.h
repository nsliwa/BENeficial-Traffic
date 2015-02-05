//
//  IncidentManagerDelegate.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IncidentManagerDelegate <NSObject>

    - (void)didReceiveIncidents:(NSArray *)incidents;
    - (void)fetchingIncidentsFailedWithError:(NSError *)error;

@end
