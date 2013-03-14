//
//  ersViewController.m
//  ConnectivityTest
//
//  Created by Tony Million on 21/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ersViewController.h"

#import "Reachability.h"

@interface ersViewController (private)

-(void)reachabilityChanged:(NSNotification*)note;

@end

@implementation ersViewController

@synthesize blockLabel, notificationLabel;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    // have to use this syntax
    // ers.usda.gov/rss/calendar.aspx?type=pub&n=1
   // Reachability * reach = [Reachability reachabilityWithHostname:@"www.ers.usda.gov/rss/calendar.aspx?type=pub&n=1"];
    
   //   Reachability * reach = [Reachability reachabilityWithHostname:@"www.api.ers.usda.gov/REST/v1/charts/mostrecent/1/"];
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.ers.usda.gov"];
    
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            blockLabel.text = @"ERS Publication RSS Feed is Reachable";
        });
    };
    
    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            blockLabel.text = @"ERS Publication RSS Feed is Unreachable";
        });
    };
    
    [reach startNotifier];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        notificationLabel.text = @"Notification Says Reachable";
    }
    else
    {
        notificationLabel.text = @"Notification Says Unreachable";
    }
}

@end
