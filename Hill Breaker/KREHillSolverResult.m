//
//  KREHillSolverResult.m
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/11/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
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
