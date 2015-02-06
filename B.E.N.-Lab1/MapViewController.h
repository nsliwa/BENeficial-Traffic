//
//  MapViewController.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CitiesViewController.h"

@interface MapViewController : UIViewController <UIScrollViewDelegate, ModalViewControllerDelegate>

@property (nonatomic,retain) IBOutlet UIButton *button;

//-(IBAction)changeCitiesPressed:(id)sender;

@end
