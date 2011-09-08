/*
Copyright 2011 Randy Carnahan <syntruth at gmail>

SWDice.m -- Implementation file for the SWDice class.

This software is provided 'as-is', without any express or implied
warranty.  In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to use this code in personal, non-commercial
applications, unless permission from me is granted otherwise. Also,this
code may not be redistributed without permission. The above is subject
to the follow restrictions:

1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

3. This notice may not be removed or altered from any source distribution.
*/

#import "SWDice.h"
#import "SWRollResult.h"

static NSDictionary *allDice;

@implementation SWDice

@synthesize number;
@synthesize sides;
@synthesize staticModifier;

+ (SWDice *) getDie: (DieType)die
{
  /* Build allDice dictionary if it doesn't exist. */
  if (allDice == nil) {
    NSArray *valueArray = [NSArray arrayWithObjects:
      [SWDice withSides:4],
      [SWDice withSides:6],
      [SWDice withSides:8],
      [SWDice withSides:10],
      [SWDice withSides:12],
      [SWDice withSides:6],
      [SWDice withNumber:1 sides:4 mod:-2],
      [SWDice withNumber:1 sides:6 mod:-2],
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

  return [allDice valueForKey: [NSString stringWithFormat:@"%d", die]];
}

+ getDieFromString: (NSString *)dieString
{
  /* XXX -- Default to a d4; change this later? */
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
    die = D4;
  }

  if ([dieString compare: @"UNTRAINED_WILD_DIE"
                 options:NSCaseInsensitiveSearch] == NSOrderedSame)
  {
    die = UNTRAINED_WILD_DIE;
  }

  return [SWDice getDie:die];
}

+ (NSString *) getDieAsString: (DieType)die
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

- (id) init
{
  return [self initWithNumber:1 sides:6 mod:0];
}

- (id) initWithSides: (NSUInteger)s
{
  return [self initWithNumber:1 sides:s mod:0];
}

+ (SWDice *) withSides: (NSUInteger)s
{
  return [[[SWDice alloc] initWithSides:s] autorelease];
}

- (id) initWithNumber: (NSUInteger)n
       sides:          (NSUInteger)s
{
  return [self initWithNumber:n sides:s mod:0];
}

+ (SWDice *) withNumber: (NSUInteger)n 
             sides:      (NSUInteger)s
{
  return [[[SWDice alloc] initWithNumber:n sides:s] autorelease];
}

- (id) initWithNumber: (NSUInteger)n
       sides:          (NSUInteger)s
       mod:            (NSInteger)m
{
  if (self = [super init]) { 
    number         = n;
    sides          = s;
    staticModifier = m;
  }

  return self;
}

+ (SWDice *) withNumber: (NSUInteger)n
             sides:      (NSUInteger)s
             mod:        (NSUInteger)m
{
  return [[[SWDice alloc] initWithNumber:n sides:s mod:m] autorelease];
}

- (SWRollResult *) rollWithModifier:    (int)mod
                   againstTargetNumber: (unsigned int)targetNumber
{
  NSMutableArray *tally = [[NSMutableArray alloc] init];
  int i = 0;
  int t = 0;

  mod += self.staticModifier;

  while (i < self.number) {
    t = (arc4random() % self.sides) + 1;

    if (t != self.sides) i++;

    [tally addObject: [NSNumber numberWithInt: t]];
  }

  [tally sortUsingComparator:^(id num1, id num2) {
    return [num1 compare:num2];
   }];

  NSArray *sorted = [[tally reverseObjectEnumerator] allObjects];            

  SWRollResult *result = [SWRollResult resultWithTally:sorted
                                       modifier:mod
                                       targetNumber:targetNumber];
  [tally release];

  return result;
}

- (SWRollResult *) rollWithModifier: (int) mod
{
  return [self rollWithModifier:mod againstTargetNumber:4];
}

- (SWRollResult *) roll
{
  return [self rollWithModifier:0 againstTargetNumber:4];
}

- (NSString *) dieString
{
  NSMutableString *die = [[[NSMutableString alloc] init] autorelease];

  if (self.number > 0) {
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
