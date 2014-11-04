//
//  Vars AND Constants.m
//  Altogether
//
//  Created by josh on 10/28/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

#import "Vars AND Constants.h"
#import "ViewController.h"

// device stuff
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation Vars_AND_Constants

// TEST
                    float varCheck                              = 300;
            const   float CONCheck                              = 150;

// DEVICE STUFF (UNUSED)
            + (NSString *) platform{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}
            + (NSString *) platformString{
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini Retina (CDMA)";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3 (CDMA)";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3 (CDMA)";
    
    if ([platform isEqualToString:@"i386"])         return [UIDevice currentDevice].model;
    if ([platform isEqualToString:@"x86_64"])       return [UIDevice currentDevice].model;
    
    return platform;
}
        // STATUS BAR
            const float CONstatusBarHeight                      = 20.0;


// ALL
        // - dims -
            float varDeviceWidth                                = 0;
            float varDeviceHeight                               = 0;

// PARSE
            const NSString    *CONparseFriend                   = @"FRIEND";
            const NSString    *CONparseNotFriend                = @"NOTFRIEND";
            const NSString    *CONABchanged                     = @"changed";
            const NSString    *CONABunchanged                   = @"unchanged";
            NSMutableDictionary *parseCurrentFriendsX           = nil;
            NSMutableDictionary *parseCurrentFriendsOTGStatus   = nil;
        // GET CURRENT FRIENDS' OBJECTID's FROM PARSEDB
            + (void) setParseCurrentFriendsDictX {
                parseCurrentFriendsX = [[NSMutableDictionary alloc] init];
                PFQuery *currentFriends         =   [PFQuery queryWithClassName:@"Contacts"];
                [currentFriends whereKey:@"UserID" equalTo:[[PFUser currentUser] objectId]];
                [currentFriends findObjectsInBackgroundWithBlock:^(NSArray *currentFriend, NSError *errer) {
                    for (PFObject *friend in currentFriend) {
                        NSString *phone     = friend[@"phone"];
                        NSString *objectId  = friend.objectId;
                        [parseCurrentFriendsX           setObject:objectId          forKey:phone];
                    }
                }];
            }
        // GET CURRENT FRIENDS' OUTGOING STATUS FROM PARSEDB
            + (void) getParseFriendsOTGStatus {
                parseCurrentFriendsOTGStatus = [[NSMutableDictionary alloc] init];
                PFQuery *friendsOTGStatus           =   [PFQuery queryWithClassName:@"Contacts"];
                [friendsOTGStatus whereKey:@"UserID" equalTo:[[PFUser currentUser] objectId]];
                [friendsOTGStatus findObjectsInBackgroundWithBlock:^(NSArray *currentFriends, NSError *errer) {
                    for (PFObject *friendOTG in currentFriends) {
                        NSString *phone             = friendOTG[@"phone"];
                        NSString *outgoingStatus    = friendOTG[@"OutgoingStatus"];
                        [parseCurrentFriendsOTGStatus   setObject:outgoingStatus    forKey:phone];
                    }
                }];
            }


#pragma mark - Initial View Constants
// MAIN VC
    // TAG
            NSInteger const CONMVCTag                           = 7777;
    // TABS
        // - dims -
            const float     CONtabHeight                        = 40.0;
            const float     CONtabBorderWidth                   = 0.5;
    // DAY LAYOUT
        // sections
            const float     CONnumberDaySections                = 4;    // <- "0" IS INCLUDED (SO IT'S 1 MORE THAN THAT)
            const float     CONdaySectionStartH                 = 100;   // <- "Y" START FOR AN ENTIRE SECTION
            const float     CONdaySectionHeight                 = 90;   // <- "Y" SPACE FOR AN ENTIRE SECTION
        // day-text
            // - dims -
            const float     CONdayTextSectionStartX             = 0;
            const float     CONdayTextSectionH                  = 30;
            const float     CONdayTextSectionW                  = 200;
            // - text -
            const NSString  *CONdayMessageFont                  = @"Helvetica-Light";
        // day-quad
            // - dims -
            const float     CONbuttonDimW                       = 50;
            const float     CONbuttonDimH                       = 50;
            // - position -
            const float     CONmornStartX                       = 10;
            const float     CONmornStartY                       = 10;
            const float     CONbuttonSeparatorX                 = 0.5;
            const float     CONbuttonSeparatorY                 = 60;
        // contact-counter
            // - tag -
            const int       CONOTGfriendCounterTag              = 8888;
            // - position -
            const float     CONcontactsPositionStartY           = 70;
            const float     CONcontactsPositionStartX           = 230;
            // - dims -
            const float     CONcontactsDimH                     = 60;
            const float     CONcontactsDimW                     = 60;




