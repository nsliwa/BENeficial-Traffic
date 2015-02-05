//
//  IncidentInformation.h
//  B.E.N.-Lab1
//
//  Created by Bre'Shard Busby on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IncidentInformation : NSObject

    @property (assign, nonatomic) NSString* street;
    @property (assign, nonatomic) NSString* desc;
    @property (assign, nonatomic) NSString* severity;
    @property (assign, nonatomic) NSString* delay;
    @property (assign, nonatomic) NSString* type;

@end
