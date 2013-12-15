//
//  KREHillKey.h
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

#import <Foundation/Foundation.h>

extern NSString *KREInvalidMatrixException;


/** Data structure to represent a matrix */
typedef struct
{
    NSInteger a;
    NSInteger b;
    NSInteger c;
    NSInteger d;
} KREMatrix;



/** A helper function to quickly create matrices
 
 @param a Value for the upper left position in the matrix
 @param b Value for the upper right position in the matrix
 @param c Value for the lower left position in the matrix
 @param d Value for the lower right position in the matrix
 
 @return Returns a new matrix
 */
KREMatrix KREMatrixMake( NSInteger a, NSInteger b, NSInteger c, NSInteger d );




@interface KREHillKey : NSObject


/** The inverse of the key */
@property (strong, nonatomic, readonly) KREHillKey *inverse;

/** The matrix that is backing this key */
@property (nonatomic, readonly) KREMatrix matrix;



/** Initializes a new key.  Trying to initialize with a matrix that
 doesn't have an inverse will return nil
 
 @param matrix A matrix to use for the key
 
 @return Returns a new key
 */
- (id)initWithMatrix:(KREMatrix)matrix;



/** Determines if a given matrix has a valid inverse
 
 @param matrix A matrix to check for an inverse
 
 @return Returns YES if a matrix has a valid inverse, otherwise NO
 */
+ (bool)inverseExistsForMatrix:(KREMatrix)matrix;




/** Generates all 2x2 keys that have a valid inverse
 
 @return Returns an array of valid encryption keys
 */
+ (NSArray *)allPossibleKeys;



/** Tries to generate a key for an invalid matrix, altering it until it has an inverse
 
 @param matrix A matrix that does not have an inverse
 
 @return Returns a valid key that is similiar to the given matrix
 */
+ (KREHillKey *)generateKeyLikeMatrix:(KREMatrix)matrix;






@end
