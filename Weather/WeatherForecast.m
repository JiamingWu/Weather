//
//  WeatherForecast.m
//  Weather
//
//  Created by Allen on 2014/1/15.
//  Copyright (c) 2014年 Allen. All rights reserved.
//

#import "WeatherForecast.h"
#import "MainViewController.h"
#import "XPathQuery.h"

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
    
    NSString *xpathQueryString;
    NSArray *nodes;
    
    xpathQueryString = @"//channel/location/@city"; //location 有 namespace, 但此行是可運作的, 原因不明.
    nodes = PerformHTMLXPathQuery(responseData, xpathQueryString);
    self.location = [self fetchContent:nodes];
    NSLog(@"location = %@", self.location);
    
    xpathQueryString = @"//condition/@date";
    nodes = PerformHTMLXPathQuery(responseData, xpathQueryString);
    self.date = [self fetchContent:nodes];
    NSLog(@"date = %@", self.date);
    
    self.icon = @"http://l.yimg.com/a/i/us/we/52/30.gif";
    NSLog(@"icon = %@", self.icon);
    
    xpathQueryString = @"//condition/@temp";
    nodes = PerformHTMLXPathQuery(responseData, xpathQueryString);
    self.temp = [NSString stringWithFormat:@"%@C", [self fetchContent:nodes]];
    NSLog(@"temp = %@", self.temp);
    
    [viewController updateView];
}

- (NSString *)fetchContent:(NSArray *)nodes
{
    NSString *result = @"";
    for (NSDictionary *node in nodes) {
        for (id key in node) {
            if ([key isEqualToString:@"nodeContent"]) {
                result = [node objectForKey:key];
            }
        }
    }
    return result;
}

- (void)populateArray:(NSMutableArray *)array fromNodes:(NSArray*)nodes
{
    for (NSDictionary *node in nodes) {
        for (id key in node) {
            if ([key isEqualToString:@"nodeContent"]) {
                [array addObject:[node objectForKey:key]];
            }
        }
    }
}

@end
