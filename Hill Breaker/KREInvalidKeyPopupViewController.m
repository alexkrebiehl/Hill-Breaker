//
//  KREInvalidKeyPopupViewController.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/14/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import "KREInvalidKeyPopupViewController.h"
#import "KREHillKey.h"

@interface KREInvalidKeyPopupViewController ()

@end

@implementation KREInvalidKeyPopupViewController

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
    [self displayKey:hillKey];
}

- (void)displayKey:(KREHillKey *)key
{
    self.matrixLabelA.stringValue = [@(key.matrix.a) stringValue];
    self.matrixLabelB.stringValue = [@(key.matrix.b) stringValue];
    self.matrixLabelC.stringValue = [@(key.matrix.c) stringValue];
    self.matrixLabelD.stringValue = [@(key.matrix.d) stringValue];
}

- (IBAction)useKeyButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(userDidChooseKeyFromPopover:)])
    {
        [self.delegate userDidChooseKeyFromPopover:self.hillKey];
    }
}
@end
