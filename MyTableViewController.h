//
//  MyTableViewController.h
//  ContactAccessProject2
//
//  Created by josh on 9/28/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

//#import "ViewController.h" // DELEGATION SAYS LEAVE THIS OUT
#import <UIKit/UIKit.h>
//#import "SegueContactsList.h"
#import "ContactObject.h"
#import "Vars AND Constants.h"
#import "UIColor+COLORS.h"

// DELEGATE PROTOCOL 1/3
@protocol MyTableViewControllerDelegate;


@interface MyTableViewController : UITableViewController

// DELEGATE PROTOCOL 2/3
@property (nonatomic, weak) id < MyTableViewControllerDelegate > delegate;

@property NSMutableDictionary   *phoneContactsActiveDict;
@property NSMutableDictionary   *displayChecksDict;
@property NSMutableDictionary   *valueChangedDict;
@property NSMutableArray        *displayContactsArray;

@property NSInteger             currentIdlyFriendCount;

- (IBAction)TestSave:(id)sender;
- (IBAction)TestCancel:(id)sender;

@end


// DELEGATE PROTOCOL 3/3
@protocol MyTableViewControllerDelegate //<NSObject>
/*
 -(void) dayEditViewControllerDidSave;
 -(void) dayEditViewControllerDidCancel;
 */ // <- DEPRECATED CODE

@end
