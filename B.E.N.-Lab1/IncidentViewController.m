//
//  IncidentViewController.m
//  B.E.N.-Lab1
//
//  Created by Bre'Shard Busby on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "IncidentViewController.h"
#import "TrafficIncident.h"

@interface IncidentViewController () <UIScrollViewDelegate>
    @property (weak, nonatomic) IBOutlet UIImageView *IncidentThumbMap;
    @property (weak, nonatomic) IBOutlet UITextField *IncidentRoadName;
    @property (weak, nonatomic) IBOutlet UITextView *IncidentDescription;
    @property (weak, nonatomic) IBOutlet UITextField *IncidentSeverity;
    @property (weak, nonatomic) IBOutlet UITextField *IncidentDelay;
    @property (weak, nonatomic) IBOutlet UITextField *IncidentType;
    @property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

    @property (weak, nonatomic) UIView * collectionView;
@end

@implementation IncidentViewController


-(TrafficIncident*)incident {
    if(!_incident)
        _incident = nil;
    
    return _incident;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // old image loading
    //self.imageView.image = [self.myImageModel getImageWithName:self.imageName];
    
    self.IncidentThumbMap.image = self.incident.thumbMap;
    self.IncidentRoadName.text = self.incident.roadName;
    self.IncidentDescription.text = self.incident.fullDesc;
    self.IncidentSeverity.text = [NSString stringWithFormat:@"%ld",(long)self.incident.severity];
    self.IncidentDelay.text = [NSString stringWithFormat:@"%ld",(long)self.incident.delayFromTypical ];
    
    if(self.incident.type == 0) {
        self.IncidentType.text = @"Construction";
    }
    else if(self.incident.type == 1) {
        self.IncidentType.text = @"Event";
    }
    else if(self.incident.type == 2) {
        self.IncidentType.text = @"Congestion or Flow";
    }
    else {
        self.IncidentType.text = @"Incident or Accident";
    }
    
    [self.collectionView addSubview:self.IncidentRoadName];
    [self.collectionView addSubview:self.IncidentDescription];
    [self.collectionView addSubview:self.IncidentSeverity];
    [self.collectionView addSubview:self.IncidentDelay];
    [self.collectionView addSubview:self.IncidentType];
    
    [self.scrollView addSubview:self.collectionView];
    self.scrollView.contentSize = CGSizeMake(300, 300);
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.delegate = self;
    
}

@end
