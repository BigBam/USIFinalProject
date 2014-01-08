//
//  MyAnnotation.m
//  MapAssignment
//
//  Created by Bam Faboyede on 1/5/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

/*
-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *results = nil;
    if([annotation isKindOfClass:[MyAnnotation class]] == NO)
    {
        return results;
    }
    
    if([mapView isEqual:self.map])
}
*/

-(instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle rating:(NSNumber *)ratingNumber
{
    self = [super init];
    
    if(self != nil)
    {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubTitle;
        _rating = ratingNumber;
    }
    
    return self;
}

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}
@end
