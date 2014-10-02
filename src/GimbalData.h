#pragma once

#include "ofMain.h"

class gimbalData{
    
public:
    
    //SETTERS
    void setName(string _name);
    void setRSSI(int _RSSI);
    void setArrivalTime(float _arrivalTime);
    void setLastUpdated(float _lastUpdated);
    void setHasDeparted(bool hasDeparted, float departTime);
    void reset();

    
    //GETTERS
    string getName();
    int getRSSI();
    float getArrivalTime();
    float getLastUpdated();
    bool getHasDeparted();
    float getDepartureTime();
    
    
private:
    
    string name; //first namelastname
    int RSSI = 0; //signal strength
    float arrivalTime = 0; //when the entry was created in system time, not app time
    float lastUpdated = 0; //time the record was last updated
    bool hasDeparted = 0;
    float departureTime = 0;
    
};