//
//  GPSLib.h
//  GPSLib
//
//  Created by Stefan Muscalu on 6/26/13.
//  Copyright (c) 2013 Tres Factory. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@protocol GPSUpdate <NSObject>
@optional
- (void)GPSUpdated:(CLLocation *)location;
- (void)CompassUpdated:(CLHeading*)heading;

- (void)GPSError:(NSError*)error;
@end


@interface GPSLib : NSObject <CLLocationManagerDelegate>{
    NSTimer * updateTimer;
    int data;//va tine seama daca amandoua informatiile au fost preluate
}
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (retain) CLLocation * Location;
@property (retain) CLHeading * Heading;
@property (retain) NSError * lastError;
@property float              lastGoodGPSAngle;
@property BOOL               updateCompass;
-(void) startUpdateWithInterval:(int)i;
-(void) stopUpdate;

@property (nonatomic, unsafe_unretained) id <GPSUpdate> delegate;
@end


