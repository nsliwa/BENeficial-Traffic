//
//  LocationParser.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationParser : NSObject

    +(CLLocationCoordinate2D) parseJSONLocation:(NSData*) locationJSON;

@end