// BASEMENT
            // - basement button -
            const float     CONbasementButtonWidth      = 30;
            const float     CONbasementButtonHeight     = 30;
            const float     CONbasementButtonOffsetX    = 8; // <- in the ViewDidAppear of the SWRevealViewController
            const float     CONbasementButtonOffsetY    = 2;
            // - basement cells -
            const float     CONbasementCellHeight       = 50;
            const float     CONbasementCellImageHW      = 40;
            // - basement cleavage -
            const float     CONbasementClosedWidth      = 30;
            const float     CONbasementOpenedWidth      = 260;
            const NSString  *CONnavyTit                 = @"NAVY";
            // - opened/closed status -
            NSString        *varBSC                     = @"YES"; // <- NOT A CONSTANT


// CONTACTS
            // - friend y/n -
            NSString *const CRSyes                      = @"YES";
            NSString *const CRSno                       = @"NO";
            // - activated y/n -
            NSString *const CATS                        = @"AVB";
            // - counters -
            const float     CONcontactCounterDimH       = 80;
            const float     CONcontactCounterDimW       = 80;
            const float     CONcontactCounterFontSize   = 40.0f;
            const NSString  *CONcontactCounterFont      = @"Helvetica-Bold";
            NSInteger       varOutgoingCount            = 0; // <- NOT A CONSTANT, may want to replace this with a method to count the current array?

// POPUP
            // - dims -
            NSInteger const CONpopUpHeight              = 300;
            NSInteger const CONpopUpWidth               = 200;
            float     const CONpopupBorderRadius        = 1;
            float     const CONpopupEdgeCurvature       = 20;
            // - field dims -
            NSInteger const CONpopUpFieldHeight         = 100;
            NSInteger const CONpopUpFieldWidth          = 130;
            NSInteger const CONpopUpFieldEdgeCurve      = 10;
            NSInteger const CONpopUpFieldEdgeThick      = 3;
            // - fade -
            NSInteger const CONfadeTag                  = 999999;
            float     const CONfadeDuration             = 0.25;
            float     const CONfadeAlpha                = 0.40;


// ADDRESSBOOK TABLETABLEVIEW POPUP
            // - tableview dims -
            NSInteger const CONtablePopUpHeight          = 460;
            NSInteger const CONtablePopUpWidth           = 280;
            NSInteger const CONtablePopUpStartX          = 20;
            NSInteger const CONtablePopUpStartY          = 20;
            // - navbar dims -
            NSInteger const CONtablePopUpNavbarHeight    = 80;
            NSInteger const CONtablePopUpNavbarIconH     = 60;
            NSInteger const CONtablePopUpNavbarIconW     = 60;
            NSInteger const CONtablePopUpFriendCounTag   = 909090;
            // - toolbar dims -
            NSInteger const CONtablePopUpToolbarHeight   = 0; // <- unused so far
            // - tableview buttons -
            NSInteger const CONtablePopUpButtonHeight    = 30;
            NSInteger const CONtablePopUpButtonWidth     = 90;
            NSInteger const CONtablePopUpButtonStartX    = 10;
            NSInteger const CONtablePopUpButtonStartY    = 10;


@end
