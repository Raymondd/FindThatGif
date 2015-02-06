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
    });
    
    _sharedInstance.limit = 10;
    
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
         NSLog(@"request completed");
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

-(NSString*) getTrendingGIFURLWithOffest:(NSInteger)row{
    _returnURL = [NSString stringWithFormat: @"http://api.giphy.com/v1/gifs/trending?api_key=dc6zaTOxFJmzC&limit=1&offset=%ld", (long)row];
    return _returnURL;
}

-(NSString*) getSearchGIFURLWithOffest:(NSInteger)row withTerm:(NSString*)searchTerm{
    _returnURL = [NSString stringWithFormat: @"http://api.giphy.com/v1/gifs/search?api_key=dc6zaTOxFJmzC&limit=1&q=%@&offset=%ld", searchTerm, (long)row];
    NSLog(_returnURL);
    return _returnURL;
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
