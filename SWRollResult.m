// Copyright 2011 Randy Carnahan <syntruth at gmail>
//
// SWRollResult.m -- implementation file for the SWRollResult class.
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

@implementation SWRollResult

@synthesize tally;
@synthesize modifier;
@synthesize total;
@synthesize success;
@synthesize raises;
@synthesize targetNumber;

- (id) initWithTally:(NSArray *)  aTally
            modifier:(NSInteger)  mod
        targetNumber:(NSUInteger) tn
{
  if (self = [super init]) {
    if (tally != nil) {
      [tally release];
    }

    tally = [aTally retain];

    self.modifier     = mod;
    self.targetNumber = tn;
    self.total        = 0;
    self.raises       = 0;

    [self process];
  }

  return self;
}

- (id) initWithTally:(NSArray *)  aTally 
        targetNumber:(NSUInteger) tn
{
  return [self initWithTally:aTally modifier:0 targetNumber:tn];
}

- (id) initWithTally:(NSArray *) aTally
{
  return [self initWithTally:aTally modifier:0 targetNumber:4];
}

+ (SWRollResult *) resultWithTally:(NSArray *)  aTally 
                          modifier:(NSInteger)  mod 
                      targetNumber:(NSUInteger) tn
{
  return [[[SWRollResult alloc] initWithTally:aTally
                                     modifier:mod
                                 targetNumber:tn] autorelease];
}

+ (SWRollResult *) resultWithTally:(NSArray *)  aTally 
                      targetNumber:(NSUInteger) tn
{
  return [[[SWRollResult alloc] initWithTally:aTally 
                                     modifier:0
                                 targetNumber:tn] autorelease];
}

+ (SWRollResult *) resultWithTally: (NSArray *)aTally
{
  return [[[SWRollResult alloc] initWithTally:aTally
                                     modifier:0
                                 targetNumber:0] autorelease];
}

- (void) process
{
  for (NSNumber *n in tally) {
    self.total += [n intValue];
  }

  self.total  += self.modifier;
  self.success = (self.total >= self.targetNumber);
  self.raises  = (self.total - self.targetNumber) / 4;
}

- (NSString *) tallyAsString
{
  return [tally componentsJoinedByString:@", "]
}

- (void) dealloc
{
  [tally release];
  tally = nil;

  [super dealloc];
}
@end
