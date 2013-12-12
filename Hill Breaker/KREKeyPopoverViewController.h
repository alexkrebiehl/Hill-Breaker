//
//  KREKeyPopoverViewController.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/13/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KREHillKey;

@interface KREKeyPopoverViewController : NSViewController

@property (weak, nonatomic) KREHillKey *hillKey;

@property (weak) IBOutlet NSTextField *labelA;
@property (weak) IBOutlet NSTextField *labelB;
@property (weak) IBOutlet NSTextField *labelC;
@property (weak) IBOutlet NSTextField *labelD;
@property (weak) IBOutlet NSTextField *keyTypeLabel;


- (IBAction)inverseButtonPressed:(id)sender;

@end
