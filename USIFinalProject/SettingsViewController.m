//
//  SettingsViewController.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/9/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
{
    Settings *pref;
}
@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize settings
    pref = [[Settings alloc] init];
    
    // Delegate username input
    self.usernameTxt.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveSettings:(id)sender {
    // Save username to database with the respective device id
    
    // Save username to settings
    
    // Go back to root
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)editingChanged:(id)sender
{
    if([pref checkAvailableUsername:[NSString stringWithFormat:@"%@",self.usernameTxt.text]])
    {
        // Username request good
        self.statusLabel.backgroundColor = [UIColor greenColor];
        [self.saveButton setHidden:NO];
        [self.saveButton setEnabled:YES];
    }
    else
    {
        // Username request bad
       self.statusLabel.backgroundColor = [UIColor redColor];
        [self.saveButton setHidden:YES];
    }
}
@end
