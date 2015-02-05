//
//  TableViewController.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

//#import <CoreLocation/CoreLocation.h>

#import "TableViewController.h"

#import "TrafficIncident.h"
#import "TrafficIncidentModel.h"
#import "MapQuestCommunicator.h"
#import "IncidentManager.h"
#import "IncidentTableViewCell.h"

@interface TableViewController() <IncidentManagerDelegate>//, CLLocationManagerDelegate>

    @property (strong, nonatomic) NSArray* incidents;
    @property (strong, nonatomic) IncidentManager* manager;
    @property (weak, nonatomic) CLLocationManager* locationManager;

@end

@implementation TableViewController

-(IncidentManager*) manager {
    if(!_manager)
        _manager = [[IncidentManager alloc] init];
    
    NSLog(@"init manager");
    
    return _manager;
}

- (CLLocationManager *)locationManager
{
    if (_locationManager) {
        return _locationManager;
    }
    
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(locationManager)]) {
        _locationManager = [appDelegate performSelector:@selector(locationManager)];
        NSLog(@"init loc mngr 2");
    }
    NSLog(@"init loc mngr");
    
    return _locationManager;
}

/*
-(CLLocationManager*) locationManager {
    if(!_locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    NSLog(@"init loc mngr");
    
    return _locationManager;
}
 */

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.manager.communicator = [[MapquestCommunicator alloc] init];
    self.manager.communicator.delegate = _manager;
    self.manager.delegate = self;
    
    /*
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
    */
     
    //CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(39.950960, -105.259451);
    //[self.manager fetchIncidentsNearCoordinate:coord];//]self.locationManager.location.coordinate];
    
    
    NSLog(@"startfetching");
    //NSLog([NSString stringWithFormat:@"(%f, %f)", coord.latitude, coord.longitude]);
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startFetchingIncidents:)
                                                 name:@"kCLAuthorizationStatusAuthorizedAlways"
                                               object:nil];
    
    NSLog(@"View did load");
}

#pragma mark - Notification Observer
- (void)startFetchingIncidents:(NSNotification *)notification
{
    //CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(39.950960, -105.259451);
    //[self.manager fetchIncidentsNearCoordinate:coord];//self.locationManager.location.coordinate];
    [self.manager fetchIncidentsNearCoordinate:self.locationManager.location.coordinate];
    
    NSLog(@"startttt fetching");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // self looks at current class
    //if(section == 0)
    return self.incidents.count;
    //else
     //   return 1;
}

// Need to uncomment!!
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IncidentTableViewCell* incidentCell = nil;
    if(indexPath.section==0){
        
        //UITableViewCell* cell = nil;
        
        // this is for section 1:
        incidentCell = [tableView dequeueReusableCellWithIdentifier:@"IncidentCell" forIndexPath:indexPath];
        //cell = [tableView dequeueReusableCellWithIdentifier:@"IncidentCell" forIndexPath:indexPath];
        
        TrafficIncident *incident = self.incidents[indexPath.row];
        NSString* location = [NSString stringWithFormat:@"(%f, %f)", incident.lat, incident.lng];
        
        // Configure the cell...
        incidentCell.descriptionLabel.text = incident.shortDesc;//[incident.shortDesc];
        //cell.detailTextLabel.text = incident.shortDesc;//[incident.shortDesc];
        
        incidentCell.locationLabel.text = location;
        //cell.textLabel.text = location;
        
        NSLog(@" in incident cell");
        
        
    
    }return incidentCell;
    /*
    else {
        UITableViewCell* cell = nil;
        
        // this is for section 2:
        cell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell" forIndexPath:indexPath];
        
        // Configure the cell...
        cell.textLabel.text = @"Settings";
        
        NSLog(@"Hi there");
        return cell;
    }*/
    
}

#pragma mark - IncidentManagerDelegate implementation

-(void)didReceiveIncidents:(NSArray *)incidents {
    
    _incidents = incidents;
    [self.tableView reloadData];
    
}

-(void)fetchingIncidentsFailedWithError:(NSError *)error {

    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    
}

/*
#pragma mark - CLLocationManagerDelegate implementation

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        //longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        //latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}
*/


@end
