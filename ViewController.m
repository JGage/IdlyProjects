//
//  ViewController.m
//  Altogether
//
//  Created by josh on 10/24/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"
#import "SWRevealViewController.h"

//#import "MyLoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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


#pragma mark -  ViewDid Functions
// viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // LOGIN: current-user
        if ([PFUser currentUser]) {
        // [self startTest];
        NSLog(@"commented out above");
    } else {
        NSLog(@"NO CURRENT USER");
    }

    // DEVICE
        /*
     NSString *platformString = [Vars_AND_Constants platformString];
     CGRect screenRect = [[UIScreen mainScreen] bounds];
     CGFloat screenWidth = screenRect.size.width;
     CGFloat screenHeight = screenRect.size.height;
     */ // <- dims
        // - properties -
        self.title = nil;
        self.navigationController.title = CONnavyTit;
        self.view.tag = CONMVCTag;
        [self setNeedsStatusBarAppearanceUpdate];
    
    // TABS
        [self addTabsMethod];
 
    // DAYMESSAGE
    for (int i = 0 ; i <= CONnumberDaySections; i++ ) {
        [self addDayMessages:(CONdaySectionStartH + ( i * CONdaySectionHeight)) fontName:CONdayMessageFont fontSize:10];
    }
    
    // DAYQUAD
        for (int i = 0 ; i <= CONnumberDaySections; i++ ) {
        [self addDayQuads:(CONdaySectionStartH + CONdayTextSectionH + (i * CONdaySectionHeight))];
    }
    
    // GESTURE-RECOGNIZER
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    // CONTACTS COUNTER
        // - outgoing -
        [self getANDsetOutgoingFriendsCount];
    
    // CONTACTS COUNTER
        // - incoming -
        [self setIncomingContactsCounts];
  
    // get parse results first
    // then set the counter(s)
    /*
     [self performSelectorInBackground:@selector(getOutgoingFriendsCount) withObject:nil];
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     sleep(2);
     [self performSelectorInBackground:@selector(setOutgoingContactsCount) withObject:nil];
     });
     */
    
    // PARSE QUERY
    /*
    // - get friends ObjectId's -
    //[Vars_AND_Constants setParseCurrentFriendsDictX];
    // - get friends OTGStatus -
    //[Vars_AND_Constants getParseFriendsOTGStatus];
    */
    
}

