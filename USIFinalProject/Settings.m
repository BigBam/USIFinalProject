//
//  Settings.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/9/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "Settings.h"

@implementation Settings

-(NSString *) deviceID
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs stringForKey:@"deviceID"] == NULL)
    {
        // Device ID is not set so we need to generate one
        [prefs setObject:[self generateDeviceID] forKey:@"deviceID"];
        [prefs synchronize];
        
        // Save the deviceID to the web server
        
        //...

    }
    else
    {
        // Retrieve settings from the web server according to the deviceID
        
        //...
    }
    
    return [prefs stringForKey:@"deviceID"];
}

- (NSString *) generateDeviceID
{
    /*
     
        Later, we will generate a unique ID from the database
    
     */
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:6];
    
    for (int i = 0; i < 6; i++) {
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random() % [letters length]]];
    }
    
    return randomString;
}

@end
