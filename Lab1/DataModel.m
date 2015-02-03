//
//  DataModel.m
//  Lab1
//
//  Created by ch484-mac6 on 2/2/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

//gets the shared instance of our model
+(DataModel*) getSharedInstance{
    static DataModel* _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    //if we have not allocated space for our model yet, we do so,
    //otherwise we return the pointer
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DataModel alloc] init];
    });
    
    return _sharedInstance;
}





@end
