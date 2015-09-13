//
//  TrieFromFile.m
//  TrieFromFile
//
//  Created by Chris Nevin on 13/09/2015.
//  Copyright © 2015 CJNevin. All rights reserved.
//

#import "TrieFromFile.h"

@implementation TrieFromFile

+ (NSDictionary *)trieFromListAtPath:(NSString *)filePath
                       terminatorKey:(NSString *)terminatorKey
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    FILE *file = fopen([filePath UTF8String], "r");
    while (!feof(file)) {
        NSString *line = [self readNextLineOfFile:file];
        NSString *word = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSMutableDictionary *letterDict = dict;
        for (NSInteger i = 0; i < word.length; i++) {
            NSString *letter = [word substringWithRange:NSMakeRange(i, 1)];
            if (![[letterDict allKeys] containsObject:letter]) {
                letterDict[letter] = [[NSMutableDictionary alloc] init];
            }
            letterDict = letterDict[letter];
            if (i == word.length - 1) {
                [letterDict setObject:terminatorKey forKey:terminatorKey];
            }
        }
    }
    fclose(file);
    return dict;
}

+ (NSDictionary *)trieFromDelimitedListAtPath:(NSString *)filePath
                                    delimiter:(NSString *)delimiter
                                definitionKey:(NSString *)definitionKey
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    FILE *file = fopen([filePath UTF8String], "r");
    while (!feof(file)) {
        NSString *line = [self readNextLineOfFile:file];
        NSString *word = [line componentsSeparatedByString:delimiter][0];
        NSMutableDictionary *letterDict = dict;
        for (NSInteger i = 0; i < word.length; i++) {
            NSString *letter = [word substringWithRange:NSMakeRange(i, 1)];
            if (![[letterDict allKeys] containsObject:letter]) {
                letterDict[letter] = [[NSMutableDictionary alloc] init];
            }
            letterDict = letterDict[letter];
            if (i == word.length - 1) {
                [letterDict setObject:[[line substringFromIndex:word.length] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
                               forKey:definitionKey];
            }
        }
    }
    fclose(file);
    return dict;
}

+ (NSString*)readNextLineOfFile:(FILE*)file {
    NSUInteger bufferSize = 4096;
    char buffer[bufferSize];
    NSMutableString *result = [NSMutableString stringWithCapacity:bufferSize];
    int charsRead = 0;
    do {
        // Look for end of line
        if (fscanf(file, "%4095[^\n]%n%*c", buffer, &charsRead) == 1) {
            [result appendFormat:@"%s", buffer];
        } else {
            break;
        }
    } while (charsRead == bufferSize - 1);
    return result;
}

@end
