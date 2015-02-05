//
//  IncidentTableViewCell.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/3/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IncidentTableViewCell : UITableViewCell
    @property (weak, nonatomic) IBOutlet UILabel *locationLabel;
    @property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
    @property (weak, nonatomic) IBOutlet UIImageView *severityImageView;

@end
