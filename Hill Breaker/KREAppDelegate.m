//
//  KREAppDelegate.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/11/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import "KREAppDelegate.h"
#import "KREBruteForceViewController.h"
#import "KREKnownKeyViewController.h"


@implementation KREAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.bruteForceViewController = [[KREBruteForceViewController alloc] initWithNibName:@"KREBruteForceView" bundle:nil];
    self.knownKeyViewController = [[KREKnownKeyViewController alloc] initWithNibName:@"KREKnownKeyViewController" bundle:nil];
    
    // put the views into the tabview
    NSTabViewItem *item;
    item = [self.tabView tabViewItemAtIndex:0];
    [item setView:[[self bruteForceViewController] view]];
    
    item = [self.tabView tabViewItemAtIndex:1];
    [item setView:[[self knownKeyViewController] view]];

}







@end
