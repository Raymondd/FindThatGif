//
//  RefreshViewController.m
//  Lab1
//
//  Created by ch484-mac6 on 2/4/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import "RefreshViewController.h"
#import "DataModel.h"

@interface RefreshViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *refSwitch;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIStepper *timeStepper;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UIPickerView *maturityPicker;
@property (weak, nonatomic) IBOutlet UILabel *rateText;
@property (weak, nonatomic) IBOutlet UILabel *returns;
@property (weak, nonatomic) IBOutlet UIPickerView *matPicker;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) DataModel *myDataModel;
- (IBAction)sliderChanged:(UISlider *)sender;
- (IBAction)refreshSwitched:(UISwitch *)sender;
- (IBAction)stepped:(UIStepper *)sender;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.matPicker.dataSource = self;
    self.matPicker.delegate = self;
    _pickerData = @[@"y", @"g", @"pg-13", @"r"];
    
    //setting previously held values
    self.time.text = @"10";
    self.timeStepper.value = 10;
    self.returns.text = @"10";
    
}

//lazy instantiation of the data model
-(DataModel*) myDataModel{
    if(!_myDataModel){
        _myDataModel = [DataModel sharedInstance];
    }
    
    return _myDataModel;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sliderChanged:(UISlider *)sender {
    self.returns.text = [NSString stringWithFormat:@"%d", ((int) (self.timeSlider.value * 20))];
}

- (IBAction)refreshSwitched:(UISwitch *)sender {
    //here is where we would turn the refresh either on or off
    if(self.refSwitch.on){
        self.rateText .textColor  = [UIColor blackColor];
        self.time.textColor = [UIColor blackColor];
        _myDataModel.shouldRefresh = YES;
    }else{
        self.rateText .textColor  = [UIColor grayColor];
        self.time.textColor = [UIColor grayColor];
        _myDataModel.shouldRefresh = NO;
    }
    
}

- (IBAction)stepped:(UIStepper *)sender {
    double value = [sender value];
        
    [self.time setText:[NSString stringWithFormat:@"%d", (int)value]];
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

@end
