//
//  ServerData.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/10/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "ServerData.h"

@implementation ServerData

-(id) simpleJsonFetch:(NSString*) method
{
    // Initialize
    NSError *error;
    NSData *data = [[NSData alloc] init];
    
    // Build URL
    NSString *url = [NSString stringWithFormat:@"http://scorekpr.com/json/%@",method];
    
    // Get data from the URL
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString: url]];
    
    // Return the results
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}
@end
