/*
Copyright 2011 Randy Carnahan <syntruth at gmail>

SWRollResult.h -- header file for the SWRollResult class.

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

@interface SWRollResult : NSObject {
  NSArray    * tally;
  NSInteger    modifier;
  NSInteger    total;
  NSUInteger   raises;
  NSUInteger   targetNumber;
}

@property (readonly, retain) NSArray *tally;
@property NSInteger  modifier;
@property NSInteger  total;
@property NSUInteger raises;
@property NSUInteger targetNumber;

- (id) initWithTally: (NSArray *) aTally modifier: (NSInteger)modifier targetNumber: (unsigned int) tn;
- (id) initWithTally: (NSArray *) aTally targetNumber: (NSUInteger) tn;
- (id) initWithTally: (NSArray *) aTally;
- (bool) success;
- (void) process;

@end
