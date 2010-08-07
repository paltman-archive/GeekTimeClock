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

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

}

-(void)awakeFromNib{
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
	[statusItem setMenu:statusMenu];
	[statusItem setTitle:@"Geek Time"];
	[statusItem setHighlightMode:YES];
	NSDate *d = [NSDate date];
	NSTimer *timer = [[NSTimer alloc] 
					 initWithFireDate:d
							 interval:0.65
							   target:self 
							 selector:@selector(timerFireMethod:)
							 userInfo:nil
							  repeats:YES];

	[[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
	[timer fire];
	[timer release];
}

- (void)timerFireMethod:(NSTimer *)aTimer {
	NSDate *date = [NSDate date];
	NSTimeZone *UTC = [NSTimeZone timeZoneWithName:@"UTC"];
	NSCalendar *calendar = [NSCalendar currentCalendar];
	[calendar setTimeZone:UTC];
	NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date];
	int second = [timeComponents second];
	int minute = [timeComponents minute];
	int hour = [timeComponents hour];
	int hour_seconds = (3600 * hour);
	int minute_seconds = (60 * minute);
	float partial_day = ((hour_seconds + minute_seconds + second) / (86400.0));
	float gt = 65536 * partial_day;
	int igt = (int)gt;
	[statusItem setTitle:[NSString stringWithFormat:@"0x%X", igt]];
}

- (IBAction)openGeekTimeDotOrg:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.geektime.org/"]];
}

- (IBAction)quit:(id)sender {
	exit(0);
}
@end
