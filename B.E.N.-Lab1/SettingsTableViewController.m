//
//  SettingsTableViewController.m
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "RadiusSettingTableViewCell.h"
#import "NumIncidentsSettingTableViewCell.h"
#import "IncidentTypeTableViewCell.h"
#import "SeverityTableViewCell.h"
#import "DisableUpdateTableViewCell.h"
#import "UpdateNowTableViewCell.h"
#import "MapQuestCommunicator.h"
#import "TrafficIncidentModel.h"

@interface SettingsTableViewController()

@property NumIncidentsSettingTableViewCell* numIncidentCell;



@end

@implementation SettingsTableViewController

/*- (IBAction)sliderChanged:(UISlider *)sender {
    
    //[sender addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    
    //self.numIncidentsLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    
}*/

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changedIncidentType:)
                                                 name:@"incidentTypeSelected"
                                               object:nil];
    
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // self looks at current class
    //if(section == 0)
    return 1;
    //else
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell* cell = nil;
    @try {
   
    if (indexPath.section==0) {
        RadiusSettingTableViewCell *radiusCell = nil;
        radiusCell = [tableView dequeueReusableCellWithIdentifier:@"radiusCell" forIndexPath:indexPath];
        
        [radiusCell.radiusSlider addTarget:self
                                    action:@selector(radiusChanged:)
                          forControlEvents:UIControlEventTouchUpInside];
        
        return radiusCell;
    }
    else if(indexPath.section==1) {
        NumIncidentsSettingTableViewCell *numIncidentCell = nil;
        numIncidentCell = [tableView dequeueReusableCellWithIdentifier:@"numIncidentCell" forIndexPath:indexPath];
        _numIncidentCell = numIncidentCell;
        
        numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)numIncidentCell.numIncidentsStepper.value];
        
        [numIncidentCell.numIncidentsStepper addTarget:self
                                                 action:@selector(stepperChanged:)
                                       forControlEvents:UIControlEventTouchUpInside];
        
        
        return numIncidentCell;
    }
    else if(indexPath.section==3) {
        IncidentTypeTableViewCell* incidentTypeCell = nil;
        
        incidentTypeCell = [tableView dequeueReusableCellWithIdentifier:@"incidentTypeCell" forIndexPath:indexPath];
        /*
        [incidentTypeCell.incidentType  addTarget:self
                                                 action:@selector(incidentTypeChanged:)
                                       forControlEvents:UIControlEventValueChanged];
        */
        return incidentTypeCell;
    }
    else if(indexPath.section==2) {
        SeverityTableViewCell* severityCell = nil;
        severityCell = [tableView dequeueReusableCellWithIdentifier:@"severityCell" forIndexPath:indexPath];
        
        [severityCell.minimumSeveritySegment addTarget:self
                                                 action:@selector(severityChanged:)
                                       forControlEvents:UIControlEventValueChanged];
        
        return severityCell;
    }
    else if(indexPath.section==4) {
        DisableUpdateTableViewCell* disableUpdateCell = nil;
        disableUpdateCell = [tableView dequeueReusableCellWithIdentifier:@"disableUpdateCell" forIndexPath:indexPath];
        
        [disableUpdateCell.disableUpdateSwitch addTarget:self
                                                  action:@selector(navigationUpdaterToggled:)
                                        forControlEvents:UIControlEventTouchUpInside];
        
        return disableUpdateCell;
    }
    else {
        UpdateNowTableViewCell* updateNowCell = nil;
        updateNowCell = [tableView dequeueReusableCellWithIdentifier:@"updateButtonCell" forIndexPath:indexPath];
        
        [updateNowCell.updateNowButton addTarget:self
                                                 action:@selector(updateNowPressed:)
                                       forControlEvents:UIControlEventTouchUpInside];
        
        return updateNowCell;
    }
    }
    @catch (NSException *exception) {
        NSLog(@"EXCEEEPPPTION: %@", exception.debugDescription);
    }
    
    
}

-(IBAction)radiusChanged:(UISlider*)sender
{
    [MapquestCommunicator setMapRadius:sender.value];
    NSLog(@"radius val: %f", [MapquestCommunicator radius]);
    /*
    @try {
        NSDictionary *dic = @{
                              @"radius" : [NSNumber numberWithFloat:sender.value]
                              };
        
        NSLog([dic valueForKey:@"radius"]);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radiusChanged" object:self userInfo:dic];
    }
    @catch (NSException *exception) {
        NSLog(exception.debugDescription);
    }*/
    
}

-(IBAction)stepperChanged:(UIStepper*)sender{
    _numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)sender.value];
    
    [TrafficIncidentModel setIncidentLimit:(int)sender.value];
    NSLog(@"incident limit val: %d, %d", (int)sender.value, [TrafficIncidentModel incidentLimit]);
    /*
    @try {
        
        NSDictionary *dic = @{
                          @"number" : [NSNumber numberWithInt:sender.value]
                          };
    
        NSLog([dic valueForKey:@"number"]);
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"numIncidents" object:self userInfo:dic];
    }
        @catch (NSException *exception) {
        NSLog(exception.debugDescription);
    }
     */
}

-(IBAction)navigationUpdaterToggled:(UISwitch*)sender
{
    if (sender.on) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"turnOnLocationManager" object:self];
        
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"turnOffLocationManager" object:self];
    }
}

-(IBAction)severityChanged:(id)sender{
    //_numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)sender.value];
    
    UISegmentedControl *segment=(UISegmentedControl*)sender;
    
    [TrafficIncidentModel setSeverityLimit:(int)segment.selectedSegmentIndex];
    NSLog(@"severity limit val: %d, %d", (int)segment.selectedSegmentIndex, [TrafficIncidentModel severityLimit]);

}
/*
-(IBAction)incidentTypeChanged:(UIStepper*)sender{
    //_numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)sender.value];
    
    [TrafficIncidentModel setIncidentTypeLimit:(int)sender.value];
    NSLog(@"incident type limit val: %d, %d", (int)sender.value, [TrafficIncidentModel incidentTypeLimit]);
    
}
*/

-(IBAction)updateNowPressed:(UIStepper*)sender{
    //_numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)sender.value];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"turnOffLocationManager" object:self];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"turnOnLocationManager" object:self];
    
    NSLog(@"button pressed!!!!");
    
}


- (void)changedIncidentType:(NSNotification *)notification {
    //[self.locationManager startUpdatingLocation];
    
    [TrafficIncidentModel setIncidentTypeLimit:[[notification.userInfo valueForKey:@"type"] floatValue]];

    NSLog(@"incident type limit val: %d, %d", [[notification.userInfo valueForKey:@"type"] floatValue], [TrafficIncidentModel incidentTypeLimit]);

}
@end
