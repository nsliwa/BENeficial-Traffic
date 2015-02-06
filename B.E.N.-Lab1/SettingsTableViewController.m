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
@property (nonatomic)  NSUserDefaults* defaults;

@end

@implementation SettingsTableViewController

/*- (IBAction)sliderChanged:(UISlider *)sender {
    
    //[sender addTarget:self action:@selector(sliderChanged) forControlEvents:UIControlEventValueChanged];
    
    //self.numIncidentsLabel.text = [NSString stringWithFormat:@"%f", sender.value];
    
}*/

-(void) viewDidLoad {
    
    if (!_defaults) {
        _defaults = [NSUserDefaults standardUserDefaults];
    
        NSNumber* radius = [NSNumber numberWithFloat:[MapquestCommunicator  radius]];
        NSNumber* numIncidents = [NSNumber numberWithInt:[TrafficIncidentModel  incidentLimit]];
        NSNumber* incidentType = [NSNumber numberWithInt:[TrafficIncidentModel incidentTypeLimit]];
        NSNumber* severity = [NSNumber numberWithInt:[TrafficIncidentModel severityLimit]];
    
        [_defaults setObject:radius forKey:@"radius"];
        [_defaults setObject:numIncidents forKey:@"numIncidents"];
        [_defaults setObject:incidentType forKey:@"incidentType"];
        [_defaults setObject:severity forKey:@"severity"];
        
    }
    
    
    [super viewDidLoad];
    
    /*[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changedRadiusLabel:)
                                                 name:@"radiusChanged"
                                               object:nil];*/
    
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
        
        radiusCell.radiusSlider.value = [_defaults floatForKey:@"radius"];
        
        NSLog(@"Default stepper is %f", (float)[_defaults floatForKey:@"radius"]);
        
        return radiusCell;
    }
    else if(indexPath.section==1) {
        _numIncidentCell = nil;
        _numIncidentCell = [tableView dequeueReusableCellWithIdentifier:@"numIncidentCell" forIndexPath:indexPath];
        
        _numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)_numIncidentCell.numIncidentsStepper.value];
        
        [_numIncidentCell.numIncidentsStepper addTarget:self
                                                 action:@selector(stepperChanged:)
                                       forControlEvents:UIControlEventTouchUpInside];
        
        _numIncidentCell.numIncidentsStepper.value = [_defaults integerForKey:@"numIncidents"];
        _numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)_numIncidentCell.numIncidentsStepper.value];
        
        NSLog(@"Default stepper is %ld", (long)[_defaults integerForKey:@"numIncidents"]);
        
        
        return _numIncidentCell;
    }
    else if(indexPath.section==3) {
        IncidentTypeTableViewCell* incidentTypeCell = nil;
        
        incidentTypeCell = [tableView dequeueReusableCellWithIdentifier:@"incidentTypeCell" forIndexPath:indexPath];
        
        return incidentTypeCell;
    }
    else if(indexPath.section==2) {
        SeverityTableViewCell* severityCell = nil;
        severityCell = [tableView dequeueReusableCellWithIdentifier:@"severityCell" forIndexPath:indexPath];
        
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
        
        
        return updateNowCell;
    }
    }
    @catch (NSException *exception) {
        NSLog(exception.debugDescription);
    }
    
    
}

-(void)radiusChanged:(UISlider*)sender
{
    NSNumber* newRadius = [NSNumber numberWithFloat:sender.value];
    [MapquestCommunicator setMapRadius:sender.value];
    /*[_defaults removeObjectForKey:@"radius"];
    [_defaults setObject:newRadius forKey:@"radius"];
    [_defaults synchronize];*/
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

-(void)stepperChanged:(UIStepper*)sender{
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

-(void)navigationUpdaterToggled:(UISwitch*)sender
{
    if (sender.on) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"turnOnLocationManager" object:self];
        
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"turnOffLocationManager" object:self];
    }
}

/*
- (void)changedRadiusLabel:(NSNotification *)notification {
    //[self.locationManager startUpdatingLocation];
    [MapquestCommunicator setMapRadius:[[notification.userInfo valueForKey:@"radius"] floatValue]];
    
    NSLog(@"radius label changed - notification");
}*/
@end