#pragma mark - Initial View Methods
// TABS (me & friends)
- (void) addTabsMethod {
    // TABS SECTION
    // background view for DEMOgrey
    float tabWidths                 = (self.view.frame.size.width - CONbasementClosedWidth)/2;
    UIView *tabBackground           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2*(tabWidths), CONtabHeight)];
    tabBackground.backgroundColor   = [UIColor DEMObasementGray];
    [self.view addSubview:tabBackground];
    // tab1
    // bezzier dims
    float buttonW = tabWidths;
    float buttonH = CONtabHeight;
    float buttonStartX = 0;
    float buttonStartY = CONtabHeight;
    CGPoint BStart  = CGPointMake(buttonStartX, buttonStartY);
    CGPoint BBL     = CGPointMake(buttonStartX, buttonStartY);
    CGPoint BTL     = CGPointMake(buttonStartX + (buttonW/4), buttonStartY - buttonH);
    CGPoint BTR     = CGPointMake(buttonStartX + buttonW, buttonStartY - buttonH);
    CGPoint BBR     = CGPointMake(buttonStartX + buttonW, buttonStartY);
    // create bezzier path object
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    [aPath moveToPoint:BStart];
    // draw path lines
    [aPath addLineToPoint: BBL];
    [aPath addLineToPoint: BTL];
    [aPath addLineToPoint: BTR];
    [aPath addLineToPoint: BBR];
    // close path
    [aPath closePath];
    // create button object
    UIButton *tabOne    = [UIButton buttonWithType:UIButtonTypeCustom];
    [tabOne addTarget:self
               action:@selector(tabOneCalled)
     forControlEvents:UIControlEventTouchUpInside];
    [tabOne setTitle:@"ME" forState:UIControlStateNormal];
    tabOne.tintColor = [UIColor DEMObasementGray];
    tabOne.showsTouchWhenHighlighted = YES;
    tabOne.frame = CGRectMake(0, 0, tabWidths, CONtabHeight);
    // ca layer(s)
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = tabOne.bounds;
    shapeLayer.path = aPath.CGPath;
    shapeLayer.fillColor = [UIColor whiteColor].CGColor;
    // CATEXTLAYER LABEL
    CATextLayer *label = [[CATextLayer alloc] init];
    [label setFont:@"Helvetica-Neue"];
    [label setFontSize:15];
    CGRect rectLabel = CGRectMake(0, CONstatusBarHeight/2, tabWidths, CONtabHeight);
    [label setFrame: rectLabel];
    [label setString:@"ME"];
    [label setAlignmentMode:kCAGravityCenter]; // <- ORIGINAL WAS: kCAAlignmentCenter
    [label setForegroundColor:[[UIColor grayColor] CGColor]]; //label.zPosition=99;
    [tabOne.layer addSublayer:shapeLayer];
    [tabOne.layer  addSublayer:label];
    [self.view addSubview:tabOne];
    tabOne.userInteractionEnabled = YES;
    // tab2
    UIButton *tabTwo        = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tabTwo addTarget:self
               action:@selector(tabTwoCalled)
     forControlEvents:UIControlEventTouchUpInside];
    tabTwo.backgroundColor  = [UIColor whiteColor];
    [tabTwo setTitle:@"FRIENDS" forState:UIControlStateNormal];
    tabTwo.tintColor        = [UIColor grayColor];
    tabTwo.frame            = CGRectMake(tabWidths - 1, 0, tabWidths + 1, CONtabHeight);
    [self.view addSubview:tabTwo];
    /*
     //[[tabTwo layer] setBorderWidth:CONtabBorderWidth];
     //[[tabTwo layer] setBorderColor:[UIColor grayColor].CGColor]; // ooooh Layer Properties
     // TAB BORDERS
     UIView *topBorderT = [[UIView alloc] initWithFrame:CGRectMake(1, 0, tabTwo.frame.size.width, 1 )];
     topBorderT.backgroundColor = [UIColor grayColor];
     [tabTwo addSubview:topBorderT];
     */ // <- TAB BORDERS (may be needed for future button press
    UIView *leftBorderT     = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, tabTwo.frame.size.height)];
    leftBorderT.backgroundColor = [UIColor grayColor];
    [tabTwo addSubview:leftBorderT];
}
// DAY SECTION
- (void) addDayQuads: (float)passedButtonPositionY {

    // BUTTON POSITIONS X
    float spaceBetweenButtonsX  = CONbuttonDimW - 2;
    float mornX                 = CONmornStartX;
    float noonX                 = mornX  + spaceBetweenButtonsX;
    float nightX                = noonX  + spaceBetweenButtonsX;
    float lateX                 = nightX + spaceBetweenButtonsX;
    // NO "Y" VARIABLES NECESSARY
    
    // MORNING
    UIButton *buttonMorn       = [[UIButton alloc] initWithFrame:CGRectMake(mornX, passedButtonPositionY, CONbuttonDimW, CONbuttonDimH)];
    buttonMorn.backgroundColor = [UIColor clearColor];
    [buttonMorn setImage:[UIImage imageNamed:@"MornG"] forState:UIControlStateNormal];
    
    [self.view addSubview:buttonMorn];
    // NOON
    UIButton *buttonNoon       = [[UIButton alloc] initWithFrame:CGRectMake(noonX, passedButtonPositionY, CONbuttonDimW, CONbuttonDimH)];
    buttonNoon.backgroundColor = [UIColor clearColor];
    [buttonNoon setImage:[UIImage imageNamed:@"NoonG"] forState:UIControlStateNormal];
    [self.view addSubview:buttonNoon];
    // NIGHT
    UIButton *buttonNight      = [[UIButton alloc] initWithFrame:CGRectMake(nightX, passedButtonPositionY, CONbuttonDimW, CONbuttonDimH)];
    buttonNight.backgroundColor = [UIColor clearColor];
    [buttonNight setImage:[UIImage imageNamed:@"NightG"] forState:UIControlStateNormal];
    [self.view addSubview:buttonNight];
    // LATE
    UIButton *buttonLate       = [[UIButton alloc] initWithFrame:CGRectMake(lateX, passedButtonPositionY, CONbuttonDimW, CONbuttonDimH)];
    buttonLate.backgroundColor = [UIColor clearColor];
    [buttonLate setImage:[UIImage imageNamed:@"LateG"] forState:UIControlStateNormal];
    [self.view addSubview:buttonLate];
}
- (void) getANDsetOutgoingFriendsCount {
    [self performSelectorInBackground:@selector(getOutgoingFriendsCount) withObject:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        [self performSelectorInBackground:@selector(setOutgoingContactsCount) withObject:nil];
    });
}
- (void) addDayMessages: (float)passedTextFieldPositionY fontName:(NSString *)fontName fontSize:(int)fontSize {
 
    UILabel *dayMessage                 = [[UILabel alloc] initWithFrame:CGRectMake(CONmornStartX, passedTextFieldPositionY, CONdayTextSectionW, CONdayTextSectionH)];
    dayMessage.text                     = @"this is a test and only a test of the emergency broadcast system, so this is a test and only a test..." ;
    dayMessage.textColor                = [UIColor blackColor];
    dayMessage.backgroundColor          = [UIColor clearColor];
    dayMessage.font                     = [UIFont fontWithName:fontName size:fontSize];
    [dayMessage setLineBreakMode:NSLineBreakByWordWrapping];
    [dayMessage setNumberOfLines: 3 ];
    [self.view addSubview:dayMessage];
}
#pragma mark - Parse TIMED Methods
// CONTACT COUNTER METHODS
// - get -
- (void) getOutgoingFriendsCount    {
    [_myCondition lock];   // <- LOCK CODE
    
    [Vars_AND_Constants getParseFriendsOTGStatus];
 
    _someCheckIsTrue = YES;// <- LOCK CODE
    [_myCondition signal]; // <- LOCK CODE
    [_myCondition unlock]; // <- LOCK CODE
}
// - set -
- (void) setOutgoingContactsCount   {
    [_myCondition lock];              // <- LOCK CODE
    while (!_someCheckIsTrue) {
        [_myCondition wait];
    }   // <- LOCK CODE
   
    // get current OUTGOING count
    varOutgoingCount = 0;
    for (NSString *friendPhone in parseCurrentFriendsOTGStatus) {
        NSString *activeYN = [parseCurrentFriendsOTGStatus objectForKey:friendPhone];
        if ([activeYN isEqualToString:@"Active"]) {
            varOutgoingCount = varOutgoingCount + 1;
            //NSLog(@"%d", varOutgoingCount);
        }
    }
    
    // set counter accordingly
    [self addContactCounterButtonAndLabel: CONcontactsPositionStartX
                                  passedY: CONdaySectionStartH - CONcontactsDimH - 5
                                  picName: @"USER"
                                     dimW: CONcontactCounterDimW
                                     dimH: CONcontactCounterDimH
                                fontColor: [UIColor CONidlyPalePink]
                                 fontSize: CONcontactCounterFontSize
                               fillNumber: varOutgoingCount
                                buttonTag: CONOTGfriendCounterTag
     ];
        [_myCondition unlock]; // <- LOCK CODE
}
- (void) setIncomingContactsCounts  {
     // run through Each Day
    for (int i = 0 ; i <= CONnumberDaySections; i++ ) {
        // RUN METHOD TO GET NUMBER BY DAY
        [self addContactCounterButtonAndLabel: CONcontactsPositionStartX
                                      passedY: (CONdaySectionStartH + ( i * CONdaySectionHeight))
                                      picName: @"Contacts"
                                         dimW: (CONcontactCounterDimW - 5)
                                         dimH: (CONcontactCounterDimH - 5)
                                    fontColor: [UIColor CONidlyPaleBlue]
                                     fontSize: (CONcontactCounterFontSize * .9)
                                   fillNumber: i
                                    buttonTag: i
         ];
    }
}
// THIS METHOD CREATES BOTH THE BUTTON AND LABEL AND THEN MAKES IT PRESSABLE
- (void) addContactCounterButtonAndLabel:   (float)     passedButtonPositionX
                                 passedY:   (float)     passedButtonPositionY
                                 picName:   (NSString*) picName
                                    dimW:   (float)     width
                                    dimH:   (float)     height
                               fontColor:   (UIColor*)  color
                                fontSize:   (float)     fontsize
                              fillNumber:   (int)       fillNumber
                               buttonTag:   (int)       tag {
    // CONTACT BUTTON <- replace with image
    float OTGcontactImageW              = (width    * .6);
    float OTGcontactImageH              = (height   * .6);
    float OTGcontactCounterW            = (width    * .8);
    float OTGcontactCounterH            = (height   * .8);
    float widthAddition                 = (width    - OTGcontactCounterW);
    float heightAddition                = (height   - OTGcontactCounterH);
    
    // IMAGE
    UIImage *imageContactsOtg           = [UIImage imageNamed:picName];
    UIImageView *imageViewContactsOtg   = [[UIImageView alloc] initWithImage:imageContactsOtg];
    imageViewContactsOtg.frame          = CGRectMake(0 + widthAddition, 0 + heightAddition, OTGcontactImageW, OTGcontactImageH);
    imageViewContactsOtg.alpha          = .5;
    // LABEL
    UILabel *labelContactsOtg           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, OTGcontactCounterW, OTGcontactCounterH)];
    labelContactsOtg.backgroundColor    = [UIColor clearColor];
    NSString *intString                 = [NSString stringWithFormat:@"%d", fillNumber];
    labelContactsOtg.text               = intString;
    labelContactsOtg.textColor          = color;
    labelContactsOtg.font               = [UIFont fontWithName:CONcontactCounterFont size:fontsize];
    // BUTTON
    CGRect pressableViewRect            = CGRectMake(passedButtonPositionX, passedButtonPositionY, width, height);
    UIButton *pressableView             = [[UIButton alloc] initWithFrame:pressableViewRect];
    pressableView.backgroundColor       = [UIColor whiteColor];
    pressableView.tag                   = tag;
    [pressableView addSubview:imageViewContactsOtg];
    [pressableView addSubview:labelContactsOtg];
    pressableView.userInteractionEnabled = YES;
    // instead of making the selector a variable, i will make it a method which passes in an argument like button tag
    [pressableView addTarget:self action:@selector(outgoingContactsView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pressableView];
//    [self.view addSubview:labelContactsOtg];

}


