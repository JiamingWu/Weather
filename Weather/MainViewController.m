//
//  MainViewController.m
//  Weather
//
//  Created by Allen on 2014/1/14.
//  Copyright (c) 2014年 Allen. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self refreshView:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

- (IBAction)refreshView:(id)sender
{
    [loadingIndicator startAnimating];
    [self.forecast queryService:@"2306179" withParent:self];
}

- (void)updateView
{
    [loadingIndicator stopAnimating];
    nameLabel.text = self.forecast.location;
    dateLabel.text = self.forecast.date;
    nowTempLabel.text = self.forecast.temp;
    
    NSURL *url = [NSURL URLWithString:self.forecast.icon];
    NSData *data = [NSData dataWithContentsOfURL:url];
    nowImage.image = [[UIImage alloc]initWithData:data];
}

@end
