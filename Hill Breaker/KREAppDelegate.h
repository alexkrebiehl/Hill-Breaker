//
//  KREAppDelegate.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/11/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class KREBruteForceViewController, KREKnownKeyViewController;

@interface KREAppDelegate : NSObject

@property (weak) IBOutlet NSTabView *tabView;

@property (strong, nonatomic) KREBruteForceViewController *bruteForceViewController;
@property (strong, nonatomic) KREKnownKeyViewController *knownKeyViewController;


@end
