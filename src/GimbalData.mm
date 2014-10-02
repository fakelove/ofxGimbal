

#include "GimbalData.h"
//SETTERS
void gimbalData::setName(string _name){
    name = _name;
}
void gimbalData::setRSSI(int _RSSI){
    RSSI = _RSSI;
}

void gimbalData::setArrivalTime(float _arrivalTime){
    arrivalTime = _arrivalTime;
}
void gimbalData::setLastUpdated(float _lastUpdated){
    lastUpdated = _lastUpdated;
}

void gimbalData::setHasDeparted(bool _hasDeparted, float _departureTime){
    hasDeparted = _hasDeparted;
    departureTime = _departureTime;
}

void gimbalData::reset(){
    name = "";
    RSSI = 0;
    arrivalTime = 0;
    lastUpdated = 0;
    hasDeparted = false;
    departureTime = 0;
    
}


//GETTERS
string gimbalData::getName(){
    return name;
}
int gimbalData::getRSSI(){
    return RSSI;
}

float gimbalData::getArrivalTime(){
    return arrivalTime;
}

float gimbalData::getLastUpdated(){
    return lastUpdated;
}

bool gimbalData::getHasDeparted(){
    return hasDeparted;
}

float gimbalData::getDepartureTime(){
    return departureTime;
}

