//
//  Extensions.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/24/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

extension String {
    mutating public func replace(word index: Int, separatedBy seperator: String, with content: String) {
        var words = self.components(separatedBy: seperator)
        words[index] = content
        self = words.joined(separator: seperator)
    }
    
    public func replacing(word index: Int, separatedBy seperator: String, with content: String) -> String {
        var phrase = self
        phrase.replace(word: index, separatedBy: seperator, with: content)
        return phrase
    }
    
//    func wordSubrange(of wordIndex: Int) -> Range<String.Index> {
//        var wordStartIndex, wordEndIndex: String.Index
//
//        // 1. Find the space in front of the nth word
//        if wordIndex == 0 {
//            wordStartIndex = self.startIndex
//        } else {
//            wordStartIndex = index(of: " ", ordinal: wordIndex)
//        }
//
//
//        // 2. Find the space after the nthword
//
//
//        return wordStartIndex..<wordEndIndex
//    }
//
//    func index(of content: String, ordinal number: Int) -> String.Index? {
//
//
//
//
////        var searchRange = self.startIndex..<self.endIndex
////
////        while let range = self.range(of: content, options: .caseInsensitive, range: searchRange) {
////            searchRange = range.upperBound..<searchRange.upperBound
////            indexes.append(range.lowerBound)
////        }
//    }
}
