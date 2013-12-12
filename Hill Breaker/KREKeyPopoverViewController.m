//
//  KREKeyPopoverViewController.m
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

#import "KREKeyPopoverViewController.h"
#import "KREHillKey.h"

@interface KREKeyPopoverViewController ()

@end

@implementation KREKeyPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)setHillKey:(KREHillKey *)hillKey
{
    _hillKey = hillKey;
    self.keyTypeLabel.stringValue = @"Decrypting Key";
    [self displayKey:hillKey];
}

- (void)displayKey:(KREHillKey *)key
{
    self.labelA.stringValue = [@(key.matrix.a) stringValue];
    self.labelB.stringValue = [@(key.matrix.b) stringValue];
    self.labelC.stringValue = [@(key.matrix.c) stringValue];
    self.labelD.stringValue = [@(key.matrix.d) stringValue];
}

- (IBAction)inverseButtonPressed:(id)sender
{
    NSString *newLabel;
    if ([self.keyTypeLabel.stringValue isEqualToString:@"Decrypting Key"])
    {
        newLabel = @"Encrypting Key";
    }
    else
    {
        newLabel = @"Decrypting Key";
    }
    self.hillKey = [self.hillKey inverse];
    self.keyTypeLabel.stringValue = newLabel;
}

@end
