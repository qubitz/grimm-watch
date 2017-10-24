//
//  GrimmStoryController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 10/18/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit

class GrimmStoryController {
    static let sharedInstance = GrimmStoryController()
    
    let map = Map()
    
    func notifyActionSelect(of action: String, sender: GrimmInterfaceController) {
        
        switch action {
        case "Throw rock":
            sender.deliverEvent(withExpression: Expression(source: .narrator, speech: "You threw "))
        }
        
    }
}
