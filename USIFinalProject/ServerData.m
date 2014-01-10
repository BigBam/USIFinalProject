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

-(id) simpleJsonSendFetch:(NSString*) method parameters:(NSDictionary*)param
{
    // Initialize
    NSError *error;
    NSData *data = [[NSData alloc] init];
    NSMutableString *string = [[NSMutableString alloc] init];
    NSArray *allkeys = [param allKeys];
    
    for(int i=0; i < [allkeys count]; i++)
    {
        NSString *key = [allkeys objectAtIndex:i];
        if(i == 0)
        {
            [string appendString:@"?"];
        }
        
        [string appendString:[NSString stringWithFormat:@"%@=%@", key, [param objectForKey:key]]];
        
        if(i != [param count]-1)
        {
            [string appendString:@"&"];
        }
    }
    
    NSLog(@"http://scorekpr.com/json/%@%@", method, string);
    
    // Query webservice
    data = [NSData dataWithContentsOfURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://scorekpr.com/json/%@%@", method, string]]];

    // Return results
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
}
@end
