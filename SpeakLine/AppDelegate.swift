//
//  AppDelegate.swift
//  SpeakLine
//
//  Created by Trang Mai on 10/26/19.
//  Copyright © 2019 Trang Mai. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create a window controller with a XIB file of the same name
        let mainWindowController = MainWindowController()
        // Put the window of window controller on main screen
        mainWindowController.showWindow(self)
        
        //Set the property to point to the window controller
        self.mainWindowController = mainWindowController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

