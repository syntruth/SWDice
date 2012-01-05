Objective-C basic library for Savage Worlds Dice. 

I have compiled this code in an iOS application and have tested it
to an extent, found and fixed a memory leak, and so far, so good.

Example of usage:

    // SWDie is a subclass of SWDice.
    SWDie  *die    = [SWDie getDie: D8];
    SWDice *custom = [SWDice withNumber:3 sides:4 mod:-2];

    SWRollResult *result = [die roll];

    NSLog(@"The %@ die roll was: %d", [SWDie getDieAsString:D8], result.total);
    NSLog(@"Roll tally: %@", [result.tally tallyAsString]);

    if (result.success) {
      NSLog(@"The roll was a success with %d raises.", result.raises);
    }
    else {
      NSLog(@"The roll failed.");
    }

    result = [custom roll];

    NSLog(@"The %@ die roll was: %d", custom.asString, result.total);
    NSLog(@"Roll tally: %@", [result.tally tallyAsString]);

Read the license before using! Thanks.
