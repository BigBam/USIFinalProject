//
//  DetailViewController.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/8/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
{
    NSMutableArray *annotationArray;
    MKCoordinateRegion currentSpan;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    annotationArray = [[NSMutableArray alloc] init];
    
    self.title = @"Challengers";
    
    self.map = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.map.delegate = self;
    [self.view addSubview:self.map];

    
    



    [self configureView];
}

-(void) clearAnnotations
{
    
    [self.map removeAnnotations:annotationArray];
    [annotationArray removeAllObjects];
}

-(void) drawAnnotations
{
    
    
    
    
    float lat = 33.9304f;
    float lng = -84.3733f;
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lat, lng);
    
    MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:location title:@"title" subTitle:@"subtitle" userRank:[NSNumber numberWithInt:3]];
    
    // initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubTitle userRank:(NSNumber *)level
    [annotationArray addObject:annotation];
    
    
    // Span to the region
    //[self.map setRegion:region animated:YES];
    [self.map addAnnotation:annotation];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Recent", @"Recent");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (IBAction)openSettings:(id)sender {
    SettingsViewController *content = [[SettingsViewController alloc] init];
    [content.view setFrame:self.view.frame];
    [self.navigationController pushViewController:content animated:YES];
}

// Mapview delegate methods
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"UserPin";
    if([annotation isKindOfClass:[MyAnnotation class]])
    {
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(!annotationView)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            
        }
        else
        {
            annotationView.annotation = annotation;
        }
        
        // create disclosure button on the callout
        UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"pin.png"];
        
        
        float scaleFactor = (33 - currentSpan.span.latitudeDelta)/33;
        if(scaleFactor < 0)
        {
            scaleFactor = 0;
        }
        float sizeAdjust = (50 - 10) * scaleFactor;
        float imageSize = sizeAdjust + 10;
        
        //NSLog(@"scaleFactor:%f sizeAdjust:%f imageSize:%f ", scaleFactor, sizeAdjust, imageSize);
        
        [annotationView setFrame:CGRectMake(0, 0,imageSize, imageSize)];
        
        [annotationView setLeftCalloutAccessoryView:button];
        [annotationView setDraggable:YES];
        
        return annotationView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    /*
    MyAnnotation *thisAnnotation = view.annotation;
    
    clickedTitle = thisAnnotation.title;
    clickedAddress = thisAnnotation.subtitle;
    clickedRating = thisAnnotation.rating;
    
    [self performSegueWithIdentifier:@"showDetails" sender:self];
     */
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{

    
    if(newState == MKAnnotationViewDragStateEnding)
    {
        [self clearAnnotations];
        
        [self drawAnnotations];
    }
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    currentSpan = mapView.region;

    //NSLog(@"The zoom has changed %f %f", currentSpan.span.latitudeDelta, currentSpan.span.longitudeDelta);

    // Redraw annotations?
    [self drawAnnotations];
    //
}
@end
