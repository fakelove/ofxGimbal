//
//  GimbleController.h
//  GimbleTest
//
//  Created by Josh Safran on 8/10/14.
//  Copyright (c) 2014 JamSlap. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <FYX/FYX.h>
#import <FYX/FYXVisitManager.h>
#import <FYX/FYXSightingManager.h>

#import "ofApp.h"


#pragma mark - Gimbal Configuration

#define GIMBAL_API_KEY @"adb61071f8f73db758bcf3dea68480f9a34d5dd2a5d6c9fbd00a8b178fc57bfa"

#define GIMBAL_API_SECRET @"8459f0a5873e63cbce5aa45d9e609253c7629756da94c255c16b2b740d36fd89"

#define GIMBAL_CALLBACK_URL @"testproximityapp://authcode"


#define GIMBAL_SIGNAL_STRENGTH_WINDOW FYXSightingOptionSignalStrengthWindowLarge
#define GIMBAL_DEPARTURE_INTERVAL 3 //how many seconds has it not been found?
#define GIMBAL_ARRIVAL_RSSI -82 //trigger arrival when greater than this value
#define GIMBAL_DEPARTURE_RSSI -100 //RSSI departure val

//Find info on visitation configuration @- http://gimbal.com/doc/proximity/ios.html#start_with_options




@interface GimbalController : NSObject <FYXServiceDelegate,FYXVisitDelegate,FYXSightingDelegate>

+(id)sharedInstance;
-(void)startProximityServices:(ofApp*)delegate;


@end
