//
//  AircraftInfo.swift
//  LiveFlight
//
//  Created by Cameron Carmichael Alonso on 11/08/2018.
//  Copyright © 2018 LiveFlight. All rights reserved.
//

import Foundation

public struct AircraftInfo: Codable {
    let result: Int
    let type: String
    let engineCount: Int
    let flapsConfiguration: [FlapsConfiguration]
    let fuelTankCount: Int
    let hasAutopilot: Bool
    let name: String
    let spoilerType: SpoilerType
    
    enum SpoilerType: Int, Codable {
        case unknown
        case none = 1
        case flight = 2
        case arm = 4
        
        init(value: Int) {
            if let type = SpoilerType(rawValue: value) {
                self = type
            } else {
                self = .unknown
            }
        }
        
    }
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case type = "Type"
        case engineCount = "EngineCount"
        case flapsConfiguration = "FlapsConfiguration"
        case fuelTankCount = "FuelTankCount"
        case hasAutopilot = "HasAutopilot"
        case name = "Name"
        case spoilerType = "SpoilerType"
    }
}

struct FlapsConfiguration: Codable {
    let flapsAngle: Float
    let name, shortName: String
    let slatsAngle: Float
    
    enum CodingKeys: String, CodingKey {
        case flapsAngle = "FlapsAngle"
        case name = "Name"
        case shortName = "ShortName"
        case slatsAngle = "SlatsAngle"
    }
}
