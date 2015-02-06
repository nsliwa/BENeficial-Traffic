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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // self looks at current class
    //if(section == 0)
    return 5;
    //else
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell* cell = nil;
    
    if (indexPath.section==0) {
        cell = [[RadiusSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"radiusCell"];
    }
    else if(indexPath.section==1) {
        cell = [[NumIncidentsSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"numIncidentCell"];
    }
    else if(indexPath.section==2) {
        cell = [[IncidentTypeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"incidentTypeCell"];
    }
    else if(indexPath.section==3) {
        cell = [[SeverityTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"severityCell"];
    }
    else if(indexPath.section==4) {
        cell = [[DisableUpdateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"disableUpdateCell"];
    }
    else if(indexPath.section==5) {
        cell = [[UpdateNowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"updateNowCell"];
    }
    
    return cell;
    
}

@end
