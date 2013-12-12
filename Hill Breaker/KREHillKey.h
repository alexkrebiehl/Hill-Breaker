//
//  KREHillKey.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/11/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import <Foundation/Foundation.h>




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
