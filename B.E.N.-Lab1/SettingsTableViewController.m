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
        RadiusSettingTableViewCell* radiusCell = nil;
        radiusCell = [tableView dequeueReusableCellWithIdentifier:@"radiusCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
        return radiusCell;
    }
    else if(indexPath.section==1) {
        NumIncidentsSettingTableViewCell* numIncidentCell = nil;
        numIncidentCell = [tableView dequeueReusableCellWithIdentifier:@"numIncidentCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
        return numIncidentCell;
        //cell = [[NumIncidentsSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"numIncidentCell"];
    }
    else if(indexPath.section==2) {
        IncidentTypeTableViewCell* incidentTypeCell = nil;
        incidentTypeCell = [tableView dequeueReusableCellWithIdentifier:@"incidentTypeCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
        return incidentTypeCell;
        //cell = [[IncidentTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incidentTypeCell"];
    }
    else if(indexPath.section==3) {
        SeverityTableViewCell* severityCell = nil;
        severityCell = [tableView dequeueReusableCellWithIdentifier:@"severityCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
        return severityCell;
        //cell = [[SeverityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"severityCell"];
    }
    else if(indexPath.section==4) {
        DisableUpdateTableViewCell* disableUpdateCell = nil;
        disableUpdateCell = [tableView dequeueReusableCellWithIdentifier:@"disableUpdateCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
        return disableUpdateCell;
        //cell = [[DisableUpdateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"disableUpdateCell"];
    }
    else { //if(indexPath.section==5) {
        UpdateNowTableViewCell* updateNowCell = nil;
        updateNowCell = [tableView dequeueReusableCellWithIdentifier:@"updateButtonCell" forIndexPath:indexPath];
        //cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
        return updateNowCell;
        //cell = [[UpdateNowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"updateNowCell"];
    }
    }
    @catch (NSException *exception) {
        NSLog(exception.debugDescription);
    }
    
    //return cell;
    
}

@end
