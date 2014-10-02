
#include "ofApp.h"

#include "GimbalController.h" //Make sure to include this here to use setupGimbalAdapter() method see below


//--------------------------------------------------------------
void ofApp::setup(){	
    setupGimbalAdapter();
    
    maxDepartureTime = 30; //30 seconds until something gets deleted from the list
    maxUpdateThresh = 5; //must have left 30 seconds ago, and been updated greater than 5 seconds ago - we need double checks that a person is still there with update because sometimes getdeparted gets flagged very early
    
}

//--------------------------------------------------------------
void ofApp::setupGimbalAdapter(){
    [[GimbalController sharedInstance]startProximityServices:this];
}

//--------------------------------------------------------------
void ofApp::update(){
    
    //on every update - test each id to see if it has been flagged as departed. if it has departed AND it has been gone for longer than X seconds - then it can be deleted from the list - also check if it has been updated recently
    
    
        for(auto iter = mainGimbalList.begin(); iter != mainGimbalList.end(); ){
    
                float whenDidTheyLeave = ofGetElapsedTimef()- iter->second.getDepartureTime();
                float whenDidLastUpdate = ofGetElapsedTimef()-iter->second.getLastUpdated();
    
                //this is where things get removed
    
                if(iter->second.getHasDeparted()==true && whenDidTheyLeave>maxDepartureTime && whenDidLastUpdate > maxUpdateThresh ){
    
    
                    cout<< "Removing: " << iter->second.getName()<<endl;
                    mainGimbalList.erase(iter++); //this erases and then increments
                    
                }else{
                    ++iter;
                }
            }


}

//--------------------------------------------------------------
void ofApp::draw(){
    
    ofBackground(0);
    ofSetColor(255);
    ofDrawBitmapString("Gimbal Collector - Found " + ofToString(mainGimbalList.size()) + " Gimbals", 20,20);
    ofPushMatrix();
    ofTranslate(0,20+ ofMap(touchDragY, 0, ofGetHeight(), 0,-1000, true)); //scroll list

    
    int index =0; //not sure how to get index in auto...
    for(auto& x: mainGimbalList){
        
        ofPushMatrix();
        ofTranslate(0, index*120);
        ofSetColor(255);
        ofDrawBitmapString("Sighting ID: " + x.second.getName(), 20,20);
        ofDrawBitmapString("Arrived: " + ofToString(ofGetElapsedTimef()-x.second.getArrivalTime(),2)+"s ago", 300,20);
        ofDrawBitmapString("RSSI: " + ofToString(x.second.getRSSI()), 20,40);
        ofDrawBitmapString("Last update: " + ofToString(ofGetElapsedTimef()-x.second.getLastUpdated(),2)+"s ago", 300,40);
        
        ofDrawBitmapString("Has Departed: " +ofToString(x.second.getHasDeparted()), 20,60);
        ofDrawBitmapString("Departure Time: " +ofToString(ofGetElapsedTimef()-x.second.getDepartureTime(),2), 160,60);
        
        ofDrawBitmapString("Time to deletion: " +ofToString(maxDepartureTime-(ofGetElapsedTimef()-x.second.getDepartureTime()),2), 350,60);
        
        
        //color coding signal bar
        if (x.second.getRSSI()>=-55) {
            ofSetColor(ofColor::green);
        }else if(x.second.getRSSI()>-74 && x.second.getRSSI()<-55){
            ofSetColor(ofColor::yellow);
        }else{
            ofSetColor(ofColor::red);
        }
        
        ofRect(0, 100, ofMap(x.second.getRSSI(), -90, -30, 0, ofGetWidth()), 15);
        
        ofSetColor(255);
        ofLine(0, 120, ofGetWidth(), 120);
        ofPopMatrix();
        index++;
        
    }
    ofPopMatrix();

}

//--------------------------------------------------------------
void ofApp::exit(){

}

//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

    touchDragY = touch.y;

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

//--------------------------------------------------------------

#pragma mark - Gimbal Callbacks
void ofApp::didArrive(string name){
    
    arrivalID = name;
    cout << "OF Arrival name: " << name << endl;

}

void ofApp::hadSighting(string name, int _RSSI){
    
    sightingID = name;
    RSSI = _RSSI;
    
    auto nameIndex = mainGimbalList.find(name);
    
    if(nameIndex != mainGimbalList.end()) { //if it exists - if it's index is not the end of the map - update the RSSI
        mainGimbalList[name].setRSSI(_RSSI);
        mainGimbalList[name].setLastUpdated(ofGetElapsedTimef());
        
    }else{ //if it doesn't exist - add both
        //gimbalIDRSSI.insert(std::pair<string,int>(name,_RSSI));
        
        mainGimbalList[name].setRSSI(_RSSI);
        mainGimbalList[name].setName(name);
        mainGimbalList[name].setLastUpdated(ofGetElapsedTimef());
        mainGimbalList[name].setArrivalTime(ofGetElapsedTimef());
        mainGimbalList[name].setHasDeparted(false, 0);
        
    }
    
}

void ofApp::didDepart(string name){

    
    auto nameIndex = mainGimbalList.find(name);
    
    if(nameIndex != mainGimbalList.end()) { //if it exists - flag it
       // mainGimbalList.erase(nameIndex);
        
        //Don't erase here! Just flag the ID
        mainGimbalList[name].setHasDeparted(true, ofGetElapsedTimef());
        
        
    }else{ //if it doesn't exist - do nothing
        return;
    }

}

