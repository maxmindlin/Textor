//
//  ViewController.swift
//  Textor
//
//  Created by Max Mindlin on 2/13/20.
//  Copyright © 2020 Max Mindlin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {
    @IBOutlet var input: NSTextField!
    @IBOutlet var type: NSSegmentedControl!
    @IBOutlet var output: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typeChanged(self)
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func typeChanged(_ sender: Any) {
        switch type.selectedSegment {
        case 0:
            output.stringValue = standard(input.stringValue)
        default:
            let cstr = memeify(input.stringValue)!
            output.stringValue = String.init(cString: cstr)
            free_string(cstr)
        }
    }
    
    func controlTextDidChange(_ obj: Notification) {
        typeChanged(self)
    }
    
    @IBAction func copyToPasteboard(_ sender: Any) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(output.stringValue, forType: .string)
    }
    
    func standard(_ input: String) -> String {
        return "Standard: " + input
    }
}

