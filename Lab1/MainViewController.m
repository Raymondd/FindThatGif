//
//  MainViewController.m
//  Lab1
//
//  Created by ch484-mac6 on 2/4/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import "MainViewController.h"
#import "DataModel.h"
#import "GifCollectionViewCell.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)indexChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@property (weak, nonatomic) IBOutlet UILabel *clock;
@property (strong, nonatomic) DataModel *myDataModel;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollView;
@property int currentTime;
@property int refreshTime;

-(void)loadTrendingOrSearchGif:(NSIndexPath*) indexPath GifCell:(GifCollectionViewCell*)cell GIFURL:(NSString*)url;
-(void)loadRandomGif:(NSIndexPath*) indexPath GifCell:(GifCollectionViewCell*)cell;

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //setting our delegate to dismiss keyboard
    self.searchBar.delegate = self;
    
    //creating a timer
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0
                                              target: self
                                            selector: @selector(onTick:)
                                            userInfo: nil
                                             repeats: YES];
    //change this using the dataModel
    _refreshTime = self.myDataModel.refreshRate;
    _currentTime = 0;
    
    //settings our delegate and data source for our collection view
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [self.myCollectionView reloadData];
}

-(DataModel*) myDataModel{
    if(!_myDataModel){
        _myDataModel = [DataModel sharedInstance];
    }
    
    return _myDataModel;
}

-(void)onTick:(NSTimer *) theTimer
{
    if(_myDataModel.shouldRefresh){
        int time = _refreshTime - _currentTime;
        self.clock.text = [NSString stringWithFormat:@"%d", time];
    
        if(time < 1){
            //refresh the pictures
            _currentTime = 0;
            [self.myCollectionView reloadData];
            _refreshTime = self.myDataModel.refreshRate;
        }else{
            _currentTime++;
        }
    }else{
        self.clock.text = @"Refresh Off";
    }
}


-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    [self.myCollectionView reloadData];
    [self.myCollectionView setContentOffset:CGPointZero animated:NO];
}

//function to close keybaord when return is hit
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.myDataModel.history addObject:self.searchBar.text];
    [self.myCollectionView reloadData];
    [self.myCollectionView setContentOffset:CGPointZero animated:NO];
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    //NSArray* sectionArray = [_data objectAtIndex:section];
    return self.myDataModel.numToLoad;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     GifCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    // Configure the cell
    cell.backgroundColor = [UIColor whiteColor];
    
    
    //URLs are formatted using our datamodel
    NSString *stringURL;
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            stringURL = [self.myDataModel getTrendingGIFURLWithOffest:indexPath.row];
            [self loadTrendingOrSearchGif:indexPath GifCell:cell GIFURL:stringURL];
            break;
        case 1:
            [self loadRandomGif:indexPath GifCell:cell];
            break;
        case 2:
        {
            NSString* searchTerm = self.searchBar.text;
            stringURL = [self.myDataModel getSearchGIFURLWithOffest:indexPath.row withTerm:searchTerm];
            [self loadTrendingOrSearchGif:indexPath GifCell:cell GIFURL:stringURL];
            break;
        }
        default:
            break;
    }
    
    
    return cell;

}

-(void)loadTrendingOrSearchGif:(NSIndexPath*) indexPath GifCell:(GifCollectionViewCell*)cell GIFURL:(NSString*)stringURL{
    
    
    NSURL *url = [NSURL URLWithString: stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             if([[greeting valueForKeyPath:@"pagination.count"] integerValue] == 0) {
                 cell.imageView.image = [UIImage imageNamed:@"not-found"];
             } else {
                 
                 NSString *path = [[greeting valueForKey:@"data"][0] valueForKeyPath: @"images.fixed_width.url"];
                 // load gif
                 FLAnimatedImage *myGif = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
                 cell.imageView.animatedImage = myGif;
             }
             
         }
     }];
    return;
}

-(void)loadRandomGif:(NSIndexPath*) indexPath GifCell:(GifCollectionViewCell*)cell {
    NSString* stringURL = [self.myDataModel getRandomGIFURL];
    NSURL *url = [NSURL URLWithString: stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             
             NSString *path = [greeting valueForKeyPath:@"data.image_url"];
             // load gif
             FLAnimatedImage *myGif = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
             cell.imageView.animatedImage = myGif;
         }
     }];
    return;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
