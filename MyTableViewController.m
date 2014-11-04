//
//  MyTableViewController.m
//  ContactAccessProject2
//
//  Created by josh on 9/28/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

#import "MyTableViewController.h"
#import "SWRevealViewController.h"
#import "ViewController.h"

@interface MyTableViewController ()

@end

@implementation MyTableViewController

#pragma mark CONDITIONAL-CODE-PT1: setup // <- NOT SURE IF THE INIT HURTS OTHER FUNCTIONS

// NSCONDITIONAL CODE pt1
{
    NSCondition *_myCondition;
    BOOL _someCheckIsTrue;
}
// NSCONDITIONAL CODE pt2
- (id)init
{
    self = [super init];
    if (self)
    {
        _someCheckIsTrue = NO;
        _myCondition = [[NSCondition alloc] init];
    }
    return self;
}


#pragma mark VDL & DRMW

// VDL
- (void)viewDidLoad {
    [super viewDidLoad];

// TABLEVIEW CELL
    // - register cell w/ reuse ID -
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"contactCellRI"];
    // - adjust table view for nav bar -
    NSInteger standardNavBarHeight  = self.navigationController.navigationBar.frame.size.height;
    NSInteger standardToolbarHeight = self.navigationController.toolbar.frame.size.height;
    self.tableView.contentInset = UIEdgeInsetsMake(CONtablePopUpNavbarHeight - standardNavBarHeight, 0, standardToolbarHeight - CONtablePopUpToolbarHeight, 0); // top, left, botton, right
    
    
// ADDRESSBOOK CONTACTS
    // - get AB from phone -
    _displayContactsArray = [self getPhoneContactsMTVC];
    // - checkmark -
    _phoneContactsActiveDict        = [[NSMutableDictionary alloc] init];
    

// CHECKMARK DICTIONARY
    // the below statement yields a phoneContactsActiveDict w/ checkvalues for all AB records
    for (id contact in _displayContactsArray) {
        NSString *phoneCheck        = [[NSString alloc] init];
        NSString *checkValue        = [[NSString alloc] init];
        // get each number from AB
        phoneCheck                  = [contact number];
        // check Parse results for that number & set result to "isTheNumberThere"
        NSString *isTheNumberThere  = [parseCurrentFriendsX objectForKey:phoneCheck];
        // if that result is NOT nul... SET checkvalue to "YES"     -> ( CRSYES )
        if (isTheNumberThere) {
            checkValue = CONparseFriend;
        }
        // if the result is nul... SET checkvalue to "NO"           -> ( CRSNO )
        else {
            checkValue = CONparseNotFriend;
        }
        // update phoneContactsActiveDict with checkvalue
            [_phoneContactsActiveDict setObject:checkValue forKey:phoneCheck];
    }
    NSLog(@"OLD ActiveDict: %@", _phoneContactsActiveDict);
   
    
// CHANGES-TO-FRIENDS DICTIONARY
    _valueChangedDict               = [[NSMutableDictionary alloc] init];
    NSString *numberKey             = [[NSString alloc] init];
    NSString *didChange             = [[NSString alloc] init];
    // initially set all values to "unchanged"
    NSString *didChangeValue        = CONABunchanged;
    for (id  contact in _displayContactsArray) {
        numberKey     = [contact number];
        didChange     = didChangeValue;
        [_valueChangedDict setObject:didChange forKey:numberKey];
    }

    
