//
//  WeatherForecast.m
//  Weather
//
//  Created by Allen on 2014/1/15.
//  Copyright (c) 2014年 Allen. All rights reserved.
//

#import "WeatherForecast.h"

@implementation WeatherForecast


-(void)queryService:(NSString *)city withParent:(UIViewController *)controller
{
    viewController = (MainViewController *)controller;
    responseData = [NSMutableData data];
    
    NSString *url = [NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@&u=c", city];
    theURL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

@end
