//
//  IncidentTypeTableViewCell.h
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/5/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncidentTypeTableViewCell : UITableViewCell<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *incidentType;
@property (weak, nonatomic) IBOutlet UITextField *incidentLabel;


@end
