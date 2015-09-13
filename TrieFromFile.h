//
//  TrieFromFile.h
//  TrieFromFile
//
//  Created by Chris Nevin on 13/09/2015.
//  Copyright © 2015 CJNevin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrieFromFile : NSObject

/** Create trie using words only, lines will be trimmed removing whitespace. 
 @param filePath: Path of file to read from.
 @param terminatorKey: Signifies the end of a word
 **/
+ (NSDictionary *)trieFromListAtPath:(NSString *)filePath
                       terminatorKey:(NSString *)terminatorKey;

/** Create trie using words and definitions with a delimiter, lines will be trimmed removing whitespace. 
 @param filePath: Path of file to read from.
 @param delimiter: Delimiter to split a word and definition on each line.
 @param definitionKey: Signifies the end of a word.
  **/
+ (NSDictionary *)trieFromDelimitedListAtPath:(NSString *)filePath
                                    delimiter:(NSString *)delimiter
                                definitionKey:(NSString *)definitionKey;

@end
