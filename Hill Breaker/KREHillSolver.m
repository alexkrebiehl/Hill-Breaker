//
//  KREHillSolver.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/11/13.
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

#import "KREHillSolver.h"
#import "KREHillKey.h"
#import "KREHillSolverResult.h"

#define THREAD_FACTOR   200  // The higher the number, the less theads there will be
#define MIN_THREADS     1    // Minimum number of threads allowed
#define MAX_THREADS     10   // Maximum number of threads allowed

typedef struct
{
    unichar charA;
    unichar charB;
} KRELetterBlock;

@interface KREHillSolver ()

@property (strong, atomic) NSMutableArray *internalResults;
@property (atomic) NSInteger totalKeysRunning;
@property (atomic) NSInteger totalKeysFinished;
@property (atomic) NSInteger numberOfSubsetsFinished;

@end


@implementation KREHillSolver
{
    NSInteger _numberOfThreads;
    
    // Trackers for brute force
    NSDate *_startTime;
}
@synthesize results = _externalResults;

- (id)init
{
    return [self initWithString:@""];
}

- (id)initWithString:(NSString *)string
{
    if (self = [super init])
    {
        // Make all letters uppercase and strip out the spaces
        NSString *cypherText = [[NSString alloc] initWithString:[[string stringByReplacingOccurrencesOfString:@" " withString:@""] uppercaseString]];
        
        // Strip out just the letters
        NSCharacterSet *characterSet = [[NSCharacterSet uppercaseLetterCharacterSet] invertedSet];
        cypherText = [[cypherText componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
        
        // Make sure string is of even length
        if ([cypherText length] % 2 != 0)
        { 
            cypherText = [NSString stringWithFormat:@"%@X", cypherText];
        }
        _cypherText = cypherText;
        
        _numberOfThreads = numberOfThreadsForStringLength( [string length] );
    }
    return self;
}

NSInteger numberOfThreadsForStringLength( NSInteger stringLength )
{
    NSInteger threads = ceil( stringLength / (float)THREAD_FACTOR );
    if ( threads < MIN_THREADS || threads < 1 )
    {
        threads = ( MIN_THREADS < 1 ) ? 1 : MIN_THREADS;
    }
    else if ( threads > MAX_THREADS )
    {
        threads = MAX_THREADS;
    }
    return threads;
}

- (void)bruteForce
{
    // Dont run again if we have already found results
    if ( self.results == nil )
    {
        // Reset all of the trackers
        _startTime = [NSDate new];
        self.internalResults = [[NSMutableArray alloc] init];
        self.totalKeysFinished = 0;
        self.numberOfSubsetsFinished = 0;
        
        NSArray *keys = [KREHillKey allPossibleKeys];
        self.totalKeysRunning = [keys count];
        
        // Split keys into chunks to use in different threads
        for ( NSInteger i = 0; i < _numberOfThreads; i++ )
        {
            NSUInteger location = ( [keys count] / _numberOfThreads ) * i;
            NSUInteger length = [keys count] / _numberOfThreads;
            if (location + length >= [keys count])
            {
                length = [keys count] - location;
            }

            NSArray *subSet = [keys objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(location, length)]];
            
            // Run the subset of keys
            NSLog( @"Creating a thread for %lu keys", (unsigned long)length );
            [self bruteForceWithKeys:subSet];
        }
    }
    else
    {
        [self.delegate hillSolverDidFinish:self];
    }
}

- (void)bruteForceWithKeys:(NSArray *)keys
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:[keys count]];
        [keys enumerateObjectsUsingBlock:^(KREHillKey *key, NSUInteger idx, BOOL *stop)
        {
             [results addObject:[self runWithKey:key]];
             
             // Handles updating the delegate
             [self bruteForceKeyDidFinish];
         }];
        
        // Merges this threads results with the other threads
        [self bruteForceSubsetDidFinishWithResults:results];
    });

}

- (void)bruteForceKeyDidFinish
{
    // Call back to the UI with progress
    self.totalKeysFinished++;
    dispatch_async( dispatch_get_main_queue(), ^
    {
        if ( self.totalKeysFinished % 10 == 0 )
        {
            [self.delegate hillSolver:self didUpdateProgress:( (float) self.totalKeysFinished ) / (float) self.totalKeysRunning ];
        }
    });
}

- (void)bruteForceSubsetDidFinishWithResults:(NSArray *)results
{
    dispatch_sync( dispatch_get_main_queue(), ^
    {
        // Merge results from a thread with the overall results
        [self.internalResults addObjectsFromArray:results];
        self.numberOfSubsetsFinished++;
        
        // See if all threads are finished
        if (self.numberOfSubsetsFinished == _numberOfThreads)
        {
            // Make the results available externally
            _externalResults = self.internalResults;
            
            NSLog(@"Brute force execution time: %fs on %ld threads", ABS( [_startTime timeIntervalSinceNow]), (long)_numberOfThreads);
            
            // Let the delegate know we're done and that it's safe to poll for the results
            [self.delegate hillSolverDidFinish:self];
        }
    });
}

- (KREHillSolverResult *)runWithKey:(KREHillKey *)key;
{
    NSAssert( key != nil, @"Key must not be nil!" );

    NSMutableString *encryptedString = [[NSMutableString alloc] init];
    NSInteger index = -1;
    while ( index < (NSInteger)[_cypherText length] - 1 )
    {
        unichar charA = [_cypherText characterAtIndex:++index];
        unichar charB = [_cypherText characterAtIndex:++index];
        KRELetterBlock encryptedBlock = encryptBlock( KRELetterBlockMake(charA, charB), key );
        
        [encryptedString appendFormat:@"%c%c", encryptedBlock.charA, encryptedBlock.charB];
    }
    
    return [[KREHillSolverResult alloc] initWithDecypheredText:encryptedString key:key];
}









NSInteger characterAsNumber( unichar aCharacter )
{
    // 0 and 26 both represent Z
    NSInteger number = (NSInteger)aCharacter - (NSInteger)'A' + 1;
    NSInteger numberToReturn = (number == 0) ? 26 : number;
    assert(numberToReturn > 0 && numberToReturn <= 26);
    return numberToReturn;
}

unichar numberAsCharacter( NSInteger aNumber )
{
    // 0 and 26 both represent Z
    if (aNumber == 0) aNumber = 26;
    return (unichar)( aNumber + (NSInteger)'A' - 1 );
}

KRELetterBlock encryptBlock( KRELetterBlock blockToEncrypt, KREHillKey *key )
{
    NSInteger aAsNumber = characterAsNumber( blockToEncrypt.charA );
    NSInteger bAsNumber = characterAsNumber( blockToEncrypt.charB );
    
    NSInteger encryptedA = ( aAsNumber * key.matrix.a + bAsNumber * key.matrix.b ) % 26;
    NSInteger encryptedB = ( aAsNumber * key.matrix.c + bAsNumber * key.matrix.d ) % 26;
    
    return KRELetterBlockMake( numberAsCharacter(encryptedA), numberAsCharacter(encryptedB) );
}

KRELetterBlock KRELetterBlockMake( unichar charA, unichar charB )
{
    KRELetterBlock block = { charA, charB };
    return block;
}

@end
