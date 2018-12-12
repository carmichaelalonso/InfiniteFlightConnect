//
//  ViewController.swift
//  InfiniteFlightConnect
//
//  Created by carmichaelalonso on 12/12/2018.
//  Copyright (c) 2018 carmichaelalonso. All rights reserved.
//

import Cocoa
import InfiniteFlightConnect

class ViewController: NSViewController {
    
    let connect = ConnectAPI()
    
    @IBOutlet weak var statusTextField: NSTextField!
    
    @IBOutlet weak var outputTextField: NSScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusTextField.stringValue = "Connecting..."
        log(value: "Connecting...")
        
        let ip = "192.168.0.101"
        connect.connectToInfiniteFlight(ip: ip) { (status) in
            if status {
                self.statusTextField.stringValue = "Connected"
                self.log(value: "Connected to \(ip)")
            } else {
                self.statusTextField.stringValue = "Not Connected"
                self.log(value: "Not connected")
            }
        }
    }
    
    @IBAction func getStatus(_ sender: Any) {
        if !connect.isConnected {
            print("Not connected")
            return
        }
        log(value: connect.sendCommandWithResponse(command: ConnectCommand.Status.rawValue))
    }
    
    @IBAction func getAirplaneState(_ sender: Any) {
        if !connect.isConnected {
            print("Not connected")
            return
        }
        log(value: connect.sendCommandWithResponse(command: ConnectCommand.AircraftState.rawValue))
    }
    
    @IBAction func getAirplaneInfo(_ sender: Any) {
        if !connect.isConnected {
            print("Not connected")
            return
        }
        log(value: connect.sendCommandWithResponse(command: ConnectCommand.AircraftInfo.rawValue))
    }
    
    @IBAction func prevCamera(_ sender: Any) {
        if !connect.isConnected {
            print("Not connected")
            return
        }
        connect.sendCommand(command: ConnectCommand.PreviousCamera.rawValue)
    }
    
    @IBAction func nextCamera(_ sender: Any) {
        if !connect.isConnected {
            print("Not connected")
            return
        }
        connect.sendCommand(command: ConnectCommand.NextCamera.rawValue)
    }
    
    func log(value:String) {
        outputTextField.documentView!.insertText("[\(DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .short))] \(value)\n")
        outputTextField.documentView!.scrollToEndOfDocument(self)
    }
    
}
