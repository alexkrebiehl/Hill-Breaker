//
//  KREKeyPopoverViewController.h
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
