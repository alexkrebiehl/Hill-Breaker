//
//  KREHillSolverResult.h
//  Hill Breaker
//
//  Created by Alex Krebiehl on 10/11/13.
//  Copyright (c) 2013 Alex Krebiehl. All rights reserved.
//

#import <Foundation/Foundation.h>



@class KREHillKey;

@interface KREHillSolverResult : NSObject

/** The resulting text after being processed with a key */
@property (copy, nonatomic, readonly) NSString *decypheredText;

/** Key that was used to encipher/decipher the text */
@property (strong, nonatomic, readonly) KREHillKey *key;



#define BLOCK_SIZE 5
/** Helper method to seperate a string into blocks
 
 @param string A string to seperate
 
 @return Returns a string seperated into BLOCK_SIZE blocks
 */
+ (NSString *)seperateStringIntoBlocks:(NSString *)string;



/** Creates a new result object
 
 @param text The text that was encyphered/decyphered
 @param key The key that was used
 
 @return A new result object
 */
- (id)initWithDecypheredText:(NSString *)text key:(KREHillKey *)key;




/** Compares this object against another for equality
 @param result A result object
 
 @return Returns YES if the objects are equal
 */
- (BOOL)isEqualToResult:(KREHillSolverResult *)result;


@end

