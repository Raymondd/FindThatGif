//
//  MainViewController.h
//  Lab1
//
//  Created by ch484-mac6 on 2/4/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import "ViewController.h"

@interface MainViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, retain) IBOutlet UICollectionView *myCollectionView;
@end
