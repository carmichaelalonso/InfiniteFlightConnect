//
//  Status.swift
//  LiveFlight
//
//  Created by Cameron Carmichael Alonso on 11/08/2018.
//  Copyright © 2018 LiveFlight. All rights reserved.
//

import Foundation

public struct Status: Codable {
    let result: Int
    let appState:GameState?
    let type, apiVersion, appVersion: String
    let deviceName: String
    let displayHeight, displayWidth: Float
    let loggedInUser, playMode: String?
    
    enum GameState:String, Codable {
        case unknown = "Unknown", loading = "Loading", playing = "Playing", mainMenu = "MainMenu", unloading = "Unloading"
    }
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case type = "Type"
        case apiVersion = "ApiVersion"
        case appState = "AppState"
        case appVersion = "AppVersion"
        case deviceName = "DeviceName"
        case displayHeight = "DisplayHeight"
        case displayWidth = "DisplayWidth"
        case loggedInUser = "LoggedInUser"
        case playMode = "PlayMode"
    }
}
