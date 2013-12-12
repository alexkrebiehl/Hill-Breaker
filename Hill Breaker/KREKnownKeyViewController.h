//
//  KREKnownKeyViewController.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/13/13.
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

@protocol KREInvalidKeyPopupViewControllerDelegate;

@interface KREKnownKeyViewController : NSViewController <NSTextFieldDelegate, KREInvalidKeyPopupViewControllerDelegate>

@property (weak) IBOutlet NSTextField *inputField;
@property (weak) IBOutlet NSTextField *outputField;
@property (weak) IBOutlet NSTextField *matrixFieldA;
@property (weak) IBOutlet NSTextField *matrixFieldB;
@property (weak) IBOutlet NSTextField *matrixFieldC;
@property (weak) IBOutlet NSTextField *matrixFieldD;
@property (strong) IBOutlet NSPopover *invalidKeyPopover;
@property (weak) IBOutlet NSView *keyMatrixView;

- (IBAction)encryptButtonPressed:(id)sender;
- (IBAction)randomKeyButtonPressed:(id)sender;

- (IBAction)inputTextFieldAction:(id)sender;
@end
