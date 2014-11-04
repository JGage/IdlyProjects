
#import "SidebarViewController.h"
//#import "ImageViewController.h"
#import "SWRevealViewController.h"
//#import "ImageViewController.h" // not sure why this is in here twice but... play with it and see

@interface SidebarViewController ()

@property (nonatomic, strong) NSArray *menuItems; // <- this is everywhere

@end

@implementation SidebarViewController

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
// <- CONDITIONAL LOCK CODE


// NADA
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// SET CONSTANTS FOR CELL IDENTIFIERS
- (void)viewDidLoad {
    [super viewDidLoad];
    
    varDeviceWidth = self.view.frame.size.width;    // <- MUST SET DEVICE DIMS HERE (prob could find a more elegant way)
    varDeviceHeight = self.view.frame.size.height;  // <- MUST SET DEVICE DIMS HERE (prob could find a more elegant way)
    [self setNeedsStatusBarAppearanceUpdate];       // <- MUST GET APPEARANCE UPDATE HERE
    
    self.view.backgroundColor = [UIColor DEMObasementGray];
    self.tableView.backgroundColor = [UIColor DEMObasementGray];
    self.tableView.separatorColor = [UIColor grayColor];
    self.tableView.alwaysBounceVertical = NO; // <- DISABLE SCROLLING FOR NOW
    // THIS DICTATES THE ORDER IN WHICH THE CELLS ARE CALLED
    _menuItems = @[ @"menu", @"USER", @"contacts", @"comment", @"settings", @"privacy", @"calendar" ];
    

    
} // <- HERE'S WHERE THE TABLE CELLS ARE SPECIFIED

// NADA
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// SECTIONS - set this to section-per-person name
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}
// ROWS
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.menuItems count];
}
// SET TABLEVIEW CELL HEIGHTS
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
    // ABOVE IS CUSTOM TABLE CELL HEIGHT
    // STANDARD HEIGHT IS 44 (below)
    // return 44.0;
}
// CONFIGURE TABLEVIEW CELL
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // make a cell
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // set it's props
    [cell setBackgroundColor:[UIColor DEMObasementGray]];
    // cell.textLabel.font = [UIFont fontWithName:@"Helvetica light" size:12.0f];
    [cell setFrame:CGRectMake(0, 0, self.view.frame.size.width, CONbasementCellHeight)];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone; // below is same as this
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // give it an image
    UIImage *image = [UIImage imageNamed: CellIdentifier];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, ((CONbasementCellHeight - CONbasementCellImageHW)/2) + 4, CONbasementCellImageHW, CONbasementCellImageHW)];
    [imageView setImage:image];
    [cell addSubview:imageView];
    // give it a label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, ((CONbasementCellHeight - CONbasementCellImageHW)/2) + 4, 120, CONbasementCellImageHW)];
    label.font = [UIFont fontWithName:@"Helvetica light" size:20.0f];
    label.textColor = [UIColor lightGrayColor];
    label.text = CellIdentifier;
    [cell addSubview:label];


    return cell;
    
}
// TABLEVIEW SELECT METHOD
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // GET PHONE VALUE AT SELECTED CELL
    NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    UITableViewCell *selectedCell = (UITableViewCell *)[tableView cellForRowAtIndexPath:ip];
   
    // if row is "Contacts" row -> AB-POPUP
    if (ip.row == 2) {
        
        // CREATE ADDRESSBOOK REF
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        // CASE 1: first time ask via popup -> DO NOTHING, WAIT FOR 2ND CLICK
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
            ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) { NSLog(@"Grant AB Access"); });
        }
        // CASE 2: access already granted -> PRESENT NEXT VIEW
        else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            
            /*
            // <- start AB POPUP CODE
            // step.1 - CREATE FADE LAYER
            UILabel *labelForFadeX           = [[UILabel alloc] initWithFrame:self.view.frame];
            [labelForFadeX setTag:CONfadeTag];
            labelForFadeX.backgroundColor    = [UIColor whiteColor];
            labelForFadeX.alpha              = CONfadeAlpha;
            labelForFadeX.userInteractionEnabled = YES;
            [self.parentViewController.view addSubview:labelForFadeX];
            // step.2 - CREATE BACKGROUND VC (for popup view) & NAVIGATION CONTROLLER
            MyTableViewController    *PUTviewController          = [[MyTableViewController alloc]init];
            UINavigationController   *PUTNavigationController    = [[UINavigationController alloc] initWithRootViewController:PUTviewController];
            PUTNavigationController.view.frame = CGRectMake((varDeviceWidth/2) - (CONtablePopUpWidth/2),
                                                            (varDeviceHeight/2) - (CONtablePopUpHeight/2),
                                                            CONtablePopUpWidth,
                                                            CONtablePopUpHeight);
            [self setRoundedBorder:CONpopupEdgeCurvature borderWidth:CONpopupBorderRadius color:[UIColor blackColor] view:PUTNavigationController.view];
            // step.3 - MOVE/ASSIGN ALL CONTROLLERS
            [PUTNavigationController            willMoveToParentViewController:self];
            [self.parentViewController.view     addSubview:PUTNavigationController.view];
            [self.parentViewController          addChildViewController:PUTNavigationController];
            [PUTNavigationController            didMoveToParentViewController:self];
            
            // step.4 - TRANSITION BLOCK
            [UIView animateWithDuration:CONfadeDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ {
                PUTviewController.view.alpha = 1;
            } completion:nil];
            */ // <- end - OLD - AB POPUP CODE
            // - update setParseCurrentFriendsDictX - (before calling AB-POPUP, query Parse)
            [self performSelectorInBackground:@selector(_firstMethod) withObject:nil];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                sleep(1);
                [self performSelectorInBackground:@selector(_secondMethod) withObject:nil];
            });

            
        }
        // CASE 3: access previously denied in SETTINGS -> NO SEGUE, PRESENT POPUP INSTEAD
        else  {
            // Send an alert telling user to change privacy setting in settings app
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ROFL"
                                                            message:@"You have previously denied Idly access to your Contacts. Please go into your settings and allow Idly access."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            // cancel segue
        }
        
        
    }
    // otherwise...
    else {
        NSLog(@"tag %d was tapped", ip.row);
    }
    
}


