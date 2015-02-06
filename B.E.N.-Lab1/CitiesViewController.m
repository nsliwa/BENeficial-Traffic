//
//  CitiesViewController.m
//  B.E.N.-Lab1
//
//  Created by Nicole Sliwa on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//
//// modal view stuff from: http://useyourloaf.com/blog/2010/05/03/ipad-modal-view-controllers.html, http://useyourloaf.com/blog/2012/10/08/presenting-view-controllers.html
//

#import "CitiesViewController.h"

@interface CitiesViewController()<UITableViewDataSource, UITableViewDelegate>
    @property (strong, nonatomic) UITableViewCell* city;
@property (weak, nonatomic) IBOutlet UITableView *cities;
@end

@implementation CitiesViewController

- (IBAction)didCancelView:(id)sender {
    NSLog(@"did dismiss modal view");
    [self.delegate didDismissModalView];
}

-(NSString *)selectedCity {
    if(!_selectedCity)
        _selectedCity = @"";
    
    return _selectedCity;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell=[tableView cellForRowAtIndexPath:indexPath];
    self.selectedCity = selectedCell.textLabel.text;
    
    [self.delegate didDismissModalView];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"in modal view load!");
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                              target:self
                                              action:@selector(dismissView:)];
    self.cities.dataSource = self;
    self.cities.delegate = self;
    
}

-(void)didDismissModalView:(id)sender{
    [self.delegate didDismissModalView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSLog(@"in modal view sect!");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"in modal view row!");
    return 3;
}

// Need to uncomment!!
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _city = nil;
    _city = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    
    NSLog(@"in modal view pop!");
    
    if(indexPath.row==0) {
        _city.textLabel.text = @"Seattle, WA";
    }
    else if(indexPath.row==1) {
        _city.textLabel.text = @"Tampa, FL";
    }
    else if(indexPath.row==2) {
        _city.textLabel.text = @"Baltimore, MD";
    }
    return _city;
    
}


@end
