//
//  SettingsViewController.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/9/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

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

    // Delegate username input
    self.usernameTxt.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveSettings:(id)sender {
    Settings *pref = [[Settings alloc] init];
    
    // Save username to settings
    [pref saveUserName:self.usernameTxt.text];
    
    // Save username to database with the respective device id
    
    ServerData *webSave = [[ServerData alloc] init];
    NSArray *objects = [[NSArray alloc] initWithObjects:[pref deviceID], [pref username], nil];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"deviceid", @"username", nil];
    
    NSDictionary *param = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    NSDictionary *results = [webSave simpleJsonSendFetch:@"saveNewUser" parameters:param];
    
    

    
    // Go back to root
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)editingChanged:(id)sender
{
    Settings *pref = [[Settings alloc] init];
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
