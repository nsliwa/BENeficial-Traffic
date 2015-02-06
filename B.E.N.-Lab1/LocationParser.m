//
//  LocationParser.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "LocationParser.h"

@implementation LocationParser

    +(CLLocationCoordinate2D)parseJSONLocation:(NSData *)locationJSON {
        
        CLLocationCoordinate2D coordinate;
        NSString* lat;
        NSString* lng;
        
        @try {
            NSError *internalError = nil;
            
            NSDictionary *parsedLocation = [NSJSONSerialization JSONObjectWithData:locationJSON options:0 error:&internalError];
            
            if (internalError != nil) {
                NSLog(@"internal error at model");
                
                coordinate.latitude = 0.00;
                coordinate.longitude = 0.00;
                
                NSLog(@"internal error in parser!!!");
                return coordinate;
            }
            
            //only need incidents but:
            //  mqURL key-val pair provides url for traffic map of current location
            
            NSDictionary *results = [parsedLocation valueForKey:@"results"];
            
            //NSArray *icon = [results valueForKey:@"iconURL"];
            
            //NSLog(@"params: %@, %f", icon, icon.count);
            
            NSLog(@"Count %lu", (unsigned long)results.count);
            
            
            
            for (NSDictionary *params in results) {
                if([params isEqual:@"locations"]) {
                
                    for(NSString *key in params) {
                        if([key  isEqual: @"latLng"]) {
                            lat = [params valueForKey:key][0];
                            lng = [params valueForKey:key][0];
                        }
                    }
                    
                }
                
                NSLog([NSString stringWithFormat:@"%@, %@", lat, lng]);
                
            }
            
            coordinate.latitude = [lat doubleValue];
            coordinate.longitude = [lng doubleValue];
            
            return coordinate;
            
        }
        @catch (NSException *exception) {
            coordinate.latitude = 0.00;
            coordinate.longitude = 0.00;
            NSLog(@"exception in parser");
            return coordinate;
        }
        
    }

@end
