//
//  MasterTableViewController.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "MasterTableViewController.h"

#import "IncidentViewController.h"
#import "TableViewController.h"
#import "MapViewController.h"
#import "IncidentManager.h"
#import "MapQuestCommunicator.h"


@interface MasterTableViewController() <IncidentManagerDelegate>//, CLLocationManagerDelegate>

    @property (strong, nonatomic) NSArray* incidents;
    @property (strong, nonatomic) IncidentManager* manager;
    @property (weak, nonatomic) CLLocationManager* locationManager;

@end


@implementation MasterTableViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"View did load - master");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.manager.communicator = [[MapquestCommunicator alloc] init];
    self.manager.communicator.delegate = _manager;
    self.manager.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startFetchingIncidents:)
                                                 name:@"kCLAuthorizationStatusAuthorizedWhenInUse"
                                               object:nil];
    
    
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
    NSLog(@"tableview - #sections");
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // self looks at current class
    NSLog(@"tableview - #rows");
    return 1;
}

// Need to uncomment!!
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = nil;
    
    NSLog(@"tableview - cell for row@idx");
    
    if(indexPath.section==0){
        
        // this is for section 1:
        cell = [tableView dequeueReusableCellWithIdentifier:@"incidentMapCell" forIndexPath:indexPath];
        
        // Configure the cell...
        cell.textLabel.text = @"Incident Map";
        //cell.detailTextLabel.text = @"More";
    }
    if(indexPath.section==1){
        
        // this is for section 1:
        cell = [tableView dequeueReusableCellWithIdentifier:@"incidentListCell" forIndexPath:indexPath];
        
        // Configure the cell...
        cell.textLabel.text = @"Incident List";
        //cell.detailTextLabel.text = @"More";
    }
    else if(indexPath.section==2){
        
        // this is for section 1:
        cell = [tableView dequeueReusableCellWithIdentifier:@"incidentCollectionCell" forIndexPath:indexPath];
        
        // Configure the cell...
        cell.textLabel.text = @"Incident ThumbMaps";
        //cell.detailTextLabel.text = @"More";
    }
    else {//if(indexPath.section==3){
        
        // this is for section 1:
        cell = [tableView dequeueReusableCellWithIdentifier:@"settingsCell" forIndexPath:indexPath];
        
        // Configure the cell...
        cell.textLabel.text = @"Settings";
        //cell.detailTextLabel.text = @"More";
    }
    
    return cell;
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
    
    if([segue.identifier isEqualToString:@"IncidentListSegue"]) {
        TableViewController *tvc = segue.destinationViewController;
        [self.navigationController pushViewController:tvc animated:YES];
    }
    else if([segue.identifier isEqualToString:@"IncidentMapSegue"]) {
        MapViewController *mvc = segue.destinationViewController;
        [self.navigationController pushViewController:mvc animated:YES];
    }
    
    /*
    // checks if desitnation is view controller
    BOOL isIncidentVC = [[segue destinationViewController] isKindOfClass:[IncidentViewController class]];
    BOOL isTVC = [[segue destinationViewController] isKindOfClass:[TableViewController class]];
    
    if(isIncidentVC) {
        
        UITableViewCell* cell = (UITableViewCell*)sender;
        IncidentViewController *vc =  [segue destinationViewController];
        
        //vc.imageName = cell.textLabel.text;
    }
    else if(isTVC){
        
    }
    
    else
    {
        
    }
     */
}

@end
