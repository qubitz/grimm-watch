//
//  Action.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/1/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

protocol Action {
    var name: String! {get set}
    var completedName: String! {get set}
}
