//
//  MapQuestCommunicator.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <math.h>
#import "MapquestCommunicator.h"
#import "MapQuestCommunicatorDelegate.h"

#define API_KEY @"Fmjtd%7Cluu829a2nq%2C7x%3Do5-947g06"

@implementation MapquestCommunicator

-(void) searchIncidentsNearCoordinate:(CLLocationCoordinate2D)coordinate {
    
    double R = 3963.1676;  // earth radius in miles
    
    // TO DO: make property determined by user settings
    double radius = 10; // radius of bounding box in miles
    
    // calculates bounding box coordinates for API call
    double lon1 = coordinate.longitude - [self radiansToDegrees: radius / R / cos([self degreesToRadians: coordinate.latitude])];
    double lon2 = coordinate.longitude + [self radiansToDegrees: radius / R / cos([self degreesToRadians: coordinate.latitude])];
    
    double lat1 = coordinate.latitude + [self radiansToDegrees: radius / R];
    double lat2 = coordinate.latitude - [self radiansToDegrees: radius / R];
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.mapquestapi.com/traffic/v2/incidents?key=%@&callback=handleIncidentsResponse&boundingBox=%f,%f,%f,%f&filters=construction,incidents&inFormat=kvp&outFormat=json", API_KEY, lat1, lon1, lat2, lon2];
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        // send either data or error to delegate
        if (error) {
            NSLog(@"error in communicator");
            [self.delegate fetchingIncidentsFailedWithError:error];
        } else {
            NSLog(@"passed communicator");
            [self.delegate receivedIncidentsJSON:data];
        }
    }];
}

+(UIImage *)getIncidentMap:(double)lat lng:(double)lon {
    int size1 = 400;
    int size2 = 400;
    int zoom = 12;
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.mapquestapi.com/staticmap/v4/getmap?key=%@&size=%d,%d&zoom=%d&center=%f,%f&traffic=con,flow,inc", API_KEY, size1, size2, zoom, lat, lon];
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:imageData];
}

+(UIImage *)getThumbMap:(double)lat lng:(double)lon {
    int size1 = 200;
    int size2 = 200;
    int zoom = 18;
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://www.mapquestapi.com/staticmap/v4/getmap?key=%@&size=%d,%d&zoom=%d&center=%f,%f&traffic=con,flow,inc", API_KEY, size1, size2, zoom, lat, lon];
    
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSLog(@"%@", urlAsString);
    
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:imageData];
}

-(double) radiansToDegrees:(double) radians {
    return radians * (180 / M_PI);
}

-(double) degreesToRadians:(double) degrees {
    return degrees * M_PI / 180.0;
}


@end

