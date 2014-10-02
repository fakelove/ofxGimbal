
/* NOTES:
   1. Go to Build Phases >> Link Binary with Libraries >> click on '+' to add Core Bluetooth, Core Data, Security.
   2. #include "GimbalController.h" in ofApp.cpp and use setupGimbalAdapter() method
   
   3. gimbalController.h includes RSSI thresholds
 
 */


#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "GimbalData.h"


class ofApp : public ofxiOSApp {
    
    public:
        void setup();
        void setupGimbalAdapter();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    
    vector<string> gimbalIDs;
    map<string, gimbalData> mainGimbalList;
    
    float maxDepartureTime;
    float maxUpdateThresh;

    int touchDragY;

#pragma mark - Gimbal Callbacks
    
    //Use some gimbal methods//
    
    void didArrive(string name);
    void hadSighting(string name, int RSSI);
    void didDepart(string name);
    
    
    string arrivalID;
    string sightingID;
    string departString;
    int RSSI;
    
    


};



