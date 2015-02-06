//
//  DataModel.h
//  Lab1
//
//  Created by ch484-mac6 on 2/2/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLAnimatedImage.h"
#import "FLAnimatedImageView.h"
#import "UIKit/UIKit.h"

@interface DataModel : NSObject

@property (nonatomic) NSInteger limit;
@property (strong, nonatomic) NSMutableArray* history;
@property (nonatomic) NSInteger offset;
@property (strong, nonatomic) NSString* maturityRating;
@property (nonatomic) BOOL shouldRefresh;


+(DataModel*) sharedInstance;
-(NSMutableArray*) getTrendingGIFS;
-(NSMutableArray*) getRandomGIFS;
-(NSMutableArray*) getGIFS: (NSString*)searchTerm;
-(NSString*) getTrendingGIFURLWithOffest:(NSInteger)row;
-(NSString*) getSearchGIFURLWithOffest:(NSInteger)row withTerm:(NSString*)searchTerm;
@end
