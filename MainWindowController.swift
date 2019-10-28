//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Trang Mai on 10/26/19.
//  Copyright © 2019 Trang Mai. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate {
    
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
    
    let voices = NSSpeechSynthesizer.availableVoices

    override func windowDidLoad() {
        super.windowDidLoad()
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        updateButtons()
        
        // Set the delegate property of speech synthesizer to the MainWindowController
        // Note that NSSpeechSynthesizer's delegate is not defined as a strong reference. This is true of all delegate properties and
        // prevents a strong reference cycle from occuring between the delegate and object with the delegate.
        speechSynth.delegate = self
    }
    
    override var windowNibName: NSNib.Name {
        return "MainWindowController"
    }
    
    // MARK: - Action method
    @IBAction func speak(sender: NSButton) {
        // Get typed-in text as a string
        let str = textField.stringValue
        if str.isEmpty {
            print("string from \(String(describing: textField)) is empty")
        } else {
            speechSynth.startSpeaking(str)
            isStarted = true
        }
    }
    
    @IBAction func stop(sender: NSButton) {
        speechSynth.stopSpeaking()
    }
    
    // MARK: - NSWindowDelegate
    func windowShouldClose(_ sender: NSWindow) -> Bool {
        return !isStarted
    }
    
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("finishedSpeaking = \(finishedSpeaking)")
    }
    
    
    func updateButtons() {
        if isStarted {
            speakButton.isEnabled = false
            stopButton.isEnabled = true
        } else {
            speakButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
}
