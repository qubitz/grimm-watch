//
//  Movement.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 11/23/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation

/// An struct that holds information about a possible movement.
///
/// `Movement` comforms to the `Action` protocol and can either be in a
/// `Direction` OR to a `WorldLocation`. In-game the player can walk north or
//  south, for example, or teleport to a certain location to reduce redunant
/// directional walking.
///
/// - Important: Either `direction` or `destination`, but not both, will be
///              `nil` based on the constructor used.
struct Movement: Action {

    /// A list of movements in all directions.
    static let all = [Movement(.north),
                      Movement(.east),
                      Movement(.south),
                      Movement(.west),
                      Movement(.up),
                      Movement(.down)]

    // Conforms to `Action` protocol
    var name: String
    var completedName = ""

    /// The direction the movements goes toward.
    ///
    /// - Important: Either `direction` or `destination`, but not both, will be
    ///              `nil` based on the constructor used.
    var direction: Direction?
    
    /// The destination the movement teleports toward.
    ///
    /// - Important: Either `direction` or `destination`, but not both, will be
    ///              `nil` based on the constructor used.
    var destination: WorldLocation?

    /// Constructs a `Movement` instance in the direction given.
    ///
    /// Assigns the action name to "Move :direction:" and past action name to
    /// "Moved :direction:".
    ///
    /// - Important: `direction` will be set while `destination` will be left
    ///              `nil`.
    /// - Parameter direction: The direction in which to move towards.
    init(_ direction: Direction) {
        self.direction = direction
        self.destination = nil

        name = "Move " + direction.rawValue
        pastTenseVerb = "Moved"
    }

    /// Constructs a `Movement` instance to the place given.
    ///
    /// Assigns the action name to "Move :direction:" and past action name to
    /// "Moved :direction:".
    ///
    /// - Important: `destination` will be set while `direction` will be left
    ///              `nil`.
    /// - Parameter destination: The place of which to go/teleport.
    init(to destination: WorldLocation) {
        self.destination = destination
        self.direction = nil

        name = "Move to " + destination.areaIndex.description
        pastTenseVerb = "Moved"
    }
    
    /// Sets the action name of the movement and its past-tense form.
    ///
    /// - Parameters:
    ///   - name: The name of the movement. Should be in the form
    ///           ":verb: :subject:". For example: "Climb up ladder".
    ///   - pastVerb: The past-tense form of the verb. This value replaces the
    ///               first word of the `name` parameter.
    /// - Returns: `self`, the current instance.
    func with(name: String, pastVerb: String) -> Movement {
        var newMove = self
        newMove.name = name
        newMove.pastTenseVerb = pastVerb
        return newMove
    }
}

