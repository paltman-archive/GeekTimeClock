//
//  GeekTimeClockAppDelegate.h
//  GeekTimeClock
//
//  Created by Patrick Altman on 8/6/10.
//  Copyright 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface GeekTimeClockAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    IBOutlet NSMenu *statusMenu;
	IBOutlet NSStatusItem *LSBToggleItem;
    NSStatusItem *statusItem;
	BOOL showLSB;
}


- (void)timerFireMethod:(NSTimer *)aTimer;

@property (assign) IBOutlet NSWindow *window;

- (IBAction)openGeekTimeDotOrg:(id)sender;
- (IBAction)toggleShowLSB:(id)sender;
- (IBAction)quit:(id)sender;

@end
