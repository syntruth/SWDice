// Copyright 2011 Randy Carnahan <syntruth at gmail>
//
// SWRollResult.h -- header file for the SWRollResult class.
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

@interface SWRollResult : NSObject

@property (nonatomic, readonly)  NSArray *tally;
@property (nonatomic) NSInteger  modifier;
@property (nonatomic) NSInteger  total;
@property (nonatomic) bool       success;
@property (nonatomic) NSUInteger raises;
@property (nonatomic) NSUInteger targetNumber;

// Designated initializer. |aTally| will be retained.
- (id) initWithTally:(NSArray *)tally 
            modifier:(NSInteger)mod 
        targetNumber:(NSUInteger)tn;

// Wrapper for -initWithTally:modifier:targetNumber: defaulting
// |mod| to 0.
- (id) initWithTally:(NSArray *)tally
        targetNumber: (NSUInteger)tn;

// Wrapper for -initWithTally:modifier:targetNumber: defaulting
// |mod| and |tn| to 0.
- (id) initWithTally:(NSArray *)tally;

// The following three methods returns an autoreleased instance 
// of SWRollResult. See -initWithTally:modifier:targetNumber: 
// for details.
+ (SWRollResult *) resultWithTally:(NSArray *)tally
                          modifier:(NSInteger)mod
                      targetNumber:(NSUInteger)tn;

+ (SWRollResult *) resultWithTally:(NSArray *)tally
                      targetNumber:(NSUInteger)tn;

+ (SWRollResult *) resultWithTally:(NSArray *)tally;

// Returns a string of the tally, joined by commas. i.e.: 4, 3, 2
- (NSString *) tallyAsString;

@end
