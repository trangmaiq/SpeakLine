//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Trang Mai on 10/26/19.
//  Copyright © 2019 Trang Mai. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    let speechSynth = NSSpeechSynthesizer()
    
    var isStarted: Bool = false {
        // updateButtons() will be called whenever the value of isStarted is changed
        didSet {
            updateButtons()
        }
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        updateButtons()
    }
    
    override var windowNibName: NSNib.Name {
        return "MainWindowController"
    }
    
    // MARK: - Action method
    @IBAction func speak(sender: NSButton) {
        // Get typed-in text as a string
        let str = textField.stringValue
        if str.isEmpty {
            print("string from \(textField) is empty")
        } else {
            speechSynth.startSpeaking(str)
            isStarted = true
        }
    }
    
    @IBAction func stop(sender: NSButton) {
        speechSynth.stopSpeaking()
        isStarted = false
    }
    
    private func updateButtons() {
        if isStarted {
            speakButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            speakButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
    
}
