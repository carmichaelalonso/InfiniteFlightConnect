//
//  ConnectCommands.swift
//  LiveFlight
//
//  Created by Cameron Carmichael Alonso on 10/08/2018.
//  Copyright © 2018 LiveFlight. All rights reserved.
//

public enum ConnectCommand:String {
   
    // Autopilot
    case SetHeading = "Commands.Autopilot.SetHeading"
    case SetAltitude = "Commands.Autopilot.SetAltitude"
    case SetVS = "Commands.Autopilot.SetVS"
    case SetSpeed = "Commands.Autopilot.SetSpeed"
    case AutopilotState = "Autopilot.GetState"
    
    // Cameras
    case PreviousCamera = "Commands.PrevCamera"
    case NextCamera = "Commands.NextCamera"
    
    // Status
    case Status = "InfiniteFlight.GetStatus"

    // Aircraft
    case AircraftState = "Airplane.GetState"
    case AircraftInfo = "Airplane.GetInfo"
    
}

