//
//  TableViewController.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/4/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

//#import <CoreLocation/CoreLocation.h>

#import "TableViewController.h"

#import "TrafficIncidentModel.h"
#import "MapQuestCommunicator.h"
#import "IncidentManager.h"
#import "IncidentViewController.h"
#import "IncidentTableViewCell.h"

#import <math.h>

@interface TableViewController() <IncidentManagerDelegate>//, CLLocationManagerDelegate>

    @property (strong, nonatomic) NSArray* incidents;
    @property (strong, nonatomic) IncidentManager* manager;
    @property (weak, nonatomic) CLLocationManager* locationManager;
    @property (strong, nonatomic) TrafficIncidentModel *trafficModel;

@end

@implementation TableViewController

-(TrafficIncidentModel*) trafficModel {
    if(!_trafficModel)
        _trafficModel = [TrafficIncidentModel incidents];
    
    return _trafficModel;
}

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
    
    //[self.trafficModel getCurrentIncidents];
    [self.manager fetchCurrentIncidents];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startFetchingIncidents:)
                                                 name:@"kCLAuthorizationStatusAuthorizedWhenInUse"
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
    NSLog(@"incidents to display: %f, %f, %f", self.incidents.count, [TrafficIncidentModel incidentLimit], MIN(self.incidents.count, [TrafficIncidentModel incidentLimit]));
    return MIN(self.incidents.count, [TrafficIncidentModel incidentLimit]);
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
        
        if(self.incidents && self.incidents.count) {
            TrafficIncident *incident = self.incidents[indexPath.row];
            //NSString* location = [NSString stringWithFormat:@"(%f, %f)", incident.lat, incident.lng];
            
            // Configure the cell...
            incidentCell.descriptionLabel.text = incident.shortDesc;//[incident.shortDesc];
            //cell.detailTextLabel.text = incident.shortDesc;//[incident.shortDesc];
            
            incidentCell.locationLabel.text = incident.roadName;
            //cell.textLabel.text = location;
            
            if(incident.type == 1) {
                //construction
                if(incident.severity == 0 || incident.severity == 1)
                    incidentCell.severityImageView.image = [UIImage imageNamed:@"construction_minor_icon.png"];
                else if(incident.severity == 2 || incident.severity == 3)
                    incidentCell.severityImageView.image = [UIImage imageNamed:@"construction_moderate_icon.png"];
                else
                    incidentCell.severityImageView.image = [UIImage imageNamed:@"construction_severe_icon.png"];
            }
            if(incident.type == 2) {
                //event
                incidentCell.severityImageView.image = [UIImage imageNamed:@"event_icon.png"];
            }
            if(incident.type == 3) {
                //congestion
                incidentCell.severityImageView.image = [UIImage imageNamed:@"congestion_icon.png"];
            }
            if(incident.type == 4) {
                //incident
                if(incident.severity == 0 || incident.severity == 1)
                    incidentCell.severityImageView.image = [UIImage imageNamed:@"incident_minor_icon.png"];
                else if(incident.severity == 2 || incident.severity == 3)
                    incidentCell.severityImageView.image = [UIImage imageNamed:@"incident_moderate_icon.png"];
                else
                    incidentCell.severityImageView.image = [UIImage imageNamed:@"incident_severe_icon.png"];
            }
            
            if(incident.severity == 0 || incident.severity == 1) {
                incidentCell.severityImageView.layer.borderColor = [UIColor greenColor].CGColor;
                incidentCell.severityImageView.backgroundColor = [UIColor greenColor];
            }
            else if(incident.severity == 3) {
                incidentCell.severityImageView.backgroundColor = [UIColor yellowColor];
                incidentCell.severityImageView.layer.borderColor = [UIColor yellowColor].CGColor;
            }
            else if(incident.severity == 3) {
                incidentCell.severityImageView.backgroundColor = [UIColor orangeColor];
                incidentCell.severityImageView.layer.borderColor = [UIColor orangeColor].CGColor;
            }
            else {
                incidentCell.severityImageView.backgroundColor = [UIColor redColor];
                incidentCell.severityImageView.layer.borderColor = [UIColor redColor].CGColor;
            }
        }
        
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
    
    NSLog(@"did receive incidents");
    _incidents = incidents;
    [self.tableView reloadData];
    NSLog(@"did load incidents");
    
}

-(void)fetchingIncidentsFailedWithError:(NSError *)error {

    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepare for segue");
    
    if([segue.identifier isEqualToString:@"IncidentDetailSegue"]) {
        IncidentTableViewCell* cell = (IncidentTableViewCell*)sender;
        IncidentViewController *ivc =  [segue destinationViewController];
        
        ivc.incident = [self.trafficModel getIncidentWithShortDescription:cell.descriptionLabel.text];
        
        //[self.navigationController pushViewController:ivc animated:YES];
    }
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
