//
//  LoginViewController.m
//  Altogether
//
//  Created by josh on 10/24/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "MyLoginViewController.h"
#import "MySignupViewController.h"

// TO-DO'S
// - need to customize the "signup VC"
// - need to adjust the fram in the viewDidLayoutSubviews method
// - refactor code to remove all unnecessary methodes (give each unique log statement and run through sign-up and login to check for unused) PREFERABLY PUT ALL METHODS AND PROPERTIES ON THE VC CLASSES THEMSELVES RATHER THAN IN THE MAIN VIEW CONTROLLER CODE

@interface MyLoginViewController ()

@end

@implementation MyLoginViewController

- (void)viewDidLoad {
    // CHANGE FRAME IN viewDidLayoutSubviews METHOD
        [super viewDidLoad];
    
        self.view.backgroundColor   = [UIColor whiteColor];
       // [self.logInView setBackgroundColor:[UIColor lightGrayColor]];
        [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Idly - logo.png"]]];
        self.logInView.dismissButton.alpha = 0; // <- THIS ONLY MAKES THE BUTTON CLEAR, NOT GONE
        /*
     // Set buttons appearance
     [self.logInView.dismissButton setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
     [self.logInView.dismissButton setImage:[UIImage imageNamed:@"exit_down.png"] forState:UIControlStateHighlighted];
     
     [self.logInView.facebookButton setImage:nil forState:UIControlStateNormal];
     [self.logInView.facebookButton setImage:nil forState:UIControlStateHighlighted];
     [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"facebook_down.png"] forState:UIControlStateHighlighted];
     [self.logInView.facebookButton setBackgroundImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
     [self.logInView.facebookButton setTitle:@"" forState:UIControlStateNormal];
     [self.logInView.facebookButton setTitle:@"" forState:UIControlStateHighlighted];
     
     [self.logInView.twitterButton setImage:nil forState:UIControlStateNormal];
     [self.logInView.twitterButton setImage:nil forState:UIControlStateHighlighted];
     [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
     [self.logInView.twitterButton setBackgroundImage:[UIImage imageNamed:@"twitter_down.png"] forState:UIControlStateHighlighted];
     [self.logInView.twitterButton setTitle:@"" forState:UIControlStateNormal];
     [self.logInView.twitterButton setTitle:@"" forState:UIControlStateHighlighted];
     
     [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup.png"] forState:UIControlStateNormal];
     [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"signup_down.png"] forState:UIControlStateHighlighted];
     [self.logInView.signUpButton setTitle:@"" forState:UIControlStateNormal];
     [self.logInView.signUpButton setTitle:@"" forState:UIControlStateHighlighted];
     */
     
    // Remove text shadow
        CALayer *layer = self.logInView.usernameField.layer;
        layer.shadowOpacity = 0.0;
        layer = self.logInView.passwordField.layer;
        layer.shadowOpacity = 0.0;
     
    // Set field text color
        self.logInView.usernameField.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5];
        self.logInView.passwordField.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5];
        [self.logInView.usernameField setTextColor:[UIColor blackColor]];
        [self.logInView.passwordField setTextColor:[UIColor blackColor]];
        [self.logInView.logInButton  setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttons.png"] forState:UIControlStateNormal];
        [self.logInView.logInButton  setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttonsH.png"] forState:UIControlStateHighlighted];
        [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttons.png"] forState:UIControlStateNormal];
        [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttonsH.png"] forState:UIControlStateHighlighted];
        [self.logInView.signUpButton setTitle:@"sign-up" forState:UIControlStateNormal];
        [self.logInView.signUpButton setTitle:@"sign-up" forState:UIControlStateHighlighted];
    
        NSLog(@"var check on MLVC. VAR is: %f", varCheck);
        NSLog(@"CON check on MLVC. CON is: %f", CONCheck);

}

/*
- (void)viewDidAppear:(BOOL)animated // NO CONNECTION CODE HERE
{
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        NSLog(@"no user logged in");
        // Create the log in view controller
        
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
     
    }
    //ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    // THERE IS HOWEVER A PROBLEM WITH THe CODE BELOW, DON'T KNOW WHY
    //[self presentModalViewController:viewController animated:YES];
    
    
    // THIS CODE SHOWS THAT WE DO HAVE AN INSTANTIATED PFUSER YAY!!!!!
    NSString *var = [[PFUser currentUser]username];
    NSLog(@"a user IS logged in WHAT NEXT %@", var);
    // NEXT I JUST NEED TO SET THE USER ID  AS A GLOBAL VARIABLE THAT ALL QUERIES CAN USE
    
}
*/ // <- VIEWDIDAPPEAR

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    //[self.logInView.dismissButton setFrame:CGRectMake(10.0f, 10.0f, 87.5f, 45.5f)];
//    [self.logInView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
    float logoW = 200;
    //float logoH = 200;
    [self.logInView.logo setFrame:CGRectMake(self.view.center.x - (logoW/2), 0, 200, 200)];
    //[self.logInView.facebookButton setFrame:CGRectMake(35.0f, 287.0f, 120.0f, 40.0f)];
    //[self.logInView.twitterButton setFrame:CGRectMake(35.0f+130.0f, 287.0f, 120.0f, 40.0f)];
    //[self.logInView.signUpButton setFrame:CGRectMake(35.0f, 385.0f, 250.0f, 40.0f)];
    //[self.logInView.usernameField setFrame:CGRectMake(35.0f, 145.0f, 250.0f, 50.0f)];
    //[self.logInView.passwordField setFrame:CGRectMake(35.0f, 195.0f, 250.0f, 50.0f)];
    //[self.fieldsBackground setFrame:CGRectMake(35.0f, 145.0f, 250.0f, 100.0f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Login Methods
// MAKES SURE ALL FIELDS HAVE SOMETHING IN THEM BEFORE MAKING REQUEST TO SERVER
/*
// LVC-LI-1 Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
    NSLog(@"LVC-LI-1 DONE");
}
// LVC-LI-2 Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"LVC-LI-2 DONE");
    
}
// THE 2 METHODS BELOW: "handle a failed login attempt or a user tapping on the top left dismiss button"
// LVC-LI-3 Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
    NSLog(@"LVC-LI-3 DONE");
    
}
// LVC-LI-4 Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"LVC-LI-4 DONE");
}
*/ // <- ORIGINAL CODE
/*
// LVC-LI-1 Sent to the delegate to determine whether the log in request should be submitted to the server.
- (BOOL)logInViewController:(MyLoginViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
    NSLog(@"LVC-LI-1 DONE");
}
// LVC-LI-2 Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(MyLoginViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    NSLog(@"LVC-LI-2 DONE");
    
}
// THE 2 METHODS BELOW: "handle a failed login attempt or a user tapping on the top left dismiss button"
// LVC-LI-3 Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(MyLoginViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
    NSLog(@"LVC-LI-3 DONE");
    
}
// LVC-LI-4 Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(MyLoginViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"LVC-LI-4 DONE");
}
*/ // <- REFACTOR ATTEMPT

#pragma mark - SignUp Methods
/*
// LVC-SU-1 Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
    NSLog(@"LVC-SU-1 DONE");
}
// LVC-SU-2 Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
    NSLog(@"LVC-SU-2 DONE");
}
// LVC-SU-3 Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
    NSLog(@"LVC-SU-3 DONE");
}
// LVC-SU-4 Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
    NSLog(@"LVC-SU-4 DONE");
}
*/ // <- ORIGINAL CODE
/*
// LVC-SU-1 Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(MySignupViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    NSLog(@"should begin signup");
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
    NSLog(@"LVC-SU-1 DONE");
}
// LVC-SU-2 Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(MySignupViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
    NSLog(@"LVC-SU-2 DONE");
}
// LVC-SU-3 Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(MySignupViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
    NSLog(@"LVC-SU-3 DONE");
}
// LVC-SU-4 Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(MySignupViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
    NSLog(@"LVC-SU-4 DONE");
}
*/ // <- REFACTOR ATTEMPT

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
