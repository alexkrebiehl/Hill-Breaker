//
//  KREHillSolverResult.m
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

#import "KREHillSolverResult.h"
#import "KREHillKey.h"



@implementation KREHillSolverResult

- (id)initWithDecypheredText:(NSString *)text key:(KREHillKey *)key
{
    if (self = [super init])
    {
        _decypheredText = text;
        _key = key;
    }
    return self;
}

+ (NSString *)seperateStringIntoBlocks:(NSString *)string
{
    NSMutableString *newString = [[NSMutableString alloc] initWithString:string];
    NSInteger index = ([newString length] / BLOCK_SIZE) * BLOCK_SIZE;
    while (index > 0)
    {
        [newString insertString:@" " atIndex:index];
        index -= BLOCK_SIZE;
    }
    return newString;
}

- (BOOL)isEqual:(id)object
{
    if (object == self)
        return YES;
    if (![object isMemberOfClass:[self class]])
        return NO;
    return [self isEqualToResult:object];
}

- (BOOL)isEqualToResult:(KREHillSolverResult *)result
{
    return [_key isEqualTo:result.key] && [_decypheredText isEqualToString:result.decypheredText];
}

@end
