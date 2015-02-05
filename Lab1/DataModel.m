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

-(NSMutableArray*) getTrendingGIFS{
    NSMutableArray* gifs = [NSMutableArray arrayWithCapacity:self.limit];
    
    // construct url for trending request and make request
    NSString *apiURL = @"http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC";
    NSURL *url = [NSURL URLWithString:apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             
             for(NSInteger i = 0;i < self.limit; i++ ) {
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

-(NSMutableArray*) getRandomGIFS{
    NSMutableArray* gifs = [NSMutableArray arrayWithCapacity:self.limit];
    return gifs;
}

-(NSMutableArray*) getGIFS: (NSString*)searchTerm{
    NSMutableArray* gifs = [NSMutableArray arrayWithCapacity:self.limit];
    return gifs;
}






@end
