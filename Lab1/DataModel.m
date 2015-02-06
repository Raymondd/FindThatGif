//
//  DataModel.m
//  Lab1
//
//  Created by ch484-mac6 on 2/2/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import "DataModel.h"
@interface DataModel()
@property (strong, nonatomic) NSString* returnURL;
@property (strong, nonatomic) NSArray* pickerData;

@end

@implementation DataModel

//gets the shared instance of our model
+(DataModel*) sharedInstance{
    static DataModel* _sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    //if we have not allocated space for our model yet, we do so,
    //otherwise we return the pointer
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DataModel alloc] init];
        _sharedInstance.numToLoad = 1;
        _sharedInstance.refreshRate =10;
        _sharedInstance.maturityRating = 3;
        _sharedInstance.shouldRefresh = NO;
        _sharedInstance.history = [[NSMutableArray alloc] initWithCapacity:20];
        _sharedInstance.pickerData = @[@"y", @"g", @"pg-13", @"r"];
    });
    
    
    return _sharedInstance;
}
-(NSMutableArray*) getTrendingGIFS{
    NSMutableArray* gifs = [NSMutableArray arrayWithCapacity:self.numToLoad];
    
    // construct url for trending request and make request
    NSString *apiURL = @"http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC";
    NSURL *url = [NSURL URLWithString:apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         NSLog(@"request completed");
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             
             for(NSInteger i = 0;i < self.numToLoad; i++ ) {
                 // get path to GIF and push onto gif array
                 NSString *path = [[greeting valueForKey:@"data"][i] valueForKeyPath: @"images.fixed_width.url"];
                 NSURL *dataURL = [NSURL URLWithString:path];
                 NSData *gifData = [NSData dataWithContentsOfURL:dataURL];
                 FLAnimatedImage *gif = [[FLAnimatedImage alloc] initWithAnimatedGIFData:gifData];
                 [gifs insertObject:gif atIndex:i];
             }

         }
         
     }];
    return gifs;

    
}


-(NSString*) getTrendingGIFURLWithOffest:(NSInteger)row{
    _returnURL = [NSString stringWithFormat: @"http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=1&offset=%ld&rating=%@", (long)row, self.pickerData[self.maturityRating]];
    return _returnURL;
}

-(NSString*) getRandomGIFURL{
    _returnURL = [NSString stringWithFormat: @"http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&rating=%@", self.pickerData[self.maturityRating]];
    return _returnURL;
}

-(NSString*) getSearchGIFURLWithOffest:(NSInteger)row withTerm:(NSString*)searchTerm{
    NSString * formattedSearchString = [searchTerm stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    _returnURL = [NSString stringWithFormat: @"http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC&limit=1&q=%@&offset=%ld&rating=%@", formattedSearchString, (long)row, self.pickerData[self.maturityRating]];
    return _returnURL;
}

-(NSMutableArray*) getRandomGIFS{
    NSMutableArray* gifs = [NSMutableArray arrayWithCapacity:self.numToLoad];
    return gifs;
}

-(NSMutableArray*) getGIFS: (NSString*)searchTerm{
    NSMutableArray* gifs = [NSMutableArray arrayWithCapacity:self.numToLoad];
    return gifs;
}






@end