// NAVIGATION-BAR
    UINavigationBar *navBar         = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.view.frame.size.width, 80)];
    navBar.backgroundColor          = [UIColor whiteColor];
    navBar.barTintColor             = [UIColor whiteColor];
    navBar.translucent              =  NO;
    [navBar.layer setBorderWidth:   1.0];
    [navBar.layer setBorderColor:   [[UIColor lightGrayColor] CGColor]];
    [navBar setFrame:CGRectMake(0, 0, self.navigationController.view.frame.size.width, CONtablePopUpNavbarHeight)];
    // create image
    UIImage *popupContact           = [UIImage imageNamed: @"Contacts" ];
    UIImageView *popupContactView   = [[UIImageView alloc] initWithFrame:CGRectMake(10, (5*(CONtablePopUpNavbarHeight - CONtablePopUpNavbarIconH))/6, CONtablePopUpNavbarIconW, CONtablePopUpNavbarIconH)];
    popupContactView.image = popupContact;
    popupContactView.backgroundColor = [UIColor whiteColor];
    // create label
    UILabel *popupActiveExplain     = [[UILabel alloc] initWithFrame:CGRectMake(210, ((5*(CONtablePopUpNavbarHeight - CONtablePopUpNavbarIconH))/6)+7, 60, CONtablePopUpNavbarIconH)];
    popupActiveExplain.text         = @"add phone contacts to Idly";
    [popupActiveExplain setTextColor:[UIColor lightGrayColor]];
    [popupActiveExplain setNumberOfLines:3];
    popupActiveExplain.font = [UIFont fontWithName:@"Helvetica-Light" size:10.0f];
    popupActiveExplain.textAlignment = NSTextAlignmentCenter;
    popupActiveExplain.userInteractionEnabled = NO;
    // IDLY FRIEND COUNT
    // - get count -
    _currentIdlyFriendCount          = 0;
    for (NSString *key in _phoneContactsActiveDict) {
        id value = [_phoneContactsActiveDict objectForKey:key];
        if ([value isEqualToString: CONparseFriend ]) {
            // contact is currently an IDLY friend
            _currentIdlyFriendCount++;
        } else if ([value isEqualToString: CONparseNotFriend ]) {
            // contact is currently NOT an IDLY friend
        } else {
            // error
        }
    }
    // - set properties -
    NSString *currentIdlyFriendText = [NSString stringWithFormat:@"%d", _currentIdlyFriendCount];
    UILabel *popupFriendCount       = [[UILabel alloc] initWithFrame:CGRectMake(60, ((5*(CONtablePopUpNavbarHeight - CONtablePopUpNavbarIconH))/6)+7, CONcontactCounterDimW, CONcontactCounterDimH)];
    popupFriendCount.tag            = CONtablePopUpFriendCounTag;
    popupFriendCount.text           = currentIdlyFriendText;
    [popupFriendCount setTextColor:[UIColor CONidlyPaleBlue]];
    [popupFriendCount setNumberOfLines:3];
    popupFriendCount.font           = [UIFont fontWithName:CONcontactCounterFont size:CONcontactCounterFontSize];
    popupFriendCount.textAlignment  = NSTextAlignmentCenter;
    popupFriendCount.userInteractionEnabled = NO;
    // <- FIGURE OUT WHY YOU CAN'T REFACTOR THE CODE ABOVE TO JUST CALL THE MEHTOD BELOW
    // add subview(s) (nav-bar & nav-controller)
    [self.navigationController.view addSubview:navBar];
    [self.navigationController.view addSubview:popupContactView];
    [self.navigationController.view addSubview:popupActiveExplain];
    [self.navigationController.view addSubview:popupFriendCount];

    
