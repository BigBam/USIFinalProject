//
//  Settings.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/9/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "Settings.h"

@implementation Settings

- (NSUserDefaults *) userDefaults
{
    return [NSUserDefaults standardUserDefaults];
}

-(NSString *) deviceID
{
    NSUserDefaults *prefs = [self userDefaults];
    if([prefs stringForKey:@"deviceID"] == NULL)
    {
        // Device ID is not set so we need to generate a unique one
        [prefs setObject:[self generateDeviceID] forKey:@"deviceID"];
        [prefs synchronize];
    }
    
    return [prefs stringForKey:@"deviceID"];
}

-(NSString *) username
{
    NSUserDefaults *prefs = [self userDefaults];
    return [prefs stringForKey:@"username"];
}

-(void) saveUserName:(NSString *) username
{
    NSUserDefaults *prefs = [self userDefaults];
    [prefs setObject:username forKey:@"username"];
    [prefs synchronize];
}

- (NSString *) generateDeviceID
{
    // Initialize
    NSError *error;
    NSData *data = [[NSData alloc] init];
    
    // Get a new key from webservice
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString: @"http://scorekpr.com/json/generateNewKey"]];
    
    // Serialize results
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    // Return the unique identifier
    return [jsonDict objectForKey:@"id"];
}

// Web service functions
- (BOOL) checkAvailableUsername:(NSString *)username
{
    // Initialize
    NSError *error;
    NSData *data = [[NSData alloc] init];
    
    // Query webservice
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://scorekpr.com/json/checkUsername?username=%@", username]]];
    
    // Serialize results
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    bool results = [[jsonDict objectForKey:@"results"] boolValue];
    
    // Return result of username check
    return results;
}
@end
