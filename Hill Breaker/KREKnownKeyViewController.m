//
//  KREKnownKeyViewController.m
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

#import "KREKnownKeyViewController.h"
#import "KREHillKey.h"
#import "KREHillSolver.h"
#import "KREHillSolverResult.h"
#import "KREInvalidKeyPopupViewController.h"

@interface KREKnownKeyViewController ()

@end

@implementation KREKnownKeyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (IBAction)encryptButtonPressed:(id)sender
{
    [self runCypher];
}

- (IBAction)randomKeyButtonPressed:(id)sender
{
    KREHillKey *randomKey = nil;
    do
    {
        KREMatrix randomMatrix = KREMatrixMake(arc4random() % 26 + 1,
                                               arc4random() % 26 + 1,
                                               arc4random() % 26 + 1,
                                               arc4random() % 26 + 1);
        randomKey = [KREHillKey generateKeyLikeMatrix:randomMatrix];
    } while (randomKey == nil);
    
    
    [self userDidChooseKeyFromPopover:randomKey];
}

- (IBAction)inputTextFieldAction:(id)sender
{
    [self runCypher];
}

- (void)runCypher
{
    KREMatrix matrix = KREMatrixMake(NSIntegerFromString(self.matrixFieldA.stringValue),
                                     NSIntegerFromString(self.matrixFieldB.stringValue),
                                     NSIntegerFromString(self.matrixFieldC.stringValue),
                                     NSIntegerFromString(self.matrixFieldD.stringValue));
    KREHillKey *key = [[KREHillKey alloc] initWithMatrix:matrix];
    if (key != nil)
    {
        KREHillSolver *solver = [[KREHillSolver alloc] initWithString:self.inputField.stringValue];
        KREHillSolverResult *result = [solver runWithKey:key];
        self.outputField.stringValue = [KREHillSolverResult seperateStringIntoBlocks:result.decypheredText];
    }
    else
    {
        if (![self.invalidKeyPopover isShown])
        {
            KREHillKey *aNewKey = [KREHillKey generateKeyLikeMatrix:matrix];
            if (aNewKey != nil)
            {
                [self.invalidKeyPopover showRelativeToRect:[self.keyMatrixView bounds]
                                                    ofView:self.keyMatrixView
                                             preferredEdge:NSMaxXEdge];
                KREInvalidKeyPopupViewController *controller = (KREInvalidKeyPopupViewController *)self.invalidKeyPopover.contentViewController;
                
                controller.delegate = self;
                [controller setHillKey:aNewKey];
            }
            
        }
        else
        {
            [self.invalidKeyPopover close];
        }
    }
}

- (void)userDidChooseKeyFromPopover:(KREHillKey *)hillKey
{
    if (hillKey != nil)
    {
        KREMatrix matrix = hillKey.matrix;
        
        self.matrixFieldA.stringValue = [@(matrix.a) stringValue];
        self.matrixFieldB.stringValue = [@(matrix.b) stringValue];
        self.matrixFieldC.stringValue = [@(matrix.c) stringValue];
        self.matrixFieldD.stringValue = [@(matrix.d) stringValue];
        
        [self.invalidKeyPopover close];
        [self runCypher];
    }
    
    
}

NSInteger NSIntegerFromString(NSString *string)
{
    return [string integerValue];
}
@end
