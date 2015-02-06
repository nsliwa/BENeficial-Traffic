//
//  MapQuestCommunicatorDelegate.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//
// changed function names, but function purpose taken from here: http://www.appcoda.com/fetch-parse-json-ios-programming-tutorial/
//


#import <Foundation/Foundation.h>

// Delegate protocol defined to enforce necessary functions for class assuming delegate role
@protocol MapquestCommunicatorDelagate <NSObject>
    - (void)receivedIncidentsJSON:(NSData *)incidentsAsJSON;
    - (void)fetchingIncidentsFailedWithError:(NSError *)error;
@end
