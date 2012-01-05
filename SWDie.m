// Copyright 2011 Randy Carnahan <syntruth at gmail>
//
// SWDie.m -- Implementation file for the SWDice class.
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

#import "SWDie.h"

// The dictionary to hold all of the standard Savage Worlds
// dice objects. This is so we don't have to create new objects
// everytime we need a standard die roll.
static NSDictionary *allDice;

@implementation SWDie

+ (SWDie *) getDie:(DieType)die
{
  // Build allDice dictionary if it doesn't exist.
  if (allDice == nil) {
    NSArray *valueArray = [NSArray arrayWithObjects:
      [SWDie withSides:4],
      [SWDie withSides:6],
      [SWDie withSides:8],
      [SWDie withSides:10],
      [SWDie withSides:12],
      [SWDie withSides:6],
      [SWDie withNumber:1 sides:4 mod:-2],
      [SWDie withNumber:1 sides:6 mod:-2],
      nil];

    NSArray *keyArray = [NSArray arrayWithObjects:
      [NSString stringWithFormat:@"%d", D4],
      [NSString stringWithFormat:@"%d", D6],
      [NSString stringWithFormat:@"%d", D8],
      [NSString stringWithFormat:@"%d", D10],
      [NSString stringWithFormat:@"%d", D12],
      [NSString stringWithFormat:@"%d", WILD_DIE],
      [NSString stringWithFormat:@"%d", UNTRAINED],
      [NSString stringWithFormat:@"%d", UNTRAINED_WILD_DIE],
      nil];

    allDice = [NSDictionary dictionaryWithObjects:valueArray
                                          forKeys:keyArray];
  }

  return [allDice valueForKey:[NSString stringWithFormat:@"%d", die]];
}

+ getDieFromString:(NSString *)dieString
{
  // XXX -- Default to a d4; change this later?
  DieType die = D4;

  if ([dieString compare: @"d4" 
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = D4;
  }

  if ([dieString compare: @"d6"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = D6;
  }

  if ([dieString compare: @"d8"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = D8;
  }

  if ([dieString compare: @"d10"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = D10;
  }

  if ([dieString compare: @"d12"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = D12;
  }

  if ([dieString compare: @"WILD_DIE"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = WILD_DIE;
  }

  if ([dieString compare: @"UNTRAINED"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = UNTRAINED;
  }

  if ([dieString compare: @"UNTRAINED_WILD_DIE"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = UNTRAINED_WILD_DIE;
  }

  return [[self class] getDie:die];
}

+ (NSString *) getDieAsString:(DieType)die
{
  switch(die) {
  case D4:
    return @"d4";
  case D6:
    return @"d6";
  case D8:
    return @"d8";
  case D10:
    return @"d10";
  case D12:
    return @"d12";
  case WILD_DIE:
    return @"Wild Die";
  case UNTRAINED:
    return @"Untrained";
  case UNTRAINED_WILD_DIE:
    return @"Untrained Wild Die";
  default:
    return @"Unknown Die Type";
  }
}

- (NSInteger) halfWithModifier:(BOOL)withMod
{
  NSInteger result = 0;

  if (withMod) {
    result = self.sides + self.staticModifier;
  }
  else {
    result = self.sides;
  }

  return result / 2;
}

- (NSInteger) half
{
  return [self halfWithModifier:NO];
}

- (NSInteger) value
{
  return self.sides;
}

@end
