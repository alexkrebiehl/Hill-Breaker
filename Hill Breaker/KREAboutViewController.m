//
//  KREAboutViewController.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 12/15/13.
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

#import "KREAboutViewController.h"

@interface KREAboutViewController ()

@end

@implementation KREAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        

    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    // Load the license from file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"LICENSE"
                                                     ofType:@""];
    NSString *license = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    self.licenseTextView.string = license;
    
}

@end
