//
//  KREKeyPopoverViewController.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/13/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
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
