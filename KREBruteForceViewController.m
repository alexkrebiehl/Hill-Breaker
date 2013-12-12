//
//  KREBruteForceViewController.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/12/13.
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

#import "KREBruteForceViewController.h"
#import "KREHillSolver.h"
#import "KREHillSolverResult.h"
#import "KREHillKey.h"
#import "KREKeyPopoverViewController.h"

#define MINIMUM_ROW_HEIGHT 25
#define DEFAULT_INPUT_STRING @"" //@"XSXZE GDQFX EC"

@interface KREBruteForceViewController () <KREHillSolverDelegate>

@property (strong, atomic) NSArray *results;
@property (strong, atomic) NSArray *filteredResults;

@end

@implementation KREBruteForceViewController
{
    NSArray *_words;
    KREHillSolver *_currentSolver;
    
    NSInteger _lastProgress;
    
    CGFloat _cachedRowHeight;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self loadDictionary];
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.inputTextView.stringValue = DEFAULT_INPUT_STRING;
    self.resultsLabel.stringValue = @"Results";
    _cachedRowHeight = -1;
}

- (void)loadDictionary
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"words" ofType:@"txt"];
    NSError *error;
    NSMutableString *wordString = [NSMutableString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        NSLog(@"Error reading words: %@", error);
    }
    else
    {
        _words = [wordString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    }
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    KREHillSolverResult *result = [self.filteredResults objectAtIndex:row];
    
    NSView *cellView;
    if ([tableColumn.identifier isEqualToString:@"text"])
    {
        NSTextView *v = [[NSTextView alloc] init];
        v.string = [KREHillSolverResult seperateStringIntoBlocks:result.decypheredText];
        v.font = [NSFont fontWithName:@"Menlo" size:13];
        [v setSelectable:NO];
        [v setEditable:NO];
        v.backgroundColor = [NSColor clearColor];
        
        cellView = v;
    }
    else
    {
        cellView = [[NSView alloc] init];
        
        NSButton *button = [[NSButton alloc] init];
        button.title = @"View Key";
        button.tag = row;
        [button setBezelStyle:NSInlineBezelStyle];
        [button setTarget:self];
        [button setAction:@selector(resultsKeyButonPressed:)];
        
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [cellView addSubview:button];
        
        
        NSLayoutConstraint *horizontalConstraints = [NSLayoutConstraint constraintWithItem:cellView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *verticalConstraint =    [NSLayoutConstraint constraintWithItem:cellView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:button attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
        
        [cellView addConstraints:@[horizontalConstraints, verticalConstraint]];
        
        
    }
    return cellView;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.filteredResults count];
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    KREHillSolverResult *result = [self.filteredResults objectAtIndex:row];
   
    NSTableColumn *tableColoumn = [tableView tableColumnWithIdentifier:@"text"];
    
    if (tableColoumn && _cachedRowHeight <= 0)
    {
        NSCell *dataCell = [tableColoumn dataCell];
        [dataCell setWraps:YES];
        [dataCell setStringValue:result.decypheredText];
        NSRect myRect = NSMakeRect(0, 0, [tableColoumn width], CGFLOAT_MAX);
        _cachedRowHeight = [dataCell cellSizeForBounds:myRect].height;
    }
    return _cachedRowHeight;// < MINIMUM_ROW_HEIGHT) ? MINIMUM_ROW_HEIGHT : _cachedRowHeight;
}

- (void)resultsKeyButonPressed:(NSButton *)sender
{
    KREHillSolverResult *result = [self.filteredResults objectAtIndex:sender.tag];
    
    if (![self.popover isShown])
    {
        [self.popover showRelativeToRect:[sender bounds]
                                  ofView:sender
                           preferredEdge:NSMaxXEdge];

        [(KREKeyPopoverViewController *)self.popover.contentViewController setHillKey:result.key];
        
    }
    else
    {
        [self.popover close];
    }
    
}








- (void)filterTable
{
    // Not currently implementing the dictionary attack
    const bool useDictionaryAttack = NO;
    
    NSArray *tokens = [self.tokenField objectValue];
    
    if ([tokens count] == 0)
    {
        self.filteredResults = self.results;
        [self.tableView reloadData];
    }
    else
    {
        [self.filterProgressIndicator startAnimation:nil];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
        {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(KREHillSolverResult *evaluatedObject, NSDictionary *bindings)
            {
                __block bool includeInResults = YES;
                
                [tokens enumerateObjectsUsingBlock:^(NSString *token, NSUInteger idx, BOOL *stop)
                {
                    if  ([evaluatedObject.decypheredText rangeOfString:token options:NSCaseInsensitiveSearch].location == NSNotFound)
                    {
                        includeInResults = NO;
                        *stop = YES;
                    }
                }];
                
                // Check against dictionary only if this result is still valid
                if (useDictionaryAttack && includeInResults)
                {
//                    __block bool foundADictionaryWord = NO;
                    includeInResults = NO;
                    [_words enumerateObjectsUsingBlock:^(NSString *word, NSUInteger idx, BOOL *stop)
                    {
                        if ([word length] > 3 && [evaluatedObject.decypheredText rangeOfString:word options:NSCaseInsensitiveSearch].location != NSNotFound)
                        {
                            includeInResults = YES;
                            *stop = YES;
                        }
                    }];
                    
//                    includeInResults = foundADictionaryWord;
                }

                return includeInResults;
            }];
            self.filteredResults = [self.results filteredArrayUsingPredicate:predicate];
            
            dispatch_sync(dispatch_get_main_queue(), ^
            {
                if ([self.filteredResults count] == 0 && [tokens count] == 0)
                {
                    self.filteredResults = self.results;
                }
                
                
                if ([self.results count] == 0)
                {
                    self.resultsLabel.stringValue = @"Results";
                }
                else
                {
                    NSString *possibilities = ([self.filteredResults count] == 1) ? @"possibility" : @"possibilities";
                    self.resultsLabel.stringValue = [NSString stringWithFormat:@"Results - %lu %@", (unsigned long)[self.filteredResults count], possibilities];
                }
                
                [self.filterProgressIndicator stopAnimation:nil];
                [self.tableView reloadData];
            });

        });
    }

}

