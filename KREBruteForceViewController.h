//
//  KREBruteForceViewController.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/12/13.
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
