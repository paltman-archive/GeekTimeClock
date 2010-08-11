//
//  GeekTimeClockAppDelegate.m
//  GeekTimeClock
//
//  Created by Patrick Altman on 8/6/10.
//  Copyright 2010. All rights reserved.
//

#import "GeekTimeClockAppDelegate.h"


@implementation GeekTimeClockAppDelegate

@synthesize window;


-(void)awakeFromNib {
	UTC = [NSTimeZone timeZoneWithName:@"UTC"];
	showLSB = NO;
	
 	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:statusMenu];
	[statusItem setTitle:@"Geek Time"];
	[statusItem setHighlightMode:YES];
	
	[NSTimer scheduledTimerWithTimeInterval:0.65 
									 target:self 
								   selector:@selector(timerFireMethod:) 
								   userInfo:nil 
									repeats:YES];
}

- (void)timerFireMethod:(NSTimer *)aTimer {
	NSDate *date = [NSDate date];
	
	calendar = [NSCalendar currentCalendar];
	[calendar setTimeZone:UTC];
	NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	
	double all = [[NSDate date] timeIntervalSince1970];
	double ms = 1000 * (all - (int)all);
	int seconds = 1000 * [timeComponents second];
	int minute_seconds = 60000 * [timeComponents minute];
	int hour_seconds = 3600000 * [timeComponents hour];
	
	float gt = 65536 * ((hour_seconds + minute_seconds + seconds + ms) / (86400000.0));
	
	NSString *theTime = [NSString stringWithFormat:@"0x%04X", (int)round(gt)];
	
	if (!showLSB) {
		theTime = [theTime substringToIndex:4];
	}
	
	[statusItem setTitle:theTime];
}


- (IBAction)toggleShowLSB:(id)sender {
	if (showLSB == YES) {
		showLSB = NO;
	} else {
		showLSB = YES;
	}
}

- (IBAction)openGeekTimeDotOrg:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.geektime.org/"]];
}

- (IBAction)quit:(id)sender {
	exit(0);
}

@end
