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
                                             selector:@selector(changeRadiusLabel:)
                                                 name:@"radiusChanged"
                                               object:nil];
    
    
    
    
}

-(void) viewDidAppear:(BOOL)animated{
    
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
        _numIncidentCell = nil;
        _numIncidentCell = [tableView dequeueReusableCellWithIdentifier:@"numIncidentCell" forIndexPath:indexPath];
        
        _numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)_numIncidentCell.numIncidentsStepper.value];
        
        [_numIncidentCell.numIncidentsStepper addTarget:self
                                                 action:@selector(stepperChanged:)
                                       forControlEvents:UIControlEventTouchUpInside];
        
        
        return _numIncidentCell;
    }
    else if(indexPath.section==2) {
        IncidentTypeTableViewCell* incidentTypeCell = nil;
        incidentTypeCell = [tableView dequeueReusableCellWithIdentifier:@"incidentTypeCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
        return incidentTypeCell;
    }
    else if(indexPath.section==3) {
        SeverityTableViewCell* severityCell = nil;
        severityCell = [tableView dequeueReusableCellWithIdentifier:@"severityCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
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
    @try {
        NSDictionary *dic = @{
                              @"radius" : [NSNumber numberWithFloat:sender.value]
                              };
        
        NSLog([dic valueForKey:@"radius"]);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radiusChanged" object:self userInfo:dic];
    }
    @catch (NSException *exception) {
        NSLog(exception.debugDescription);
    }
    
}

-(void)stepperChanged:(UIStepper*)sender{
    _numIncidentCell.numIncidentsLabel.text = [NSString stringWithFormat:@"Number of incidents displayed: %d", (int)sender.value];
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

@end
