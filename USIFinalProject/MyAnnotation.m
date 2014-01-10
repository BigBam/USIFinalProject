//
//  MyAnnotation.m
//  MapAssignment
//
//  Created by Bam Faboyede on 1/5/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

-(instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle userRank:(NSNumber *)level
{
    self = [super init];
    
    if(self != nil)
    {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
        _level = level;
    }
    
    return self;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}
@end
