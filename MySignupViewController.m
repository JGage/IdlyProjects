//
//  MySignupViewController.m
//  Altogether
//
//  Created by josh on 10/26/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

#import "MySignupViewController.h"

@interface MySignupViewController ()

@end

@implementation MySignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // CHANGE FRAME IN viewDidLayoutSubviews METHOD
    [super viewDidLoad];
    [self.signUpView setBackgroundColor:[UIColor whiteColor]];
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Idly - logo.png"]]];
    self.signUpView.dismissButton.alpha = 1; // <- THIS ONLY MAKES THE BUTTON CLEAR, NOT GONE
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
    CALayer *layer = self.signUpView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.signUpView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    
    // Set field text color
    self.signUpView.usernameField.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5];
    self.signUpView.passwordField.backgroundColor = [UIColor colorWithRed:200.0f/255.0f green:200.0f/255.0f blue:200.0f/255.0f alpha:0.5];
    [self.signUpView.usernameField setTextColor:[UIColor blackColor]];
    [self.signUpView.passwordField setTextColor:[UIColor blackColor]];
//    [self.signUpView.logInButton  setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttons.png"] forState:UIControlStateNormal];
//    [self.signUpView.logInButton  setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttonsH.png"] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttons.png"] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"Idly - login-buttonsH.png"] forState:UIControlStateHighlighted];
    [self.signUpView.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
//    [self.signUpView.signUpButton setShowsTouchWhenHighlighted:YES];
    self.signUpView.signUpButton.titleLabel.shadowColor = [UIColor clearColor];
    [self.signUpView.signUpButton setTitle:@"sign-up" forState:UIControlStateNormal];
    [self.signUpView.signUpButton setTitle:@"sign-up" forState:UIControlStateHighlighted];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    [self.signUpView.dismissButton setFrame:CGRectMake(20, 20, 20, 20)];
    //    [self.logInView.logo setFrame:CGRectMake(66.5f, 70.0f, 187.0f, 58.5f)];
    float logoW = 200;
    //float logoH = 200;
    [self.signUpView.logo setFrame:CGRectMake(self.view.center.x - (logoW/2), 0, 200, 200)];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
