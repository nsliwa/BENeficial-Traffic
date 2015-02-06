//
//  CitiesViewController.h
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ModalViewControllerDelegate <NSObject>
-(void)didDismissModalView;
-(void)didSelectCity:(NSString*) city;
@end

@interface CitiesViewController : UIViewController

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString* selectedCity;

@end



