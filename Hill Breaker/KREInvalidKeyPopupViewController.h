//
//  KREInvalidKeyPopupViewController.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/14/13.
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
