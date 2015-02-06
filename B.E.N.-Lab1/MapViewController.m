//
//  MapViewController.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "MapViewController.h"
#import "TrafficIncidentModel.h"
#import "LocationParser.h"
#import "MapQuestCommunicator.h"
#import "IncidentManager.h"

@interface MapViewController () <UIScrollViewDelegate>

// much easier to set up image view programatically
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImageView* imageView;


// replace image view in story board with scroll view
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


// get instance of shared model - make it a property
@property (strong, nonatomic) TrafficIncidentModel* trafficModel;

@property (weak, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) IncidentManager* manager;

@property (strong, nonatomic) NSArray* incidents;

@end


@implementation MapViewController

-(TrafficIncidentModel*)trafficModel{
    if(!_trafficModel)
        _trafficModel = [TrafficIncidentModel incidents];
    
    return _trafficModel;
}

-(UIImageView*)imageView{
    if(!_imageView) {
        CLLocationCoordinate2D coordinate = self.locationManager.location.coordinate;
        _imageView = [[UIImageView alloc] initWithImage:[MapquestCommunicator getIncidentMap:coordinate.latitude lng:coordinate.longitude]];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // old image loading
    //self.imageView.image = [self.myImageModel getImageWithName:self.imageName];
    
    [self.scrollView addSubview:self.imageView];
    self.scrollView.contentSize = self.imageView.image.size;
    self.scrollView.minimumZoomScale = 0.8;
    self.scrollView.maximumZoomScale = 10.0;
    self.scrollView.delegate = self;
    
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


// functions for scroll view delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
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

#pragma mark - IncidentManagerDelegate implementation

-(void)didReceiveIncidents:(NSArray *)incidents {
    
    NSLog(@"did load incidents");
    
}

-(void)fetchingIncidentsFailedWithError:(NSError *)error {
    
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
    
}


@end