// viewDidAppear IS THE SIGNUP/LOGIN CODE
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
// create:  LOGIN & SIGNUP VC's
    if (![PFUser currentUser]) { // No user logged in
        NSLog(@"no user logged in");
        // Create the log in view controller
        MyLoginViewController *logInViewController = [[MyLoginViewController alloc] init];
        logInViewController.delegate = self;
//        logInViewController.signUpController.delegate = self;
        // Present the log in view controller
        MySignupViewController *signUpViewController = [[MySignupViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];

        [self presentViewController:logInViewController animated:YES completion:NULL];
        
    }
// set:     USERNAME & PASSWORD from "currentUser" OBJECT
    NSString *loggedInUsername = [[PFUser currentUser]username];
    NSString *loggedInPassword = [[PFUser currentUser]objectId];
// label:   VALUES <- NEED TO DEPRECATE
    _currentUsername.text = loggedInUsername;
    _currentPassword.text = loggedInPassword;
    
    
}

// initWithNibName
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// BM - TAB BUTTON ACTIONS
- (void)tabOneCalled {
    NSLog(@"tabOne called!!!");
    [self getANDsetOutgoingFriendsCount];
}
- (void)tabTwoCalled {
    NSLog(@"tabTwo called!!!");
}
// CONTACT COUNTER METHOD
- (void)outgoingContactsView {
    NSLog(@"method is working");
}
// DRMW - UNUSED
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parse Delegate Sign-Up Functions
// VC-SU-1 Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(MySignupViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    NSLog(@"chekc check yo");
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
    NSLog(@"VC-SU-1: Sign-Up Request checked for submission to server");
    return informationComplete;
}
// VC-SU-2 Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(MySignupViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
    NSLog(@"VC-SU-2: PFUser is signed up WHAT");
}
// VC-SU-3 Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(MySignupViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"VC-SU-3: Failed to sign up...SUP SUP");
}
// VC-SU-4 Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(MySignupViewController *)signUpController {
    NSLog(@"VC-SU-4: User dismissed the signUpViewController HERE");
}
#pragma mark - Parse Delegate Log-In Functions
// VC-LI-1 Sent to the delegate to determine whether the log in request should be submitted to the server.
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
    NSLog(@"VC-LI-1: Login Request checked for submission to server");
    return NO; // Interrupt login process
}
// VC-LI-2 Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self viewDidLoad];
    NSLog(@"VC-LI-2: PFUser is logged in");
}
// THE 2 METHODS BELOW: "handle a failed login attempt or a user tapping on the top left dismiss button"
// VC-LI-3 Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"VC-LI-3: Failed to log in...");
}
// VC-LI-4 Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"VC-LI-4: login screen dismissed");
}

