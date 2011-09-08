Objective-C basic library for Savage Worlds Dice. 

I have compiled this code in an iOS application and have tested it
to an extent, found and fixed a memory leak, and so far, so good.

Example of usage:

    /* Both the die and result objects are autoreleased 
       with these calls.
    */
    SWDice       *die    = [SWDice getDie: D8];
    SWRollResult *result = [die roll];

    NSLog(@"The %@ die roll was: %d", [SWDice getDieAsString:D8], result.total);
    NSLog(@"Roll tally: %@", [result.tally componentsJoinedByString:@", "]);

    if (result.success) {
      NSLog(@"The roll was a success with %d raises.", result.raises);
    }
    else {
      NSLog(@"The roll failed.");
    }


Read the license before using! Thanks.
