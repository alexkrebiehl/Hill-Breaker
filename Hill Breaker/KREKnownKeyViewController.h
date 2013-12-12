//
//  KREKnownKeyViewController.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/13/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
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
