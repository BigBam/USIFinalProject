//
//  DetailViewController.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/8/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "DetailViewController.h"
#import "ChallengersListViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
{
    NSMutableArray *annotationArray;
    NSMutableArray *allChallengers;
    MKCoordinateRegion currentSpan;
    
    ServerData *webFetcher;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Initialize
    allChallengers = [[NSMutableArray alloc] init];
    annotationArray = [[NSMutableArray alloc] init];
    webFetcher = [[ServerData alloc] init];
    
    // Set up the map
    self.title = @"Map";
    self.map = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.map.delegate = self;
    [self.view addSubview:self.map];
    
    // BarButton items
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_settings.png"] style:UIBarButtonItemStylePlain target:self action:@selector(openSettings:)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = editButton;
    
    // TabBar1 image (placeholder)
    self.tabBarItem.image = [UIImage imageNamed:@"icon_settings.png"];

    
    // Retrieve ALL other challengers to appear on the map
    allChallengers = [webFetcher simpleJsonFetch:@"allChallengers"];
    
    
    
    // Set up Challengers Table
        // (CHEAT - set up the second tab when this view loads)
    NSArray *vc = self.tabBarController.viewControllers;
    ChallengersListViewController *cvc = [vc objectAtIndex:1];
    
    // TabBar2 image (placeholder)
    cvc.tabBarItem.image = [UIImage imageNamed:@"icon_settings.png"];
    cvc.title = @"List";
    
    // Save challengers list to the challenger table
    cvc.allChallengers = allChallengers;
    
    
    
    [self drawAnnotations];
    [self configureView];
}

-(void) viewWillAppear:(BOOL)animated
{

}

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

-(void) clearAnnotations
{
    
    [self.map removeAnnotations:annotationArray];
    [annotationArray removeAllObjects];
}

-(void) drawAnnotations
{
    
    [self clearAnnotations];
    
    for(NSDictionary *challenger in allChallengers)
    {
        float lat = [[challenger objectForKey:@"latitude"] floatValue];
        float lng = [[challenger objectForKey:@"longitude"] floatValue];
        
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake(lat, lng);
        
        MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:location title:[challenger objectForKey:@"username"] subTitle:@"---" userRank:[NSNumber numberWithInt:0]];

        [annotationArray addObject:annotation];
    }
    
    [self.map addAnnotations:annotationArray];
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
        
        float imageSize = 50;
        /*
        float scaleFactor = (33 - currentSpan.span.latitudeDelta)/33;
        if(scaleFactor < 0)
        {
            scaleFactor = 0;
        }
        float sizeAdjust = (50 - 10) * scaleFactor;
        float imageSize = sizeAdjust + 10;
        */
        
        //NSLog(@"scaleFactor:%f sizeAdjust:%f imageSize:%f ", scaleFactor, sizeAdjust, imageSize);
        
        [annotationView setFrame:CGRectMake(0, 0,imageSize, imageSize)];
        
        [annotationView setLeftCalloutAccessoryView:button];
        //[annotationView setDraggable:YES];
        
        
        return annotationView;
    }
    
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    // Start game
}

/*
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{

    
    if(newState == MKAnnotationViewDragStateEnding)
    {
       // [self drawAnnotations];
    }
}
*/

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    currentSpan = mapView.region;

    //NSLog(@"The zoom has changed %f %f", currentSpan.span.latitudeDelta, currentSpan.span.longitudeDelta);

    // Redraw annotations?
    //[self drawAnnotations];
    //
}
@end
