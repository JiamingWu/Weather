//
//  MainViewController.h
//  Weather
//
//  Created by Allen on 2014/1/14.
//  Copyright (c) 2014年 Allen. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>
{
    IBOutlet UIActivityIndicatorView *loadingIndicator;
    
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *dateLabel;
    
    IBOutlet UIImageView *nowImage;
    IBOutlet UILabel *nowTempLabel;
    
    IBOutlet UIButton *refreshButton;
}

- (IBAction)refreshView:(id)sender;
- (void)updateView;

@end
