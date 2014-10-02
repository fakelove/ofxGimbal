//
//  GimbleController.m
//  GimbleTest
//
//  Created by Josh Safran on 8/10/14.
//  Copyright (c) 2014 JamSlap. All rights reserved.
//

#import "GimbalController.h"
#import <FYX/FYXTransmitter.h>

@interface GimbalController (){
    FYXVisitManager *visitManager;
    ofApp *openFrameworkApp;
};

@end

static GimbalController* instance;

@implementation GimbalController

+(id)sharedInstance{
    if(instance == nil){
        instance = [[GimbalController alloc] init];
    }
    
    return instance;
}

-(id) init{
    self = [super init];
    
    if( self != nil){
        [self setupFYX];
        [self setupVisitManager];
        
    }
    return self;
}

-(void) setupFYX{
    [FYX setAppId:GIMBAL_API_KEY appSecret:GIMBAL_API_SECRET callbackUrl:GIMBAL_CALLBACK_URL];
}

-(void) setupVisitManager{
    visitManager = [FYXVisitManager new];
    visitManager.delegate = self;
    
    
    NSMutableDictionary *options = [NSMutableDictionary new];
    [options setObject:[NSNumber numberWithInt:GIMBAL_DEPARTURE_INTERVAL] forKey:FYXVisitOptionDepartureIntervalInSecondsKey];
    
    [options setObject:[NSNumber numberWithInt:GIMBAL_SIGNAL_STRENGTH_WINDOW] forKey:FYXSightingOptionSignalStrengthWindowKey];
    
    [options setObject:[NSNumber numberWithInt:GIMBAL_ARRIVAL_RSSI] forKey:FYXVisitOptionArrivalRSSIKey];

    [options setObject:[NSNumber numberWithInt:GIMBAL_DEPARTURE_RSSI] forKey:FYXVisitOptionDepartureRSSIKey];
    [visitManager startWithOptions:options];

    
}

-(void)startProximityServices:(ofApp *)delegate{
    [FYX startService:self];
    openFrameworkApp = delegate;
}


#pragma mark - Visit Delegate

- (void)didArrive:(FYXVisit *)visit;
{
    
    // this will be invoked when an authorized transmitter is sighted for the first time
    NSLog(@"I arrived at a Gimbal Beacon!!! %@", visit.transmitter.name);
    
//    ofxGimbalDelegate::didArrive();
    //NSString *name = visit.transmitter.name;
    //std::string *bar = new std::string([name UTF8String]);
    
    
    openFrameworkApp->didArrive([visit.transmitter.name UTF8String]);
    
}
- (void)receivedSighting:(FYXVisit *)visit updateTime:(NSDate *)updateTime RSSI:(NSNumber *)RSSI;
{
    
    // this will be invoked when an authorized transmitter is sighted during an on-going visit
    //NSLog(@"I received a sighting!!! %@", visit.transmitter.name);
    //NSLog(@"RSSI %@", RSSI );
    
    //this was doing weird stuff...i think the other method I'm doing might be fine...
    //NSString *name = visit.transmitter.name;
    //std::string *bar = new std::string([name UTF8String]);
    
    
    openFrameworkApp->hadSighting([visit.transmitter.name UTF8String], [RSSI intValue]);
    
}
- (void)didDepart:(FYXVisit *)visit;
{
    // this will be invoked when an authorized transmitter has not been sighted for some time
    NSLog(@"I left the proximity of a Gimbal Beacon!!!! %@", visit.transmitter.name);
    NSLog(@"I was around the beacon for %f seconds", visit.dwellTime);
    
    //NSString *name = visit.transmitter.name;
    openFrameworkApp->didDepart([visit.transmitter.name UTF8String]);
}


#pragma mark - Service Delegate
-(void)serviceStarted{
    NSLog(@"Started Service");
}

-(void)startServiceFailed:(NSError *)error{
    NSLog(@"Start Service Fail");
}

#pragma mark - Helpers
-(string *) convertToCPPString:(NSString*)str{
    return new std::string([str UTF8String]);
}

@end
