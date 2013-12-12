//
//  KREBruteForceViewController.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/12/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KREBruteForceViewController : NSViewController <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTokenFieldCellDelegate, NSTokenFieldDelegate, NSTextViewDelegate>

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTokenField *tokenField;
@property (weak) IBOutlet NSTextField *inputTextView;
@property (strong) IBOutlet NSPopover *popover;
@property (weak) IBOutlet NSTextField *resultsLabel;
@property (weak) IBOutlet NSProgressIndicator *resultsProgressIndicator;
@property (weak) IBOutlet NSProgressIndicator *filterProgressIndicator;

- (IBAction)tokenFieldAction:(id)sender;
- (IBAction)textViewAction:(id)sender;

@end
