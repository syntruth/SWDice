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

@synthesize tally        = _tally;
@synthesize modifier     = _modifier;
@synthesize total        = _total;
@synthesize success      = _success;
@synthesize raises       = _raises;
@synthesize targetNumber = _targetNumber;

- (id) initWithTally:(NSArray *)  tally
            modifier:(NSInteger)  mod
        targetNumber:(NSUInteger) tn
{
  if (self = [super init]) {

    _tally = tally;

    _modifier     = mod;
    _targetNumber = tn;

    for (NSNumber *n in self.tally) {
      _total += [n intValue];
    }

    _total  += self.modifier;
    _success = (_total >= _targetNumber);
    _raises  = (_total  - _targetNumber) / 4;
  }

  return self;
}

- (id) initWithTally:(NSArray *)  tally 
        targetNumber:(NSUInteger) tn
{
  return [self initWithTally:tally modifier:0 targetNumber:tn];
}

- (id) initWithTally:(NSArray *) tally
{
  return [self initWithTally:tally modifier:0 targetNumber:4];
}

+ (SWRollResult *) resultWithTally:(NSArray *)  tally 
                          modifier:(NSInteger)  mod 
                      targetNumber:(NSUInteger) tn
{
  return [[SWRollResult alloc] initWithTally:tally
                                    modifier:mod
                                targetNumber:tn];
}

+ (SWRollResult *) resultWithTally:(NSArray *)  tally 
                      targetNumber:(NSUInteger) tn
{
  return [[SWRollResult alloc] initWithTally:tally 
                                    modifier:0
                                targetNumber:tn];
}

+ (SWRollResult *) resultWithTally:(NSArray *) tally
{
  return [[SWRollResult alloc] initWithTally:tally
                                    modifier:0
                                targetNumber:0];
}

- (NSString *) tallyAsString
{
  return [self.tally componentsJoinedByString:@", "]
}

@end
