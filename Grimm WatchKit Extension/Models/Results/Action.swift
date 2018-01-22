//
//  Action.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/1/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// A protocol that holds information about actions that can be chosen by
/// the player.
///
/// An action is listed after the lastest description of an `Area` is given as
/// long as it meets the requirements for that action to be possible.
/// In other words, if a action instance (an instance of a class that complies
/// with the `Action` protocol) exsists within the `Area`'s capabilites then
/// it can be listed as an action a player *could* take.
///
/// All actions must comply with the `Action` protocol. Because of this,
/// all functionality of `Action` must be relatable to all current and future
/// actions that comply with `Action`.
protocol Action: Codable {
    
    /// A display name describing the action that ***could*** be taken.
    ///
    /// This name will be displayed on the list of actions possible
    /// to take when in an `Area` and the action is deemed possible.
    ///
    /// - Requires: `name` to be in the form: `"<verb> <subject>"` where verb is
    ///             the first word in the sentence.
    ///
    /// - Attention: Sentence should be in future tense. For example,
    ///              "climb tree" is good. Not "climbing" or "climbed".
    ///
    /// - Note: It is the developer's responsibility to change `completedName`
    ///         if `name` is changed. There is no automated process to keep the
    ///         two names coherent.
    var name: String {get set}
    
    /// A display name describing the action that ***was*** choosen by the player.
    ///
    /// Should be in past tense (ex: "climbed tree". Not "climb" or "climbing".
    /// This name will be displayed after the action was taken by the player.
    ///
    /// - Note: It is the developer's responsibility to change `name`
    ///         if `completedName` is changed. There is no automated process
    ///         to keep the two names coherent.
    var completedName: String {get set}
}

extension Action {
    
    /// Computed property to maintain past tense in `completedName` without
    /// needless repetition of the rest of the sentence.
    ///
    /// - Getting: Returns the first word of `completedName`.
    /// - Setting: Changes the first word of `completedName` to the new value.
    ///
    ///     var act = ... // some instance of a class that complies with Action
    ///     action.name = action.completedName = "Walk up main street"
    ///     action.pastTenseVerb = "Walked"
    ///     print(action.completedName)  // prints "Walked up main street"
    ///     print(action.pastTenseVerb)  // prints "Walked"
    ///
    var pastTenseVerb: String! {
        get {
            // Grabs first word seperated by a space
            return completedName.components(separatedBy: " ").first!
        }
        set {
            // Uses custom `String` function to replace the first word
            completedName = name.replacing(word: 0, separatedBy: " ", with: newValue)
        }
    }
}
