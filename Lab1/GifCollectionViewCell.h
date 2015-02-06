//
//  GifCollectionViewCell.h
//  Lab1
//
//  Created by ch484-mac6 on 2/4/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface GifCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageView;

@end
