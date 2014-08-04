//
//  ofxGimbal.m
//  gimbal_tester
//
//  Created by Blair Neal on 8/4/14.
//
//

#import "ofxGimbal.h"

ofxGimbal::ofxGimbal(){
    gimbalDelegate = [[ofxGimbalDelegate alloc] init: this];
}

void ofxGimbal::startSession(){
    
}

@implementation ofxGimbalDelegate
- (id) init :(ofxGimbal *)gimbalCpp {
	if(self = [super init])	{
		NSLog(@"ofxGimbalDelegate initiated");
        
        //ref to OF instance
        gimbalCpp = gbCpp;
        
        [FYX setAppId:@"NOPE"
            appSecret:@"NOPE"
          callbackUrl:@"testproximityapp://authcode"];

        [FYX startService:self];
        [FYXLogging setLogLevel:FYX_LOG_LEVEL_INFO];
    }
    return self;
}
@end