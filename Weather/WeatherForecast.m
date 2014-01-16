//
//  WeatherForecast.m
//  Weather
//
//  Created by Allen on 2014/1/15.
//  Copyright (c) 2014年 Allen. All rights reserved.
//

#import "WeatherForecast.h"
#import "MainViewController.h"

@implementation WeatherForecast


- (void)queryService:(NSString *)city withParent:(UIViewController *)controller
{
    viewController = (MainViewController *)controller;
    responseData = [NSMutableData data];
    
    NSString *url = [NSString stringWithFormat:@"http://weather.yahooapis.com/forecastrss?w=%@&u=c", city];
    theURL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:theURL];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    @autoreleasepool {
        theURL = [request URL];
    }
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error = %@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *content = [[NSString alloc]
                         initWithBytes:[responseData bytes] length:[responseData length] encoding:NSUTF8StringEncoding];
    NSLog(@"Data = %@", content);
    
    [viewController updateView];
}

@end
