// Copyright 2011 Randy Carnahan <syntruth at gmail>
//
// SWDie.h -- Implementation file for the SWDice class.
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

#import "SWDice.h"

// The DieType enum, for the standard Savage Worlds dice.
typedef enum { 
  D4, D6, D8, D10, D12, 
  WILD_DIE, 
  UNTRAINED, 
  UNTRAINED_WILD_DIE 
} DieType;

@interface SWDie : SWDice

// Returns a singular Savage Worlds Die.
+ (SWDie *) getDie:(DieType)die;

// Class method to return the string representation of a value
// from the DieType enum, usable for output.
+ (NSString *) getDieAsString:(DieType)die;

// Class method that returns a SWDie instance of a Savage Worlds die
// based on a string representation of a die; i.e.: d6
// Thus, you could technically do this (but why would you?):
//
// SWDie *die = [SWDie getDieFromString:[SWDie getDieAsString:D6]]
//
+ (SWDie *) getDieFromString:(NSString *)dieString;

// Returns the half value of the die, after adding
// the static modifier.
- (NSInteger) halfWithModifier:(BOOL)withMod;

// Returns half the self.sides value.
- (NSInteger) half;

// Merely a convienence wrapper for self.sides
- (NSInteger) value;

@end
