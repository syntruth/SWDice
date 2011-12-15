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