- (NSArray *)tokenField:(NSTokenField *)tokenField shouldAddObjects:(NSArray *)tokens atIndex:(NSUInteger)index
{
    NSMutableArray *newTokens = [[NSMutableArray alloc] init];
    for (NSString *aString in tokens)
    {
        [newTokens addObjectsFromArray:[aString componentsSeparatedByString:@" "]];
    }
    [self performSelector:@selector(filterTable) withObject:nil afterDelay:.00001];
    return newTokens;
}

- (NSArray *)tokenField:(NSTokenField *)tokenField completionsForSubstring:(NSString *)substring indexOfToken:(NSInteger)tokenIndex indexOfSelectedItem:(NSInteger *)selectedIndex
{
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
        return [evaluatedObject rangeOfString:substring].location == 0;
    }];
    
    
    return [_words filteredArrayUsingPredicate:predicate];
}

- (IBAction)tokenFieldAction:(id)sender
{
    [self filterTable];
}

- (IBAction)textViewAction:(id)sender
{
    KREHillSolver *decryptor = [[KREHillSolver alloc] initWithString:self.inputTextView.stringValue];
    
    if (![decryptor.cypherText isEqualToString:_currentSolver.cypherText])
    {
        // Clear the table
        _results = _filteredResults = nil;
        [self.tableView reloadData];
        
        _currentSolver = decryptor;
        _currentSolver.delegate = self;
        
        self.resultsLabel.stringValue = @"Processing...";
        [self.resultsProgressIndicator setHidden:NO];
        [self.resultsProgressIndicator startAnimation:self];
        _cachedRowHeight = -1;
        
        [_currentSolver bruteForce];
    }
    
    
}


- (void)hillSolver:(KREHillSolver *)solver didUpdateProgress:(float)progress
{
    NSInteger newProgress = (NSInteger)(progress * 100);
    if (newProgress != _lastProgress)
    {
        [self.resultsProgressIndicator setDoubleValue:newProgress];
        _lastProgress = newProgress;
    }
    
}

- (void)hillSolverDidFinish:(KREHillSolver *)solver
{
    self.results = _currentSolver.results;
    [self.resultsProgressIndicator setHidden:YES];
    [self filterTable];
}


@end
