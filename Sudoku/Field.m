//
//  Field.m
//  Sudoku
//
//  Created by Jakub Vallo on 19/02/17.
//  Copyright © 2017 Jakub Vallo. All rights reserved.
//

#import "Field.h"

@implementation Field

-(id)initWithValue:(NSUInteger)value andWithPosition:(NSString *)pos{
    self = [super init];
    if (self) {
        self.value = value;
        self.position = pos;
        if (value == 0) {
            self.possible = [[NSMutableArray alloc] initWithCapacity:9];
            for (int i = 1; i < 10; i++) {
                [self.possible addObject:[NSNumber numberWithInt:i]];
            }
        }
    }
    
    return self;
}

@end