// TOOL-BAR
    [self.navigationController setToolbarHidden:NO];
    self.navigationController.toolbar.backgroundColor     = [UIColor whiteColor];
    self.navigationController.toolbar.barTintColor        = [UIColor whiteColor];
    self.navigationController.toolbar.translucent         =  NO;
    [self.navigationController.toolbar.layer setBorderWidth:1.0];
    [self.navigationController.toolbar.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    // - left button -
    UIButton *buttonL = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [buttonL setTitle:@"SAVE" forState:UIControlStateNormal];
    buttonL.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.0f];
    [buttonL setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [buttonL setTitleColor: [UIColor whiteColor] forState:UIControlStateHighlighted];
    buttonL.backgroundColor = [UIColor whiteColor]; /*
                                                     //    [buttonL setBackgroundImage:unpressed forState:UIControlStateNormal];
                                                     //    [buttonL setBackgroundImage:pressed forState:UIControlStateHighlighted];
                                                     */
    [buttonL.layer setCornerRadius:4.0f];
    [buttonL.layer setMasksToBounds:YES];
    [buttonL.layer setBorderWidth:1.0f];
    [buttonL.layer setBorderColor: [[UIColor blackColor] CGColor]];
    buttonL.frame=CGRectMake(0, 0, CONtablePopUpButtonWidth, CONtablePopUpButtonHeight);
    [buttonL addTarget:self action:@selector(TestSave:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithCustomView:buttonL];
    //    self.navigationItem.leftBarButtonItem = saveItem;
    // - right button -
    UIButton *buttonR = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setBackgroundImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
    [buttonR setTitle:@"CANCEL" forState:UIControlStateNormal];
    buttonR.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12.0f];
    [buttonR setTitleColor: [UIColor blackColor] forState:UIControlStateNormal];
    [buttonR setTitleColor: [UIColor whiteColor]      forState:UIControlStateHighlighted];
    buttonR.backgroundColor = [UIColor whiteColor]; /*
                                                     //    [buttonL setBackgroundImage:unpressed forState:UIControlStateNormal];
                                                     //    [buttonL setBackgroundImage:pressed forState:UIControlStateHighlighted];
                                                     */
    [buttonR.layer setCornerRadius:4.0f];
    [buttonR.layer setMasksToBounds:YES];
    [buttonR.layer setBorderWidth:1.0f];
    [buttonR.layer setBorderColor: [[UIColor blackColor] CGColor]];
    buttonR.frame=CGRectMake(50 + CONtablePopUpButtonWidth + 10, CONtablePopUpButtonStartY, CONtablePopUpButtonWidth, CONtablePopUpButtonHeight);
    [buttonR addTarget:self action:@selector(TestCancel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* cancelItem = [[UIBarButtonItem alloc] initWithCustomView:buttonR];
    //    self.navigationItem.rightBarButtonItem = cancelItem;
    // - flex space -
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    // - set toolbar -
    NSArray *toolbarArray = [NSArray arrayWithObjects:flexSpace, saveItem,flexSpace, cancelItem, flexSpace, nil];
    self.toolbarItems = toolbarArray;
  
    
}
// NADA
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

// Method 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
// Method 2
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.displayContactsArray count];
}
// Method 3
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier =@"contactCellRI";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    // VARIABLES - MTVC HOUSED
    NSString *fullNameDisplay   = [[_displayContactsArray objectAtIndex:indexPath.row] fullName];
    NSString *numberDisplay     = [[_displayContactsArray objectAtIndex:indexPath.row] number];
    UIImage *myImage            = [[_displayContactsArray objectAtIndex:indexPath.row] contactpic];
    // DISPLAY TEXT
    cell.textLabel.text         = fullNameDisplay;
    cell.textLabel.font         = [UIFont fontWithName:@"Helvetica-Light" size:12.0f];
    cell.detailTextLabel.text   = numberDisplay;
    cell.detailTextLabel.font   = [UIFont fontWithName:@"Helvetica-Light" size:8.0f];
    // DISPLAY IMAGE
    if (myImage) {
        [cell.imageView setImage:myImage];
    } else {
        UIImage *myImage2            = [UIImage imageNamed:@"NoPicContact"];
        [cell.imageView setImage:myImage2];
    }
    // DISPLAY CHECKMARK
    NSString *CRSCheck          = [_phoneContactsActiveDict objectForKey:numberDisplay];
    if ([CRSCheck isEqualToString:CONparseFriend]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else if ([CRSCheck isEqualToString:CONparseNotFriend]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        NSLog(@"CFRAIP - problem with AVB Value: %@", numberDisplay);
    }
    
    
    return cell;
    
}
// Method 4
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // GET PHONE VALUE AT SELECTED CELL
    NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    UITableViewCell *selectedCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:ip];
    NSString *selectedCellPhone = (NSString *) selectedCell.detailTextLabel.text;
    // UPDATE DICT BOOL
    if ([[_phoneContactsActiveDict objectForKey:selectedCellPhone] isEqualToString:CONparseNotFriend]) {
        // CHANGE DICT ENTRY VALUE TO YES
        [_phoneContactsActiveDict setObject:CONparseFriend forKey:selectedCellPhone];
        // CHANGE CELL CHECK MARK TO ON
        selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
        _currentIdlyFriendCount++;
        // UPDATE DICT BOOL
        [_phoneContactsActiveDict removeObjectForKey:selectedCell.detailTextLabel.text];
        [_phoneContactsActiveDict setObject:CONparseFriend forKey:selectedCell.detailTextLabel.text];
        
    } else {
        // CHANGE DICT ENTRY VALUE TO NO
        [_phoneContactsActiveDict setObject:CONparseNotFriend forKey:selectedCellPhone];
        // CHANGE CELL CHECK MARK TO OFF
        selectedCell.accessoryType = UITableViewCellAccessoryNone;
        _currentIdlyFriendCount--;
        // UPDATE DICT BOOL
        [_phoneContactsActiveDict removeObjectForKey:selectedCell.detailTextLabel.text];
        [_phoneContactsActiveDict setObject:CONparseNotFriend forKey:selectedCell.detailTextLabel.text];
        
    }
    [self setcurrentFriendCount:_currentIdlyFriendCount];

    NSString *newValue = ([[_valueChangedDict objectForKey:selectedCell.detailTextLabel.text] isEqualToString: CONABunchanged]) ? (CONABchanged) : (CONABunchanged);
    [_valueChangedDict setObject:newValue forKey:selectedCell.detailTextLabel.text];
    
}


