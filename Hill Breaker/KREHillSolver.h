//
//  KREHillSolver.h
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

@class KREHillKey, KREHillSolverResult, KREHillSolver;

@protocol KREHillSolverDelegate <NSObject>
@optional
- (void)hillSolver:(KREHillSolver *)solver didUpdateProgress:(float)progress;
- (void)hillSolverDidFinish:(KREHillSolver *)solver;
@end

@interface KREHillSolver : NSObject

/** Cyphertext that will be analyzed by the solver */
@property (copy, nonatomic, readonly) NSString *cypherText;

/** Delegate to recieve updates on the hill solver */
@property (weak, nonatomic) id<KREHillSolverDelegate> delegate;

/** Will be populated after bruteForce finishes */
@property (strong, atomic, readonly) NSArray *results;



/** Initializes a new Hill Cypher Solver
 
 @param string String to be processed.  May be cyphertext or plaintext
 
 @return Returns a new solver object
 */
- (id)initWithString:(NSString *)string;



/** Will try to brute force a string using all possible key combinations.
 After this finishes, the results property will contain an array of KREHillSolverResults objects.
 
 This method is performed on a background thread.
 
 Callers should set themselves as the delegate of this object before running this method to
 recieve updates on the status of the solver
 */
- (void)bruteForce;


/** Will return a string enciphered with a key 
 
 @param key A key to run the string against
 
 @return Returns a string run with the key
 */
- (KREHillSolverResult *)runWithKey:(KREHillKey *)key;

@end


