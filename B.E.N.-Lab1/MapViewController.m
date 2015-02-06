//
//  MapViewController.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//
// Much adapted from flipped-classroom lectures
// IncidentManagerDelegate functions from: http://code.tutsplus.com/tutorials/ios-sdk-working-with-nsuserdefaults--mobile-6039
// modal view stuff from: http://useyourloaf.com/blog/2010/05/03/ipad-modal-view-controllers.html, http://useyourloaf.com/blog/2012/10/08/presenting-view-controllers.html
//

#import "MapViewController.h"
#import "TrafficIncidentModel.h"
#import "LocationParser.h"
#import "MapQuestCommunicator.h"
#import "IncidentManager.h"
#import "CitiesViewController.h"

@interface MapViewController ()

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
CitiesViewController *addController;

- (IBAction)changeCitiesPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    addController = [storyboard instantiateViewControllerWithIdentifier:@"cityViewModal"];
    
    
    addController.delegate = self;
    
    [addController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:addController animated:YES completion:nil];
//    
//    addController = [[CitiesViewController alloc]
//                                           initWithNibName:@"cityViewModal"
//                                            bundle:nil];
    
    
    
//    
//    UINavigationController *navigationController = [[UINavigationController alloc]
//                                                    initWithRootViewController:addController];
    
//    navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
//    navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//
//    [self presentViewController:navigationController animated:YES completion:nil];
    
}

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

-(void)didDismissModalView {
    NSLog(@"mapview - did dissmis modal");
    
    NSString* city = addController.selectedCity;
    if(![city isEqualToString:@""]) {
        CLLocationCoordinate2D coord = [MapquestCommunicator getCoordinateByLocation:city];
        self.imageView = [[UIImageView alloc] initWithImage:[MapquestCommunicator getIncidentMap:coord.latitude lng:coord.longitude ]];
        
        
        
        NSLog(@"got the city!!!!!, %f, %f", coord.latitude, coord.longitude);
    }
        
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didSelectCity:(NSString *)city {
    CLLocationCoordinate2D coord = [MapquestCommunicator getCoordinateByLocation:city];
    self.imageView = [[UIImageView alloc] initWithImage:[MapquestCommunicator getIncidentMap:coord.latitude lng:coord.longitude ]];
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
    
    addController.delegate = self;
    
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