#pragma mark - SAVE & CANCEL

// TOOLBAR BUTTON METHODS
- (IBAction)TestSave:(id)sender {
    NSLog(@"NEW ActiveDict: %@", _phoneContactsActiveDict);
    for (NSString *phoneNumber in _valueChangedDict) {
        NSString *value     = [_valueChangedDict objectForKey:phoneNumber];
        // check CHANGE DICTIONARY
        if ([value isEqualToString:CONABchanged]) {
            NSString *value2                = [_phoneContactsActiveDict objectForKey:phoneNumber];
            NSString *userIdFriendPhone     = [NSString stringWithFormat:@"%@-%@", [[PFUser currentUser] objectId], phoneNumber];
            // FRIEND-ENEMY DICTIONARY
            // - ADD CONTACT -
            if ([value2 isEqualToString:CONparseFriend]) {
                PFObject *addFriend               = [PFObject objectWithClassName:@"Contacts"];
                addFriend[@"UserID"]              = [[PFUser currentUser] objectId];
                addFriend[@"UserIdFriendPhone"]   = userIdFriendPhone;
                addFriend[@"phone"]               = phoneNumber;
                addFriend[@"OutgoingStatus"]      = @"inactive";
                [addFriend saveInBackground];
            }
            // - DROP CONTACT -
            else if ([value2 isEqualToString:CONparseNotFriend]) {
                
                NSString *objectID              = [parseCurrentFriendsX objectForKey:phoneNumber];
                PFQuery *dropFriend             = [PFQuery queryWithClassName:@"Contacts"];
                [dropFriend getObjectInBackgroundWithId:objectID block:^(PFObject *droppedFriend, NSError *error) {
                    [droppedFriend deleteInBackground];
                }];

            }
            
            /*
            [self performSelectorInBackground:@selector(_setDictMethod) withObject:nil];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(1);
            [self performSelectorInBackground:@selector(_cancelMethod) withObject:nil];
            });
            */ // <- no need to update Dict here, will update with DSRAIP method on SidebarVC
        }
    }
    [self TestCancel:self];

}
- (IBAction)TestCancel:(id)sender {
    //[self dismissViewControllerAnimated:YES completion:nil]; // OLD METHOD
    [UIView animateWithDuration:CONfadeDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ { self.view.alpha = 0; } completion:^(BOOL finished)
     { if(finished)
     {
         [self.navigationController.view removeFromSuperview];
         //         [self.view removeFromSuperview];
         if ( [self.navigationController.parentViewController.view viewWithTag:CONfadeTag] ) {
             UILabel *killLabel = [self.navigationController.parentViewController.view viewWithTag:CONfadeTag];
             killLabel.alpha = 0;
             [killLabel removeFromSuperview];
         }
         
     }
     }];
}
// UPDATE CURRENTIDLYFRIENDCOUNT WITH DSRAIP METHOD
- (void) setcurrentFriendCount: (NSInteger) currentCountFromDSRAIP {
    // create array of all nav controllers current views
    NSArray *navContArray = self.navigationController.view.subviews;
    // loop through array to look for friendcountlabel one
    for (UIView *view in navContArray)
    {
        // WHEN you find the friendcountlabel one, update it
        if (view.tag == CONtablePopUpFriendCounTag)
        {
            // kill the old number view
            [view removeFromSuperview];
            // create a new one
            NSString *currentIdlyFriendText = [NSString stringWithFormat:@"%d", currentCountFromDSRAIP];
            // add it to the nav controller
            UILabel *popupFriendCount       = [[UILabel alloc] initWithFrame:CGRectMake(60, ((5*(CONtablePopUpNavbarHeight - CONtablePopUpNavbarIconH))/6)+7, 60, CONtablePopUpNavbarIconH)];
            popupFriendCount.tag            = CONtablePopUpFriendCounTag;
            popupFriendCount.text           = currentIdlyFriendText;
            [popupFriendCount setTextColor:[UIColor CONidlyPaleBlue]];
            [popupFriendCount setNumberOfLines:3];
            popupFriendCount.font           = [UIFont fontWithName:@"Helvetica-Bold" size:40.0f];
            popupFriendCount.textAlignment  = NSTextAlignmentCenter;
            popupFriendCount.userInteractionEnabled = NO;
            [self.navigationController.view addSubview:popupFriendCount];
        }
    }
    
}



