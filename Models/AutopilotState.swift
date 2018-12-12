//
//  AutopilotState.swift
//  LiveFlight
//
//  Created by Cameron Carmichael Alonso on 12/08/2018.
//  Copyright © 2018 LiveFlight. All rights reserved.
//

import Foundation

public struct AutopilotState: Codable {
    let result: Int
    let type: String
    let enableAltitude, enableApproach, enableBankAngle, enableClimbRate: Bool
    let enableHeading, enableLNav, enableSpeed: Bool
    let targetAltitude, targetClimbRate, targetHeading, targetSpeed: Int
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case type = "Type"
        case enableAltitude = "EnableAltitude"
        case enableApproach = "EnableApproach"
        case enableBankAngle = "EnableBankAngle"
        case enableClimbRate = "EnableClimbRate"
        case enableHeading = "EnableHeading"
        case enableLNav = "EnableLNav"
        case enableSpeed = "EnableSpeed"
        case targetAltitude = "TargetAltitude"
        case targetClimbRate = "TargetClimbRate"
        case targetHeading = "TargetHeading"
        case targetSpeed = "TargetSpeed"
    }
}
