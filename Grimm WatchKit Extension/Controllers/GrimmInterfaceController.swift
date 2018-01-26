//
//  InterfaceController.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 9/25/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit
import Foundation

/// Delegrate protocol to communicate UI events and processes from
/// `GrimmInterfaceController`.
protocol GrimmEventDelegate {
    
    /// Called when an action is selected by the user.
    ///
    /// - Parameters:
    ///   - selection: The selection choosen.
    ///   - sender: The caller of the delegate method.
    func onAction(_ selection: Action, sender: GrimmInterfaceController)
    
    /// Called when the user selects to view their items.
    ///
    /// - Parameter sender: The caller of the delegate method.
    func onViewItems(controllerName: String, sender: GrimmInterfaceController)
    
    /// Called when an instance of the game starts for the first time.
    ///
    /// - Parameter sender: The caller of the delegate method.
    func onGameStart(sender: GrimmInterfaceController)
}

/// The end-all be-all of controllers in Grimm.
///
/// Handles game flow, triggers delegates, table manipulation, and interface
/// management.
class GrimmInterfaceController: WKInterfaceController {
    
    /// The maximum amount of actions allowed.
    let actionLimit = 10
    
    // Outlets & Actions
    @IBOutlet var eventTable: WKInterfaceTable!
    @IBOutlet var actionTable: WKInterfaceTable!
    @IBAction func onItemPress() {
        delegate?.onViewItems(controllerName: "ItemInterfaceController", sender: self)
    }
    
    /// List of events.
    private(set) var eventHistory: [Expression]!  // only get allowed publicly
    
    /// List of actions.
    ///
    /// This property can be used freely and uses observers to maintain
    /// itself as well as the action table.
    var actions: [Action]! {  // observer does the work
        didSet(oldActions) {
            if actions.count > actionLimit {
                actions = oldActions  // revert
            }
            else {
                loadActionTable()
            }
        }
    }
    
    // Variables
    var delegate: GrimmEventDelegate?
    
    /// Constructs a `GrimmInterfaceController` instance with a blank
    /// event history and actions list.
    override init() {
        super.init()
        
        // Start blank
        eventHistory = []
        actions = []
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        delegate = PlayerController()
        loadEventTable()
        loadActionTable()
        delegate?.onGameStart(sender: self)
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        super.table(table, didSelectRowAt: rowIndex)
        
        if table === actionTable {
            delegate?.onAction(actions[rowIndex], sender: self)
            eventTable.scrollToRow(at: eventTable.numberOfRows - 1)
        }
    }
    
    override func interfaceOffsetDidScrollToTop() {
        // Do old event loading here
    }
    
    /// Load current event data into the UI event table.
    func loadEventTable() {
        eventTable.setNumberOfRows(eventHistory.count, withRowType: "Event")

        // Populate eventTable
        for (index, event) in eventHistory.enumerated() {
            let row = eventTable.rowController(at: index) as! EventRow
            row.tailorRow(forExpressionOf: event)
        }
    }

    /// Load current action data into the UI action table
    func loadActionTable() {
        actionTable.setNumberOfRows(actions.count, withRowType: "Action")

        // Populate actionTable
        for (index, action) in actions.enumerated() {
            let row = actionTable.rowController(at: index) as! ActionRow
            row.actionLabel.setText(action.name)
        }
    }
    
    /// Outputs given event to the list of events.
    ///
    /// - Parameters:
    ///   - speech: The text of the event.
    ///   - source: The source of the event.
    func deliverEvent(_ speech: String, from source: Expression.SpeechSource) {
        let newEvent = Expression(source: source, speech: speech)
        eventHistory.append(newEvent)
        
        eventTable.insertRows(at: [eventTable.numberOfRows], withRowType: "Event")
        let row = eventTable.rowController(at: eventTable.numberOfRows - 1) as! EventRow
        row.tailorRow(forExpressionOf: newEvent)
    }
    
    /// Outputs action's effect text to the list of events.
    ///
    /// - Parameter speech: The action's past-tense text.
    func deliverAction(_ speech: String) {
        let newEvent = Expression(source: .narrator, speech: speech)
        eventHistory[eventHistory.count - 1] = newEvent
        
        eventTable.replaceRows(at: [eventTable.numberOfRows - 1], withRowType: "Event")
        let row = eventTable.rowController(at: eventTable.numberOfRows - 1) as! EventRow
        row.tailorRow(forExpressionOf: newEvent)
    }
    
    /// Offer available actions the player.
    ///
    /// - Note: Has the same result as modifiying `actions` property directly.
    /// - Parameter actions: List of actions to offer.
    func offerAvail(actions: [Action]) {
        self.actions = actions  // observer takes care of the rest
    }
}
