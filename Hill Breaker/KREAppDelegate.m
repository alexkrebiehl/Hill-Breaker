//
//  KREAppDelegate.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/11/13.
//  Copyright (c) 2013 Alex Krebiehl
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation; either version 2 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License along
//  with this program; if not, write to the Free Software Foundation, Inc.,
//  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
//

#import "KREAppDelegate.h"
#import "KREBruteForceViewController.h"
#import "KREKnownKeyViewController.h"
#import "KREAboutViewController.h"


@implementation KREAppDelegate


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.bruteForceViewController = [[KREBruteForceViewController alloc] initWithNibName:@"KREBruteForceView" bundle:nil];
    self.knownKeyViewController = [[KREKnownKeyViewController alloc] initWithNibName:@"KREKnownKeyViewController" bundle:nil];
    self.aboutViewController = [[KREAboutViewController alloc] initWithNibName:@"KREAboutViewController" bundle:nil];
    
    // put the views into the tabview
    NSTabViewItem *item;
    item = [self.tabView tabViewItemAtIndex:0];
    [item setView:[[self bruteForceViewController] view]];
    
    item = [self.tabView tabViewItemAtIndex:1];
    [item setView:[[self knownKeyViewController] view]];
    
    item = [self.tabView tabViewItemAtIndex:2];
    [item setView:[[self aboutViewController] view]];

}







@end
