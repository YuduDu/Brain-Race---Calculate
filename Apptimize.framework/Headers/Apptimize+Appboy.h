//
//  Apptimize+Appboy.h
//  Apptimize
//
//  Created by Jeff DiTullio on 11/11/16.
//  Copyright © 2016 Apptimize, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Apptimize (Appboy)

/**
 Do not call this method! This method is specifically for the
 Appboy SDK integration with the Apptimize SDK and should only
 be called by the Appboy SDK.
 */
+ (void)apptimizeTrackAppboyEvent:(NSString *)eventName;

@end
