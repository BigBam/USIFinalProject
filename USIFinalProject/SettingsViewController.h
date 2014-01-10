//
//  SettingsViewController.h
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/9/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "ServerData.h"

@interface SettingsViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTxt;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;


- (IBAction)saveSettings:(id)sender;
- (IBAction)editingChanged:(id)sender;
@end
