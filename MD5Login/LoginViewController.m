//
//  LoginViewController.m
//  MD5Login
//
//  Created by Takanori Ogata on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "NSString+MD5.h"

@implementation LoginViewController

@synthesize usernameText, passwordText;

NSString* kServerUrl = @"http://localhost:5000";


- (void)autholizeWithUsername:(NSString*)username 
                  andPassword:(NSString*)password
{
  NSLog(@"autholize:: %@:%@", username, password);
  
  NSURL *url = [NSURL URLWithString:kServerUrl];
  
  AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
  
  [httpClient getPath:@"/login"
           parameters:nil 
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSError *parseError = nil;
                id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingAllowFragments 
                                                                  error:&parseError];
                // if error
                if (parseError) {
                  NSLog(@"httpClient getPath - parseError");
                  return;
                }
                
                NSString* oneTimeKey = nil;
                if ([jsonObject respondsToSelector:@selector(objectForKey:)]) {
                  // if has key
                  NSLog(@"httpClient getPath - key: %@", [jsonObject objectForKey:@"key"]);
                  oneTimeKey = [NSString stringWithFormat:@"%@", [jsonObject objectForKey:@"key"]];
                  
                } else {
                  // error
                  NSLog(@"httpClient getPath - response does not have key");
                  return;
                }
                
                
                // encrypt
                NSString* rawStr = [NSString stringWithFormat:@"%@%@%@",username, password, oneTimeKey];
                NSString* encryptedStr = [rawStr md5];
                NSLog(@"md5:%@",encryptedStr);
                
                
                // post
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:username forKey:@"username"];
                [params setObject:encryptedStr forKey:@"key"];
                
                [httpClient postPath:@"/login"
                          parameters:params
                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                               NSString* res = [NSString stringWithUTF8String:[responseObject bytes]];
                               
                               NSLog(@"httpClient postPath - success %@",res);
                               
                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                               NSLog(@"httpClient postPath - failure %@", error);
                             }];
                
                
              } 
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"httpClient getPath - failure %@", error);
              }];
  
}


- (IBAction)onLoginButtonPushed:(id)sender
{
  NSLog(@"LoginViewController:: onLoginButtonPushed");
  
  
  [self autholizeWithUsername:self.usernameText.text
                  andPassword:self.passwordText.text];
}


- (IBAction)onTestButtonPushed:(id)sender
{
  NSURL *url = [NSURL URLWithString:kServerUrl];
  AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
  
  [httpClient getPath:@"/test"
           parameters:nil 
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                
                NSString* res = [NSString stringWithUTF8String:[responseObject bytes]];                
                NSLog(@"httpClient postPath - success %@",res);
                
              } 
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"httpClient getPath - failure %@", error);
              }];
  
}



- (BOOL)textFieldShouldReturn:(UITextField *)sender {
  [sender resignFirstResponder];		
  return YES;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  [super viewDidLoad];
  NSLog(@"viewDidLoad");
  
  
}


- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  // Return YES for supported orientations
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
