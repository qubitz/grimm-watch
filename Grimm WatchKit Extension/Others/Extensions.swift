//
//  Extensions.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/24/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation
import WatchKit

extension String {
    
    /// Replaces the sequence of characters between the given indexed seperator
    /// and the index + 1 seperator with the new content.
    ///
    /// If the `index` parameter is zero, the replacement will begin from the
    /// front.
    ///
    ///     var str = "This is a sentence."
    ///     replace(word: 0, seperatedBy: " ", with: "Where")
    ///     print(str) // Prints "Where is a sentence"
    ///
    /// - Parameters:
    ///   - index: Seperator index to start replacing from.
    ///   - seperator: A string matching the seperator.
    ///   - content: The content that will replace the sequence of characters.
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
}

extension WKInterfaceTable {
    
    /// Resets with the row indexes with the specificed row type.
    ///
    /// - Parameters:
    ///   - rows: The rows to be reset.
    ///   - rowType: The type of row to reset all indexes with.
    public func resetRows(at rows: IndexSet, withRowType rowType: String) {
        removeRows(at: rows)
        insertRows(at: rows, withRowType: rowType)
    }
}
