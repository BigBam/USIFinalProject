//
//  DetailViewController.h
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/8/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Settings.h"
#import "MyAnnotation.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, MKMapViewDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) MKMapView *map;

- (IBAction)openSettings:(id)sender;

-(void) clearAnnotations;
-(void) redrawAnnotations;
@end
