//
//  IncidentTypeTableViewCell.m
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import "IncidentTypeTableViewCell.h"

@interface IncidentTypeTableViewCell ()
{
    NSArray *_pickerData;
}
@end

@implementation IncidentTypeTableViewCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Initialize Data
    _pickerData = @[@"All Incident Types", @"Construction", @"Event", @"Congestion", @"Accidents", @"Construction & Accidents"];
    
    // Connect data
    self.incidentType.dataSource = self;
    self.incidentType.delegate = self;
    
    [self.incidentType selectRow:0 inComponent:0 animated:YES];
}


// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    @try {
        
        NSDictionary *dic = @{
                              @"type" : [NSNumber numberWithLong:row]
                              };
        
        NSLog([dic valueForKey:@"type"]);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"incidenType" object:self userInfo:dic];
    }
    @catch (NSException *exception) {
        NSLog(exception.debugDescription);
    }

}

@end
