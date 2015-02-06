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
    @property (strong, nonatomic) NSArray* incidents_filtered;
    @property (strong, nonatomic) IncidentManager* manager;
    @property (weak, nonatomic) CLLocationManager* locationManager;
    @property (strong, nonatomic) TrafficIncidentModel *trafficModel;

@end

@implementation TableViewController

NSPredicate *predicate_incidentType;
NSPredicate *predicate_severity;

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

// majority of this function taken from http://www.appcoda.com/fetch-parse-json-ios-programming-tutorial/
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

// Notification part of this function taken from http://www.appcoda.com/fetch-parse-json-ios-programming-tutorial/
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
    
    switch ([TrafficIncidentModel incidentTypeLimit]) {
        case 0:
            predicate_incidentType = [NSPredicate predicateWithFormat:@"type = 1 OR type = 2 OR type = 3 OR type = 4"];
            break;
        case 1:
            predicate_incidentType = [NSPredicate predicateWithFormat:@"type = 1"];
            break;
        case 2:
            predicate_incidentType = [NSPredicate predicateWithFormat:@"type = 2"];
            break;
        case 3:
            predicate_incidentType = [NSPredicate predicateWithFormat:@"type = 3"];
            break;
        case 4:
            predicate_incidentType = [NSPredicate predicateWithFormat:@"type = 4"];
            break;
        case 5:
            predicate_incidentType = [NSPredicate predicateWithFormat:@"type = 1 OR type = 4"];
            break;
        default:
            predicate_incidentType = [NSPredicate predicateWithFormat:@"type = 1 OR type = 2 OR type = 3 OR type = 4"];
            break;
    }
    
    switch ([TrafficIncidentModel severityLimit]) {
        case 0:
            predicate_severity = [NSPredicate predicateWithFormat:@"severity = 0 OR severity = 1 OR severity = 2 OR severity = 3 OR severity = 4"];
            break;
        case 1:
            predicate_severity = [NSPredicate predicateWithFormat:@"severity = 1 OR severity = 2 OR severity = 3 OR severity = 4"];
            break;
        case 2:
            predicate_severity = [NSPredicate predicateWithFormat:@"severity = 2 OR severity = 3 OR severity = 4"];
            break;
        case 3:
            predicate_severity = [NSPredicate predicateWithFormat:@"severity = 3 OR severity = 4"];
            break;
        case 4:
            predicate_severity = [NSPredicate predicateWithFormat:@"severity = 4"];
            break;
        default:
            predicate_severity = [NSPredicate predicateWithFormat:@"severity = 0 OR severity = 1 OR severity = 2 OR severity = 3 OR severity = 4"];
            break;
    }
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
    self.incidents_filtered = [self.incidents filteredArrayUsingPredicate:predicate_severity];
    self.incidents_filtered = [self.incidents_filtered filteredArrayUsingPredicate:predicate_incidentType];
    // Return the number of rows in the section.
    // self looks at current class
    //if(section == 0)
    NSLog(@"incidents to display: %f, %f, %f", self.incidents.count, [TrafficIncidentModel incidentLimit], MIN(self.incidents.count, [TrafficIncidentModel incidentLimit]));
    return MIN(self.incidents_filtered.count, [TrafficIncidentModel incidentLimit]);
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
        
        if(self.incidents_filtered && self.incidents_filtered.count) {
            TrafficIncident *incident = self.incidents_filtered[indexPath.row];
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

    NSLog(@"Error %@; %@", error, [error debugDescription]);
    
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
