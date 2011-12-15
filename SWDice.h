// Copyright 2011 Randy Carnahan <syntruth at gmail>
//
// SWDice.h -- header file for the SWDice class.
//
// This software is provided 'as-is', without any express or implied
// warranty.  In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to use this code in personal, non-commercial
// applications, unless permission from me is granted otherwise. Also,this
// code may not be redistributed without permission. The above is subject
// to the follow restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
//
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
//
// 3. This notice may not be removed or altered from any source distribution.

#import "SWRollResult.h"

// The SWDice class.
@interface SWDice : NSObject {
  NSUInteger number;
  NSUInteger sides;
  NSUInteger staticModifier;
}

@property (readonly) NSUInteger number;
@property (readonly) NSUInteger sides;
@property (readonly) NSUInteger staticModifier;

// Designated initializer.
// All params are NSInteger or NSUInteger, though |num| and |sides| must
// next be unsigned!
- (id) initWithNumber:(NSUInteger)num 
                sides:(NSUInteger)sides
                  mod:(NSInteger)mod;

// Calls the designated initializer with |mod| set to 0.
- (id) initWithNumber:(NSUInteger)num sides:(NSUInteger)sides;

// Calls the designated initalize with a |num| and |mod| set to 0.
- (id) initWithSides:(NSUInteger)sides;

// NSObject init override; calls -initWithNumber:sides:mod: with
// the followind default values: 1, 6, 0, respectively.
- (id) init;

// The following three class methods return autoreleased instances of
// a SWDice object. See -initWithNumber:sides:mod: for param details.
+ (SWDice *) withNumber:(NSUInteger)num 
                  sides:(NSUInteger)sides
                    mod:(NSUInteger)mod;

+ (SWDice *) withNumber:(NSUInteger)num sides:(NSUInteger)sides;

+ (SWDice *) withSides:(NSUInteger)sides;

// "Rolls" the SWDice object, creating a NSMutableArray tally object
// to track the results of each die roll. It then returns an 
// autoreleased instance of a SWRollResult object, passing targetNumber
// to that object.
- (SWRollResult *) rollWithModifier:(NSInteger)mod
                againstTargetNumber:(NSUInteger)targetNumber;

// Calls -rollWithModifier:againstTargetNumber: with |targetNumber|
// set to the Savage Worlds default of 4.
- (SWRollResult *) rollWithModifier:(NSInteger)mod;

// Calls -rollWithModifier:againstTargetNumber: with |mod| set to
// a default of 0.
- (SWRollResult *) rollAgainstTargetNumber:(NSUInteger)targetNumber;

// Calls -rollWithModifier:againstTargetNumber: with |mod| set to
// a default of 0 and |targetNumber| to the default of 4.
- (SWRollResult *) roll;

// Returns a string that represents a custom SWDice object, in the standard
// dice format of xdx[+/-x], thus a SWDice object created for three 4-sided
// dice with a modifier of -2 would return "3d4-2".
- (NSString *) asString;

@end
