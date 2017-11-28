//
//  Action.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/1/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

protocol Action: Codable {
    var name: String {get set}
//    var pastTenseVerb: String {get set}
    var completedName: String {get set}
}

extension Action {
    var pastTenseVerb: String! {
        get {
            return completedName.components(separatedBy: " ").first!
        }
        set {
            completedName = name.replacing(word: 0, separatedBy: " ", with: newValue)
        }
    }
}
