//
//  ContactObject.h
//  ContactAccessProject2
//
//  Created by josh on 9/29/14.
//  Copyright (c) 2014 GageIT. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ContactObject : NSObject

@property (strong, retain)  NSString *firstName;
@property (strong, retain)  NSString *lastName;
@property (strong, retain)  NSString *fullName;
@property (strong, retain)  NSString *numberType;
@property (strong, retain)  NSString *number;
@property                   UIImage  *contactpic;

@property                   NSString *isAVBObject;
@property (strong, retain)  NSString *activeStatus;
//
@end
