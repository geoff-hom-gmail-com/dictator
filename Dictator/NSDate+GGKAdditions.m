//
//  NSDate+GGKAdditions.m
//  Mercy Camera
//
//  Created by Geoff Hom on 5/12/13.
//  Copyright (c) 2013 Geoff Hom. All rights reserved.
//
#import "NSDate+GGKAdditions.h"

@implementation NSDate (GGKAdditions)
+ (NSString *)ggk_minuteSecondStringForTimeInterval:(NSTimeInterval)theTimeInterval {
    // Round to the nearest second.
    NSInteger theRemainderInSecondsInteger = round(theTimeInterval);
    NSInteger theNumberOfSecondsInAMinute = 60;
    // Get minutes, then seconds.
    NSInteger theNumberOfMinutes = theRemainderInSecondsInteger / theNumberOfSecondsInAMinute;
    theRemainderInSecondsInteger = theRemainderInSecondsInteger % theNumberOfSecondsInAMinute;
    NSInteger theNumberOfSeconds = theRemainderInSecondsInteger;
    NSString *aString = [NSString stringWithFormat:@"%2d:%02d", theNumberOfMinutes, theNumberOfSeconds];
    return aString;
}
@end