- (void)_setDictMethod {
        [_myCondition lock];
    [Vars_AND_Constants setParseCurrentFriendsDictX]; // <- FUNCTION HERE
        _someCheckIsTrue = YES;
        [_myCondition signal];
        [_myCondition unlock];
} // <- unused
- (void)_dropMethod {
    [_myCondition lock];
    [Vars_AND_Constants setParseCurrentFriendsDictX]; // <- FUNCTION HERE
    _someCheckIsTrue = YES;
    [_myCondition signal];
    [_myCondition unlock];
}   // <- unused
- (void)_addMethod {
    [_myCondition lock];
    [Vars_AND_Constants setParseCurrentFriendsDictX]; // <- FUNCTION HERE
    _someCheckIsTrue = YES;
    [_myCondition signal];
    [_myCondition unlock];
}   // <- unused
- (void)_cancelMethod {
        [_myCondition lock];
        while (!_someCheckIsTrue) {
        [_myCondition wait];
    }
    [self TestCancel:self]; // <- FUNCTION HERE
        [_myCondition unlock];
} // <- unused

#pragma mark - Get Phone Contacts Method

// GET CONTACTS METHOD X
- (NSMutableArray *)getPhoneContactsMTVC {
    // Request authorization to Address Book
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    // *** INITIALIZE AN ARRAY and DICT TO HOLD THE CONTACTS
    _displayContactsArray                     = [[NSMutableArray alloc] init]; // ALL I HAD TO DO WAS NIX NSMUTABLEARRAY *
    
    // CREATE ADDRESSBOOKS TO ACCESS CONTACTS
    CFErrorRef *error                       = nil;
    ABAddressBookRef addressBook            = ABAddressBookCreateWithOptions(NULL, error);
    ABRecordRef source                      = ABAddressBookCopyDefaultSource(addressBook);
    NSArray *array                          = (__bridge NSArray *)
    (ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByLastName));
    
    // LOOP THROUGH ADDRESSBOOK ARRAY TO PULL OUT VALUES FOR EACH ENTRY (phone, name, & type values)
    for (id entry in array) {
        NSString *nameFirst         = (__bridge_transfer NSString*)ABRecordCopyValue((__bridge ABRecordRef)(entry), kABPersonFirstNameProperty);
        NSString *nameLast          = (__bridge_transfer NSString*)ABRecordCopyValue((__bridge ABRecordRef)(entry), kABPersonLastNameProperty);
        NSString *nameFull          = [NSString stringWithFormat:@"%@ %@", nameFirst, nameLast];
        NSString *mobile            = @"";
        ABMultiValueRef phonesZ     = (ABMultiValueRef)ABRecordCopyValue((__bridge ABRecordRef)(entry), kABPersonPhoneProperty);
        NSInteger countZ            = ABMultiValueGetCount(phonesZ);       // my code
        UIImage *contactImage       = [UIImage imageWithData:(__bridge NSData *)ABPersonCopyImageDataWithFormat((__bridge ABRecordRef)(entry),kABPersonImageFormatThumbnail)];
        
        // LOOP THROUGH EACH ENTRY AS MULTIVALUE & ADD INDIVIDUAL VALUES TO ARRAY & DICT
        for (int i=0; i < ABMultiValueGetCount(phonesZ); i++) {
            NSString *phoneLabelZ = (__bridge NSString *)ABMultiValueCopyLabelAtIndex(phonesZ, i);
            // THIS IS THE CODE THAT ACTUALLY GETS THE PHONE NUMBER
            mobile = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phonesZ, i);
            // CLEAN UP THE FORMATS OF THE CONTACT
            NSString *cleanFullName     =
            [nameFull stringByReplacingOccurrencesOfString:@"\"" withString:@""]; // this doesn't appear to be working
            NSString *cleanPhoneNumber  =
            
            [[[[[mobile stringByReplacingOccurrencesOfString:@"-" withString:@""]
                stringByReplacingOccurrencesOfString:@"(" withString:@""]
               stringByReplacingOccurrencesOfString:@")" withString:@""]
              stringByReplacingOccurrencesOfString:@" " withString:@""]
             stringByReplacingOccurrencesOfString:@" " withString:@""];
            // PULL OUT NUMBERS STARTING WITH 1 & 0 (optional)
            NSString *firstChar = [cleanPhoneNumber substringToIndex:1];
            if ( [firstChar  isEqual: @"0"] ) {
                cleanPhoneNumber = [cleanPhoneNumber substringFromIndex:1];
            }
            NSString *nextChar  = [cleanPhoneNumber substringToIndex:1];
            if ( [nextChar  isEqual: @"1"] ) {
                cleanPhoneNumber = [cleanPhoneNumber substringFromIndex:1];
            }
            NSString *lastChar  = [cleanPhoneNumber substringToIndex:1];
            if ( [lastChar  isEqual: @"0"] ) {
                cleanPhoneNumber = [cleanPhoneNumber substringFromIndex:1];
            }
            NSString *cleanPhoneLabel   = [[phoneLabelZ stringByReplacingOccurrencesOfString:@"_$!<" withString:@""]
                                           stringByReplacingOccurrencesOfString:@">!$_" withString:@""];
            
            /*
            // TAKE THIS OUT WHEN HOOKED UP TO PARSEDB ************************************************************************************
            NSString *notesCheck     = (__bridge_transfer NSString*)ABRecordCopyValue((__bridge ABRecordRef)(entry), kABPersonNoteProperty);
            NSString *isAVBBOOL      = [[NSString alloc]init];
            if (notesCheck) {
                isAVBBOOL   = CRSyes;
            } else {
                isAVBBOOL   = CRSno;
            }
            // *** DICT UNDEFINED
            [_displayChecksDict setObject:isAVBBOOL forKey:cleanPhoneNumber];
            */ // <- TAKE OUT
            
            // NOW LET'S TRY CRAETING A WHOLE OBJECT AND PASSING IT INTO AN ARRAY OF OBJECTS
            ContactObject *contactFA = [[ContactObject alloc] init];
            contactFA.fullName        = cleanFullName;
            contactFA.firstName       = nameFirst;
            contactFA.lastName        = nameLast;
            contactFA.numberType      = cleanPhoneLabel;
            contactFA.number          = cleanPhoneNumber;
            contactFA.contactpic      = contactImage;
            
            /*
            // TAKE THIS OUT WHEN HOOKED UP TO PARSEDB ************************************************************************************
            contactFA.isAVBObject     = isAVBBOOL;
             */ // <- TAKE OUT
            
            [_displayContactsArray addObject:contactFA];
        }
    }
    
    return _displayContactsArray;
    
}




@end
