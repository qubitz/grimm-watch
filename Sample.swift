//
//  Dialogue.swift
//  Grimm WatchKit Extension
//
//  Created by Tyler Goffinet on 9/26/17.
//  Copyright © 2017 Tyler Goffinet. All rights reserved.
//

import WatchKit

class EventRow: NSObject {

    // Row colors
    let dialogueColor  = #colorLiteral(red: 0.4745098039, green: 0.3921568627, blue: 0, alpha: 1)
    let responseColor  = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
    let narrationColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    @IBOutlet var group: WKInterfaceGroup!
    @IBOutlet var speechLabel: WKInterfaceLabel!
    
    func tailorRow(forExpressionOf expr: Expression) {
        var richSpeech: NSAttributedString
        
        switch expr.source {
        case .narrator:
            richSpeech = getAligned(expr.speech, withAlignment: .left)
            group.setBackgroundColor(narrationColor)
        case .you:
            richSpeech = getAligned(expr.speech, withAlignment: .right)
            group.setBackgroundColor(responseColor)
        case .them:
            richSpeech = getAligned(expr.speech, withAlignment: .left)
            group.setBackgroundColor(dialogueColor)
        }
        
        speechLabel.setAttributedText(richSpeech)
    }
    
    func getAligned(_ text: String, withAlignment alignment: NSTextAlignment) -> NSAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = alignment
        
        let richText = NSAttributedString(string: text,
                                          attributes: [NSAttributedStringKey.paragraphStyle: paraStyle])
        return richText
    }
}
