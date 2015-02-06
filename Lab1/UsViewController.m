//
//  UsViewController.m
//  Lab1
//
//  Created by ch484-mac6 on 2/6/15.
//  Copyright (c) 2015 Microsloths. All rights reserved.
//

#import "UsViewController.h"

@interface UsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@end

@implementation UsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myImageView.image = [UIImage imageNamed:@"us.png"];
    self.myScrollView.contentSize = self.myImageView.image.size;
    self.myImageView.frame = CGRectMake(0, 0, self.myImageView.image.size.width, self.myImageView.image.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.myImageView;
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
