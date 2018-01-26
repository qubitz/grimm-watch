//
//  PlayerController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/29/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import Foundation
import WatchKit

/// Controls and handles all player actions.
class PlayerController {
    
    /// Thee grimm player entity
    let player = MapHandler.shared.player
    
    /// The current map being used.
    let map = MapHandler.shared.map
    
    /// Will execute the given player movement.
    ///
    /// - Parameter movement: The player movement action.
    func handle(movement: Movement) {
        if let dir = movement.direction {
            player.move(in: dir)
        }
        if let place = movement.destination {
            player.move(to: place)
        }
    }
    
    /// Returns a list of available actions in the player's area.
    ///
    /// - Returns: All movements possible in the player's area in the order
    ///            given from `area`'s `moves` property.
    func availableActions() -> [Action] {
        var availActions = [Action]()
        
        // Movement actions
        for move in player.area.moves {
            availActions.append(move)
        }
        
        // TODO: Other actions may follow
        
        return availActions
    }
}

extension PlayerController: GrimmEventDelegate {
    
    func onAction(_ selection: Action, sender: GrimmInterfaceController) {
        switch selection {
        case is Movement:
            handle(movement: selection as! Movement)
            
            sender.deliverAction(selection.completedName)
            sender.deliverEvent(player.area.description, from: .narrator)
            sender.actions = availableActions()
        default:
            break
        }
    }
    
    func onViewItems(controllerName: String, sender: GrimmInterfaceController) {
        sender.pushController(withName: controllerName,
                              context: (playerItems: player.inventory,
                                        groundItems: player.area.inventory,
                                        player: player))
    }
    
    func onGameStart(sender: GrimmInterfaceController) {
        sender.deliverEvent("Let me tell you the story of the child named Aedan...",
                            from: .narrator)
        sender.deliverEvent(player.area.description, from: .narrator)
        sender.actions = availableActions()
    }
}