#pragma mark - DEPRECATED
// OLD CODE FROM VDL
/*
- (void) VDLfake {
    
     // DAY SECTIONS
     int numberOrDays    = 4; // <- INCLUDING "0"
     for (int i = 0 ; i <= numberOrDays; i++ ) {
     // RUN METHOD TO GET NUMBER BY DAY
     [self addContactCount:CONcontactsPositionStartX
     passedY:(CONdayOneStartH + ( i * CONdaySectionHeight))
     picName:@"Contacts"
     dimW:(CONcontactCounterDimW - 5)
     dimH:(CONcontactCounterDimH - 5)
     fontColor:[UIColor CONidlyPaleBlue]
     fontSize:(CONcontactCounterFontSize * .9)
     fillNumber:i // <- CHANGE THIS TO NUMBER FROM ABOVE METHOD
     ];
     
     } // <- CONTACT COUNT METHOD
      // <- OLD CODE FOR INCOMING CONTACTS COUNTER
    
     [self addContactCount:CONcontactsPositionStartX
     passedY:CONdayOneStartH - CONcontactsDimH - 5
     picName:@"USER"
     dimW:CONcontactCounterDimW
     dimH:CONcontactCounterDimH
     fontColor:[UIColor CONidlyPalePink]
     fontSize:CONcontactCounterFontSize
     fillNumber:13
     ];
     // <- OLD CODE FOR OUTGOING CONTACTS COUNTER
    
     parseCurrentFriendsX = [[NSMutableDictionary alloc] init];
     PFQuery *currentFriends         =   [PFQuery queryWithClassName:@"Contacts"];
     [currentFriends whereKey:@"UserID" equalTo:[[PFUser currentUser] objectId]];
     [currentFriends findObjectsInBackgroundWithBlock:^(NSArray *currentFriend, NSError *errer) {
     //int FriendCount = currentFriend.count;
     for (PFObject *friend in currentFriend) {
     NSString *phone     = friend[@"phone"];
     NSString *objectId  = friend.objectId;
     [parseCurrentFriendsX setObject:objectId forKey:phone];
     //[parseCurrentFriendsX addObject:phone];
     //[parseCurrentFriendsX addObject:objectId];
     }
     }];
     // <- OLD CODE FOR PARSE STUFF
     // <- this is added part 1
     // background view for DEMOgrey
     float tabWidths                 = (self.view.frame.size.width - CONbasementClosedWidth)/2;
     UIView *tabBackground           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2*(tabWidths), CONtabHeight)];
     tabBackground.backgroundColor   = [UIColor DEMObasementGray];
     [self.view addSubview:tabBackground];
     // tab1
     // bezzier dims
     float buttonW = tabWidths;
     float buttonH = CONtabHeight;
     float buttonStartX = 0;
     float buttonStartY = CONtabHeight;
     CGPoint BStart  = CGPointMake(buttonStartX, buttonStartY);
     CGPoint BBL     = CGPointMake(buttonStartX, buttonStartY);
     CGPoint BTL     = CGPointMake(buttonStartX + (buttonW/4), buttonStartY - buttonH);
     CGPoint BTR     = CGPointMake(buttonStartX + buttonW, buttonStartY - buttonH);
     CGPoint BBR     = CGPointMake(buttonStartX + buttonW, buttonStartY);
     // create bezzier path object
     UIBezierPath *aPath = [UIBezierPath bezierPath];
     [aPath moveToPoint:BStart];
     // draw path lines
     [aPath addLineToPoint: BBL];
     [aPath addLineToPoint: BTL];
     [aPath addLineToPoint: BTR];
     [aPath addLineToPoint: BBR];
     // close path
     [aPath closePath];
     // create button object
     UIButton *tabOne    = [UIButton buttonWithType:UIButtonTypeCustom];
     [tabOne addTarget:self
     action:@selector(tabOneCalled)
     forControlEvents:UIControlEventTouchUpInside];
     [tabOne setTitle:@"ME" forState:UIControlStateNormal];
     tabOne.tintColor = [UIColor DEMObasementGray];
     tabOne.showsTouchWhenHighlighted = YES;
     tabOne.frame = CGRectMake(0, 0, tabWidths, CONtabHeight);
     // ca layer(s)
     CAShapeLayer *shapeLayer = [CAShapeLayer layer];
     shapeLayer.frame = tabOne.bounds;
     shapeLayer.path = aPath.CGPath;
     shapeLayer.fillColor = [UIColor whiteColor].CGColor;
     // CATEXTLAYER LABEL
     CATextLayer *label = [[CATextLayer alloc] init];
     [label setFont:@"Helvetica-Neue"];
     [label setFontSize:15];
     CGRect rectLabel = CGRectMake(0, CONstatusBarHeight/2, tabWidths, CONtabHeight);
     [label setFrame: rectLabel];
     [label setString:@"ME"];
     [label setAlignmentMode:kCAGravityCenter]; // <- ORIGINAL WAS: kCAAlignmentCenter
     [label setForegroundColor:[[UIColor grayColor] CGColor]]; //label.zPosition=99;
     [tabOne.layer addSublayer:shapeLayer];
     [tabOne.layer  addSublayer:label];
     [self.view addSubview:tabOne];
     tabOne.userInteractionEnabled = YES;
     // tab2
     UIButton *tabTwo        = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     [tabTwo addTarget:self
     action:@selector(tabTwoCalled)
     forControlEvents:UIControlEventTouchUpInside];
     tabTwo.backgroundColor  = [UIColor whiteColor];
     [tabTwo setTitle:@"FRIENDS" forState:UIControlStateNormal];
     tabTwo.tintColor        = [UIColor grayColor];
     tabTwo.frame            = CGRectMake(tabWidths - 1, 0, tabWidths + 1, CONtabHeight);
     [self.view addSubview:tabTwo];
    
     //[[tabTwo layer] setBorderWidth:CONtabBorderWidth];
     //[[tabTwo layer] setBorderColor:[UIColor grayColor].CGColor]; // ooooh Layer Properties
     // TAB BORDERS
     UIView *topBorderT = [[UIView alloc] initWithFrame:CGRectMake(1, 0, tabTwo.frame.size.width, 1 )];
     topBorderT.backgroundColor = [UIColor grayColor];
     [tabTwo addSubview:topBorderT];
     // <- OLD CODE FOR TAB BORDERS
}
*/ // <- REPLACED WITH METHODS
// OLD CODE FROM PARSE DELEGATES
// first section SIGNUP
/*
 // VC-SU-1 Sent to the delegate to determine whether the sign up request should be submitted to the server.
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
 NSLog(@"VC-SU-1: Sign-Up Request checked for submission to server");
 return informationComplete;
 }
 // VC-SU-2 Sent to the delegate when a PFUser is signed up.
 - (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
 [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
 NSLog(@"VC-SU-2: PFUser is signed up");
 }
 // VC-SU-3 Sent to the delegate when the sign up attempt fails.
 - (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
 NSLog(@"VC-SU-3: Failed to sign up...");
 }
 // VC-SU-4 Sent to the delegate when the sign up screen is dismissed.
 - (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
 NSLog(@"VC-SU-4: User dismissed the signUpViewController");
 }
 */ // <- ORIGINAL CODE
// second section LOGIN
/*
 // VC-LI-1 Sent to the delegate to determine whether the log in request should be submitted to the server.
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
 NSLog(@"VC-LI-1: Login Request checked for submission to server");
 return NO; // Interrupt login process
 }
 // VC-LI-2 Sent to the delegate when a PFUser is logged in.
 - (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
 [self dismissViewControllerAnimated:YES completion:NULL];
 [self viewDidLoad];
 NSLog(@"VC-LI-2: PFUser is logged in");
 }
 // THE 2 METHODS BELOW: "handle a failed login attempt or a user tapping on the top left dismiss button"
 // VC-LI-3 Sent to the delegate when the log in attempt fails.
 - (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
 NSLog(@"VC-LI-3: Failed to log in...");
 }
 // VC-LI-4 Sent to the delegate when the log in screen is dismissed.
 - (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
 [self.navigationController popViewControllerAnimated:YES];
 NSLog(@"VC-LI-4: login screen dismissed");
 }
 */ // <- ORIGINAL CODE


@end
