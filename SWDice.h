/*
Copyright 2011 Randy Carnahan <syntruth at gmail>

SWDice.h -- header file for the SWDice class.

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

#import "SWRollResult.h"

typedef enum kDiceType { 
  D4, D6, D8, D10, D12, 
  WILD_DIE, UNTRAINED, UNTRAINED_WILD_DIE 
} DieType;

@interface SWDice : NSObject {
  NSUInteger number;
  NSUInteger sides;
  NSUInteger staticModifier;
}

@property (readonly) NSUInteger number;
@property (readonly) NSUInteger sides;
@property (readonly) NSUInteger staticModifier;

+ (NSString *) getDieAsString: (DieType)die;

+ (SWDice *) getDie: (DieType)die;
+ (SWDice *) getDieFromString: (NSString *)dieString;
+ (SWDice *) withSides: (NSUInteger)s;
+ (SWDice *) withNumber: (NSUInteger)n sides: (NSUInteger)s;
+ (SWDice *) withNumber: (NSUInteger)n sides: (NSUInteger)s mod: (NSUInteger)m;

- (id) init;
- (id) initWithSides:  (NSUInteger)s;
- (id) initWithNumber: (NSUInteger)n sides: (NSUInteger)s;
- (id) initWithNumber: (NSUInteger)n sides: (NSUInteger)s mod: (NSInteger)m;

- (SWRollResult *) rollWithModifier: (int) mod againstTargetNumber: (unsigned int) targetNumber;
- (SWRollResult *) rollWithModifier: (int) mod;
- (SWRollResult *) roll;

- (NSString *) dieString;

@end