#pragma mark - PREPARE FOR SEGUE (used for loading basement and addressbook)

// NONE OF THIS IS NECESSARY TO AB ANYMORE
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender {
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // PHOTO VIEW CONTROLLER
    if ([segue.identifier isEqualToString:@"showImage"]) {
        NSLog(@"no Image View Controller to Show, SORRY :(");
        /*
        ImageViewController *photoController = (ImageViewController*)segue.destinationViewController;
        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo.jpg", [_menuItems objectAtIndex:indexPath.row]];
        photoController.photoFilename = photoFilename;
         */ // <- OLD DEMO CODE, STILL GOOD BUT NEED TO CREATE IMAGEVIEWCONTROLLER CLASS
    }

    
}

// SET ROUNDED CORNER CODE
- (void)setRoundedBorder:(float) radius borderWidth:(float)borderWidth color:(UIColor*)color view:(UIView*)view {
    CALayer * l = [view layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:radius];
    [l setBorderWidth:borderWidth];
    [l setBorderColor:[color CGColor]];
}

// - ALERT - ADDRESS BOOK DENIED ACCESS IN SETTINGS
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0){
        //cancel clicked ...do your action
        NSLog(@"cancel button index");
        // SET AN ACTION FOR THIS
        
    }else{
        //reset clicked
        NSLog(@"Other button index, NO ACTION FOR THIS YET");
    }
}

#pragma mark CONDITIONAL-CODE-PT2: setup // <- NOT SURE IF THE INIT HURTS OTHER FUNCTIONS
- (void)_firstMethod {
    [_myCondition lock];
    
    [Vars_AND_Constants setParseCurrentFriendsDictX]; // <- function here
    
    _someCheckIsTrue = YES;
    [_myCondition signal];
    [_myCondition unlock];
}
- (void)_secondMethod {
    [_myCondition lock];
    while (!_someCheckIsTrue) {
        [_myCondition wait];
    }
    
    // <- start AB POPUP CODE
    // step.1 - CREATE FADE LAYER
    UILabel *labelForFadeX           = [[UILabel alloc] initWithFrame:self.view.frame];
    [labelForFadeX setTag:CONfadeTag];
    labelForFadeX.backgroundColor    = [UIColor whiteColor];
    labelForFadeX.alpha              = CONfadeAlpha;
    labelForFadeX.userInteractionEnabled = YES;
    [self.parentViewController.view addSubview:labelForFadeX];
    // step.2 - CREATE BACKGROUND VC (for popup view) & NAVIGATION CONTROLLER
    MyTableViewController    *PUTviewController          = [[MyTableViewController alloc]init];
    UINavigationController   *PUTNavigationController    = [[UINavigationController alloc] initWithRootViewController:PUTviewController];
    PUTNavigationController.view.frame = CGRectMake((varDeviceWidth/2) - (CONtablePopUpWidth/2),
                                                    (varDeviceHeight/2) - (CONtablePopUpHeight/2),
                                                    CONtablePopUpWidth,
                                                    CONtablePopUpHeight);
    [self setRoundedBorder:CONpopupEdgeCurvature borderWidth:CONpopupBorderRadius color:[UIColor blackColor] view:PUTNavigationController.view];
    // step.3 - MOVE/ASSIGN ALL CONTROLLERS
    [PUTNavigationController            willMoveToParentViewController:self];
    [self.parentViewController.view     addSubview:PUTNavigationController.view];
    [self.parentViewController          addChildViewController:PUTNavigationController];
    [PUTNavigationController            didMoveToParentViewController:self];
    
    // step.4 - TRANSITION BLOCK
    [UIView animateWithDuration:CONfadeDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^ {
        PUTviewController.view.alpha = 1;
    } completion:nil];
    // <- end AB POPUP CODE
    
    [_myCondition unlock];

}

@end
