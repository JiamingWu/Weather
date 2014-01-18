//
//  WeatherForecast.h
//  Weather
//
//  Created by Allen on 2014/1/15.
//  Copyright (c) 2014年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MainViewController;

@interface WeatherForecast : NSObject {
    MainViewController *viewController;
    
    NSMutableData *responseData;
    NSURL *theURL;
}

@property (weak, nonatomic) NSString *location;
@property (weak, nonatomic) NSString *date;

@property (weak, nonatomic) NSString *icon;
@property (weak, nonatomic) NSString *temp;

-(void)queryService:(NSString *)city withParent:(UIViewController *)controller;

@end
