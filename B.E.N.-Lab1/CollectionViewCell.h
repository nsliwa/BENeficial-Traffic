//
//  CollectionViewCell.h
//  B.E.N.-Lab1
//
//  Created by ch484-mac4 on 2/6/15.
//  Copyright (c) 2015 Team B.E.N. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *descView;

@end
