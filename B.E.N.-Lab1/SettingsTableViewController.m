//
//  SettingsTableViewController.m
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController () <UIPickerViewDelegate>
    @property (weak, nonatomic) IBOutlet UISlider *radiusSlider;
    @property (weak, nonatomic) IBOutlet UIStepper *numIncidentsStepper;
    @property (weak, nonatomic) IBOutlet UITextField *numIncidentsLabel;
    @property (weak, nonatomic) IBOutlet UISegmentedControl *incidentTypeSegmentControl;
    @property (weak, nonatomic) IBOutlet UIPickerView *severityPicker;
    @property (weak, nonatomic) IBOutlet UISwitch *disableUpdateSwitch;
    @property (weak, nonatomic) IBOutlet UIButton *updateNowButton;
@end

@implementation SettingsTableViewController

/*- (IBAction)sliderChanged:(UISlider *)sender {
    
    //[sender addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    
    //self.numIncidentsLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    
}*/

-(void) viewDidLoad {
    [super viewDidLoad];
    
    //self.radiusSlider.minimumValue = 0;
    //self.radiusSlider.maximumValue = 20;
    
    //self.incidentTypeSegmentControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Construction", @"Event", @"Congestion", @"Accident"]];
    
    //[self.disableUpdateSwitch setOn:YES animated:YES];
    
}

@end
