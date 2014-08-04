//
//  ofxGimbal.h
//  gimbal_tester
//
//  Created by Blair Neal on 8/4/14.
//
//

#pragma once
#import <FYX/FYX.h>
#import <FYX/FYXLogging.h>

class ofxGimbal;

@interface ofxGimbalDelegate : NSObject <FYXServiceDelegate>
{
    ofxGimbal* gbCpp;
    NSString *currentID;
    
}

- (id) init:(ofxGimbal *)gimbalCpp;

@end

class ofxGimbal
{
    
public:
    
    ofxGimbal();
        
    ofxGimbalDelegate* gimbalDelegate;
    void startSession();
    void getCurrentGimbals();
    
};
