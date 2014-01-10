//
//  Settings.h
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/9/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsViewController.h"

@interface Settings : NSObject
- (NSUserDefaults *) userDefaults;
- (NSString *) deviceID;
- (NSString *) generateDeviceID;

// Web service functions
- (BOOL) checkAvailableUsername:(NSString *)username;
@end
