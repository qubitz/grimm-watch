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
    public func replaceRows(at rows: IndexSet, withRowType rowType: String) {
        removeRows(at: rows)
        insertRows(at: rows, withRowType: rowType)
    }
}
