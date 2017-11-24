//
//  Expression.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/21/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

struct Expression: Codable {
    enum SpeechSource: String, Codable {
        case narrator, you, them
    }
    
    let source: SpeechSource
    let speech: String
}
