//
//  KREInvalidKeyPopupViewController.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/14/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class KREHillKey, KREInvalidKeyPopupViewController;

@protocol KREInvalidKeyPopupViewControllerDelegate <NSObject>

- (void)userDidChooseKeyFromPopover:(KREHillKey *)hillKey;

@end

@interface KREInvalidKeyPopupViewController : NSViewController

@property (strong, nonatomic) KREHillKey *hillKey;
@property (weak, nonatomic) id<KREInvalidKeyPopupViewControllerDelegate> delegate;

@property (weak) IBOutlet NSTextField *matrixLabelA;
@property (weak) IBOutlet NSTextField *matrixLabelB;
@property (weak) IBOutlet NSTextField *matrixLabelC;
@property (weak) IBOutlet NSTextField *matrixLabelD;


- (IBAction)useKeyButtonPressed:(id)sender;

@end
