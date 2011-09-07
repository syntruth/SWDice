Objective-C basic library for Savage Worlds Dice. 

I have compiled this code in an iOS application and have tested it
to an extent, found and fixed a memory leak, and so far, so good.

Example of usage:

    SWDice       *die    = [SWDice getDie: D8];
    SWRollResult *result = [die roll];

    NSLog(@"The %s die roll was: %d", [SWDice getDieAsString:D8], result.total);
    NSLog(@"Roll tally: %s", [result.tally componentsJoinedByString:@", ");


Read the license before using! Thanks.
