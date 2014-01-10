//
//  ChallengersListViewController.m
//  USIFinalProject
//
//  Created by Bam Faboyede on 1/10/14.
//  Copyright (c) 2014 Bam F. All rights reserved.
//

#import "ChallengersListViewController.h"

@interface ChallengersListViewController ()

@end

@implementation ChallengersListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(66, 0, 0, 0);
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.allChallengers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ChallengerCell";
    UITableViewCell *cell = cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // Get the user
    NSDictionary *currentRow = [self.allChallengers objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [currentRow objectForKey:@"username"];
    int state = [[currentRow objectForKey:@"state"] integerValue];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"[%i-%i] (%f, %f)",
                                 [[currentRow objectForKey:@"total_wins"] integerValue],
                                 [[currentRow objectForKey:@"total_wins"] integerValue] +
                                 [[currentRow objectForKey:@"total_losses"] integerValue],
                                 [[currentRow objectForKey:@"latitude"] floatValue],
                                 [[currentRow objectForKey:@"longitude"] floatValue]];
    // Set up emoticons
    if(state < 2)
    {
        // User is in waiting inactive state
        cell.imageView.image = [UIImage imageNamed:@"state0.png"];
    } else if(state == 2) {
        // User is waiting in active state
        cell.imageView.image = [UIImage imageNamed:@"state1.png"];
    } else {
        // User is active in game
        cell.imageView.image = [UIImage imageNamed:@"state2.png"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Start game
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
