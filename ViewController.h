//
//  ViewController.h
//  Altogether
//
//  Created by josh on 10/24/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

// FRAMEWORKS
// took out CoreLocation.framework

#import <UIKit/UIKit.h>
// LOGIN/SIGNUP
#import "MyLoginViewController.h"
#import "MySignupViewController.h"
// CONSTANTS
#import "Vars AND Constants.h"
#import "UIColor+Colors.h"
// APPLE LIBRARIES
#import <QuartzCore/QuartzCore.h> // <- this is for the UIBezzierPath and CALayer (for Tab1)
#import <AddressBook/AddressBook.h> // <- provides all necessary libraries and classes for working w/ address book contacts
#import <AddressBookUI/AddressBookUI.h> // <- required to display address book navigation controller & all existing contacts
// CUSTOM VIEW CONTROLLERS
#import "SidebarViewController.h"   // **TRYING TO ADD BASEMENT TO MAIN VIEW


@interface ViewController : UIViewController

// LOGIN-SIGNUP
@property (weak, nonatomic) IBOutlet UILabel *currentUsername;
@property (weak, nonatomic) IBOutlet UILabel *currentPassword;

// PARSE - CONTACTS
@property NSMutableArray *parseCurrentFriends;

// DEVICE
- (NSString *) platform;
- (NSString *) platformString;

// BASEMENT
// - bm view - properties
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton; // NECESSARY, though i'm not sure why...
@property (weak, nonatomic) IBOutlet UIButton *sidebarButtonX;


@end

