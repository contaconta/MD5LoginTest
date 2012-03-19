//
//  ViewController.m
//  MD5Login
//
//  Created by Takanori Ogata on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController



- (void)showLoginView
{
  NSLog(@"ViewController::showLoginView");
  [self performSegueWithIdentifier:@"firstViewToLoginView" sender:self];
  
}

-(IBAction)btnPushed:(id)sender
{
  [self showLoginView];
}


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
  NSLog(@"viewDidLoad");
  
  /*
   UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
   UIViewController* loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
   [self presentModalViewController:loginVC animated:YES];
   */
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
  NSLog(@"viewWillApper");
  //[self showLoginView];
  
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  NSLog(@"viewDidAppear");
  [self showLoginView];
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

@end
