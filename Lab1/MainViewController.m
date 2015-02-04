//
//  MainViewController.m
//  Lab1
//
//  Created by ch484-mac6 on 2/4/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)indexChanged:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UILabel *identityLabel;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //setting up idenitity lable for debugging purposes
    self.identityLabel.text = @"Trending";
    
    //setting our delegate to dismiss keyboard
    self.searchBar.delegate = self;
    
    //creating a timer
}


-(IBAction)indexChanged:(UISegmentedControl *)sender
{
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            self.identityLabel.text = @"Trending";
            break;
        case 1:
            self.identityLabel.text = @"Random";
            break;
        case 2:
            self.identityLabel.text = @"Search";
            break;
        default:
            break;
    }
}

//function to close keybaord when return is hit
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
