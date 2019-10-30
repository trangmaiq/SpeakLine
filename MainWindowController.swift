//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Trang Mai on 10/26/19.
//  Copyright © 2019 Trang Mai. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
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
        
        let defaultVoice = NSSpeechSynthesizer.defaultVoice
        if let defaultRow = voices.firstIndex(of: defaultVoice) {
            let indices = NSIndexSet(index: defaultRow)
            tableView.selectRowIndexes(indices as IndexSet, byExtendingSelection: false)
            tableView.scrollRowToVisible(defaultRow)
        }
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
    
    // MARK: - NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let voice = voices[row]
        let voiceName = voiceNameForIdentifier(identifier: voice)
        
        return voiceName
    }
    
    // MARK: - NSTableViewDelegate
    func tableViewSelectionDidChange(_ notification: Notification) {
        let row = tableView.selectedRow
        
        // Set the voice back to the default if the user has deselected all rows
        if row == -1 {
            speechSynth.setVoice(nil)
            return
        }
        
        let voice = voices[row]
        speechSynth.setVoice(voice)
    }
    
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("finishedSpeaking = \(finishedSpeaking)")
    }
    
    func voiceNameForIdentifier(identifier: NSSpeechSynthesizer.VoiceName) -> String? {
        let attributes = NSSpeechSynthesizer.attributes(forVoice: identifier)
        
        return attributes[NSSpeechSynthesizer.VoiceAttributeKey.name] as? String
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
