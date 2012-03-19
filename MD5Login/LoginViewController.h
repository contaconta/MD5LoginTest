//
//  LoginViewController.h
//  MD5Login
//
//  Created by Takanori Ogata on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField* usernameText;
@property (strong, nonatomic) IBOutlet UITextField* passwordText;

@end
