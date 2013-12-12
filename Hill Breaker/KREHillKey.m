//
//  KREHillKey.m
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

#import "KREHillKey.h"

enum { KREInvalidInverse = INT_MIN };

KREMatrix KREMatrixMake(NSInteger a, NSInteger b, NSInteger c, NSInteger d)
{
    KREMatrix matrix;
    matrix.a = a;
    matrix.b = b;
    matrix.c = c;
    matrix.d = d;
    return matrix;
}

static NSArray *_allKeys;

@implementation KREHillKey

@synthesize inverse = _inverse;

+ (KREHillKey *)generateKeyLikeMatrix:(KREMatrix)matrix
{
    if ([KREHillKey inverseExistsForMatrix:matrix])
    {
        return [[KREHillKey alloc] initWithMatrix:matrix];
    }

    // Check all A's
    for (NSInteger a = 0; a < 26; a++)
    {
        KREHillKey *key = [[KREHillKey alloc] initWithMatrix:KREMatrixMake((matrix.a + a) % 26 + 1, matrix.b, matrix.c, matrix.d)];
        if (key != nil)
        {
            return key;
        }
    }
    
    // Check all B's
    for (NSInteger b = 0; b < 26; b++)
    {
        KREHillKey *key = [[KREHillKey alloc] initWithMatrix:KREMatrixMake(matrix.a, (matrix.b + b) % 26 + 1, matrix.c, matrix.d)];
        if (key != nil)
        {
            return key;
        }
    }
    
    // Check all C's
    for (NSInteger c = 0; c < 26; c++)
    {
        KREHillKey *key = [[KREHillKey alloc] initWithMatrix:KREMatrixMake(matrix.a, matrix.b, (matrix.c + c) % 26 + 1, matrix.d)];
        if (key != nil)
        {
            return key;
        }
    }
    
    // Check all D's
    for (NSInteger d = 0; d < 26; d++)
    {
        KREHillKey *key = [[KREHillKey alloc] initWithMatrix:KREMatrixMake(matrix.a, matrix.b, matrix.c, (matrix.d + d) % 26 + 1)];
        if (key != nil)
        {
            return key;
        }
    }
    
    // Couldn't find anything ???
    return nil;
}

+ (NSArray *)allPossibleKeys
{
    if (_allKeys == nil)
    {
        NSMutableArray *allKeys = [[NSMutableArray alloc] init];
        
        // Yuck
        for (NSInteger a = 1; a <= 26; a++)
        {
            for (NSInteger b = 1; b <= 26; b++)
            {
                for (NSInteger c = 1; c <= 26; c++)
                {
                    for (NSInteger d = 1; d <= 26; d++)
                    {
                        KREHillKey *possibleKey = [[KREHillKey alloc] initWithMatrix:KREMatrixMake(a, b, c, d)];
                        if (possibleKey != nil)
                        {
                            [allKeys addObject:possibleKey];
                        }
                    }
                }
            }
        }
        _allKeys = allKeys;
    }
    
    return _allKeys;
}

- (id)init
{
    return [self initWithMatrix:KREMatrixMake(1, 1, 1, 1)];
}

- (id)initWithMatrix:(KREMatrix)matrix
{
    if (![KREHillKey inverseExistsForMatrix:matrix])
    {
        return nil;
    }
    
    if (self = [super init])
    {
        _matrix = matrix;
    }
    return self;
}

- (KREHillKey *)inverse
{
    if (_inverse == nil)
    {
        NSAssert([KREHillKey inverseExistsForMatrix:self.matrix], @"Something went wrong");
        
        NSInteger inverseA = ( self.matrix.d * multiplicateInverse([self determinate]) ) % 26;
        NSInteger inverseB = ( self.matrix.b * multiplicateInverse(-1 * [self determinate]) ) % 26;
        NSInteger inverseC = ( self.matrix.c * multiplicateInverse(-1 * [self determinate]) ) % 26;
        NSInteger inverseD = ( self.matrix.a * multiplicateInverse([self determinate]) ) % 26;
        
        _inverse = [[KREHillKey alloc] initWithMatrix:KREMatrixMake( inverseA, inverseB, inverseC, inverseD )];
    }
    return _inverse;
}

NSInteger multiplicateInverse( NSInteger number )
{
    while (number < 0) number += 26;
    
    NSInteger inverse = 0;
    switch (number % 26) {
        case 1:
            inverse = 1;
            break;
        case 3:
            inverse = 9;
            break;
        case 5:
            inverse = 21;
            break;
        case 7:
            inverse = 15;
            break;
        case 9:
            inverse = 3;
            break;
        case 11:
            inverse = 19;
            break;
        case 15:
            inverse = 7;
            break;
        case 17:
            inverse = 23;
            break;
        case 19:
            inverse = 11;
            break;
        case 21:
            inverse = 5;
            break;
        case 23:
            inverse = 17;
            break;
        case 25:
            inverse = 25;
            break;
            
        default:
            inverse = KREInvalidInverse;
            break;
    }
    return inverse;
}

- (NSInteger)determinate
{
    return self.matrix.a * self.matrix.d - self.matrix.b * self.matrix.c;
}

+ (bool)inverseExistsForMatrix:(KREMatrix)matrix
{
    NSInteger determinate = ( matrix.a * matrix.d - matrix.b * matrix.c);
    return multiplicateInverse(determinate) != KREInvalidInverse;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
        return YES;
    if (![object isMemberOfClass:[self class]])
        return NO;
    return [self isEqualToKey:object];
}

- (bool)isEqualToKey:(KREHillKey *)key
{
    return (self.matrix.a == key.matrix.a && self.matrix.b == key.matrix.b && self.matrix.c == key.matrix.c && self.matrix.d == key.matrix.d);
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"{{%ld, %ld} {%ld, %ld}}", (long)self.matrix.a, (long)self.matrix.b, (long)self.matrix.c, (long)self.matrix.d];
}


@end
