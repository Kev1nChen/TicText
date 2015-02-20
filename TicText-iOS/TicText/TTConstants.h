//
//  TTConstants.h
//  TicText
//
//  Created by Kevin Yufei Chen on 2/5/15.
//  Copyright (c) 2015 Kevin Yufei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - UIColors
extern float const kTTUIPurpleColorRed;
extern float const kTTUIPurpleColorGreen;
extern float const kTTUIPurpleColorBlue;
extern float const kTTUIPurpleColorAlpha;

#define kTTUIPurpleColor [UIColor colorWithRed:kTTUIPurpleColorRed/255.0 \
                                         green:kTTUIPurpleColorGreen/255.0 \
                                          blue:kTTUIPurpleColorBlue/255.0 \
                                         alpha:kTTUIPurpleColorAlpha/255.0]

#pragma mark - NSUserDefaults


#pragma mark - NSNotification
extern NSString * const kTTAppDelegateApplicationDidReceiveRemoteNotification;

#pragma mark - PFUser Class
// Field keys
extern NSString * const kTTUserDisplayNameKey;
extern NSString * const kTTUserFacebookIDKey;
extern NSString * const kTTUserProfilePictureKey;
extern NSString * const kTTUserProfilePictureSmallKey;
extern NSString * const kTTUserTicTextFriendsKey;
extern NSString * const kTTUserHasTicTextProfileKey;


#pragma mark - PFObject Tic Class
// Class key
extern NSString * const kTTTicClassKey;

// Field keys
extern NSString * const kTTTicSenderKey;
extern NSString * const kTTTicTypeKey;
extern NSString * const kTTTicRecipientKey;
extern NSString * const kTTTicTimeLimitKey;
extern NSString * const kTTTicSendTimestampKey;
extern NSString * const kTTTicReceiveTimestampKey;
extern NSString * const kTTTicStatusKey;
extern NSString * const kTTTicContentTypeKey;
extern NSString * const kTTTicContentKey;

// Type values
extern NSString * const kTTTicTypeDefault;
extern NSString * const kTTTIcTypeAnonymous;

// Status values
extern NSString * const kTTTicStatusRead;
extern NSString * const kTTTicStatusUnread;
extern NSString * const kTTTIcStatusExpired;

// Content Type values
extern NSString * const kTTTicContentTypeText;
extern NSString * const kTTTicContentTypeImage;
extern NSString * const kTTTicContentTypeVoice;


#pragma mark - PFObject Activity Class
// Class key
extern NSString * const kTTActivityClassKey;

// Field keys
extern NSString * const kTTActivityTypeKey;
extern NSString * const kTTActivityFromUserKey;
extern NSString * const kTTActivityToUserKey;
extern NSString * const kTTActivityContentKey;
extern NSString * const kTTActivityTicKey;

// Type values
extern NSString * const kTTActivityTypeSend;
extern NSString * const kTTActivityTypeFetch;


#pragma mark - Push Notification Payload
// Field keys
extern NSString * const kTTPushNotificationPayloadTypeKey;

// Type values
extern NSString * const kTTPushNotificationPayloadTypeNewTic;
extern NSString * const kTTPushNotificationPayloadTypeNewFriend;


#pragma mark - Installation Class
// Field keys
extern NSString * const kTTInstallationUserKey;
