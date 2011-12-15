// Copyright 2011 Randy Carnahan <syntruth at gmail>
//
// SWDice.m -- Implementation file for the SWDice class.
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
#import "SWRollResult.h"

@implementation SWDice

@synthesize number;
@synthesize sides;
@synthesize staticModifier;

- (id) initWithNumber:(NSUInteger)num
                sides:(NSUInteger)sides
                  mod:(NSInteger)mod
{
  if (self = [super init]) { 
    number         = num;
    sides          = sides;
    staticModifier = mod;
  }

  return self;
}

- (id) initWithNumber:(NSUInteger)num
                sides:(NSUInteger)sides
{
  return [self initWithNumber:num sides:sides mod:0];
}

- (id) initWithSides:(NSUInteger)sides
{
  return [self initWithNumber:1 sides:sides mod:0];
}

- (id) init
{
  return [self initWithNumber:1 sides:6 mod:0];
}

+ (SWDice *) withNumber:(NSUInteger)num
                  sides:(NSUInteger)sides
                    mod:(NSUInteger)mod
{
  return [[[SWDice alloc] initWithNumber:num sides:sides mod:mod] autorelease];
}

+ (SWDice *) withNumber:(NSUInteger)num
                  sides:(NSUInteger)sides
{
  return [[[SWDice alloc] initWithNumber:num sides:sides mod:0] autorelease];
}

+ (SWDice *) withSides:(NSUInteger)s
{
  return [[[SWDice alloc] initWithNumber:1 sides:sides mod:0] autorelease];
}

- (SWRollResult *) rollWithModifier:(NSInteger)mod
                againstTargetNumber:(NSUInteger)targetNumber
{
  NSMutableArray *tally = [[[NSMutableArray alloc] init] autorelease];
  int i = 0;
  int t = 0;

  mod += self.staticModifier;

  while (i < self.number) {
    t = (arc4random() % self.sides) + 1;

    if (t != self.sides) i++;

    [tally addObject: [NSNumber numberWithInt: t]];
  }
  
  // Sort the tally from lowest to highest...
  [tally sortUsingComparator:^(id num1, id num2) {
    return [num1 compare:num2];
  }];

  // ...then reverse it.
  NSArray *reversed = [[tally reverseObjectEnumerator] allObjects];            

  // Create the SWRollResult object, calling the autoreleased
  // creation method.
  SWRollResult *result = [SWRollResult resultWithTally:reversed
                                              modifier:mod
                                          targetNumber:targetNumber];
  return result;
}

- (SWRollResult *) rollWithModifier:(NSInteger)mod
{
  return [self rollWithModifier:mod againstTargetNumber:4];
}

- (SWRollResult *) rollAgainstTargetNumber:(NSUInteger)targetNumber
{
  return [self rollWithModifier:0 againstTargetNumber:targetNumber];
}

- (SWRollResult *) roll
{
  return [self rollWithModifier:0 againstTargetNumber:4];
}

- (NSString *) asString
{
  NSMutableString *die = [[[NSMutableString alloc] init] autorelease];

  if (self.number > 1) {
    [die appendFormat:@"%d", self.number];
  }

  [die appendFormat:@"d%d", self.sides];

  if (self.staticModifier >= 1) {
    [die appendFormat:@"+%d", self.staticModifier];
  }
  else if (self.staticModifier < 0) {
    [die appendFormat:@"%d", self.staticModifier];
  }

  return die;
}

@end
