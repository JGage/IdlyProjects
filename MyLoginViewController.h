//
//  LoginViewController.h
//  Altogether
//
//  Created by josh on 10/24/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

#import <Parse/Parse.h>
#import "MySignupViewController.h"
#import "Vars AND Constants.h"

@interface MyLoginViewController : PFLogInViewController
<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate >

// PARSE LOGIN KEYS -> AppDelegat.m
// PARSE LOGIN VC CUSTOMIZATION -> MyLoginViewController.m (viewDidLoad & viewDidLayoutSubviews)
// PARSE SIGNUP VC CUSTOMIZATION -> ???
// 

@end
