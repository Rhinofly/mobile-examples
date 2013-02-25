//
//  PhotoGridCell.h
//  PhotoGrid
//
//  Created by Johan Haneveld on 1/29/13.
//  Copyright (c) 2013 Rhinofly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoGridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
