//
//  GPSLib.m
//  GPSLib
//
//  Created by Stefan Muscalu on 6/26/13.
//  Copyright (c) 2013 Tres Factory. All rights reserved.
//

#import "GPSLib.h"

@implementation GPSLib



-(id) init{
    self = [super init];
    
    _locationManager =[[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    _locationManager.delegate = self;
    _lastGoodGPSAngle = -1;
    data = 0;
    _updateCompass = NO;
    return self;
}

-(void)  startUpdateWithInterval:(int)i{
    if(updateTimer){
        [updateTimer invalidate];
        updateTimer = nil;
    }
    
    updateTimer = [NSTimer scheduledTimerWithTimeInterval:i
                                                   target:self
                                                 selector:@selector(timerStartUpdate:)
                                                 userInfo:nil
                                                  repeats:YES];
    _lastGoodGPSAngle = -1;
    [updateTimer fire];
    
}

-(void) timerStartUpdate:(NSTimer*)t{
    if(_updateCompass)
        [_locationManager startUpdatingHeading];
    
    [_locationManager startUpdatingLocation];
    data =0;
}

-(void) stopUpdate{
    if(updateTimer){
        [updateTimer invalidate];
        updateTimer = nil;
    }
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    _Location = newLocation;
    [_locationManager stopUpdatingLocation];
 
    if(_Location.speed>1 && _Location.course != -1){
        _lastGoodGPSAngle = _Location.course;
    }
    
    if(_delegate)
        if([_delegate respondsToSelector:@selector(GPSUpdated:)])
            [_delegate GPSUpdated:newLocation];
    
      
}
- (void)locationManager:(CLLocationManager*)manager didUpdateHeading:(CLHeading*)newHeading{
    [_locationManager stopUpdatingHeading];
    _Heading = newHeading;
    
    if(_delegate)
        if([_delegate respondsToSelector:@selector(CompassUpdated:)])
            [_delegate CompassUpdated:newHeading];
    
    }

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
   
    if(_delegate)
        if([_delegate respondsToSelector:@selector(GPSError:)])
            [_delegate GPSError:error];
    
    _lastError = error;
}

@end
