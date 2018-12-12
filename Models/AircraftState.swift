//
//  AircraftState.swift
//  LiveFlight
//
//  Created by Cameron Carmichael Alonso on 11/08/2018.
//  Copyright © 2018 LiveFlight. All rights reserved.
//

import Foundation

public struct AircraftState: Codable {
    let result: Int
    let type: String
    let accelerationX, accelerationY, accelerationZ, altitudeAGL, altitudeMSL: Float
    let approachAirportICAO: JSONNull?
    let approachDistance, approachHorizontalAngle: Float
    let approachRunway: JSONNull?
    let approachVerticalAngle, bank, courseTrue, flapsIndex: Float
    let gForce, groundSpeed, groundSpeedKts: Float
    let gearState: GearState
    let headingMagnetic, headingTrue, indicatedAirspeed, indicatedAirspeedKts: Float
    let isAutopilotOn, isBraking, isCrashed, isLanded: Bool
    let isOnGround, isOnRunway, isOverLandingWeight, isOverTakeoffWeight: Bool
    let isPushbackActive: Bool
    let location: Location
    let machNumber, magneticDeviation, pitch: Float
    let reverseThrustState: Bool
    let sideForce, stallProximity: Float
    let spoilersPosition: SpoilerState
    let stallWarning, stalling: Bool
    let trueAirspeed, velocity, verticalSpeed, weight: Float
    let weightPercentage: Float
    
    enum GearState: Int, Codable {
        case unknown, down, up, moving, movingDown, movingUp
    }
    
    enum SpoilerState: Int, Codable {
        case retracted, flight, full
    }
    
    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case type = "Type"
        case accelerationX = "AccelerationX"
        case accelerationY = "AccelerationY"
        case accelerationZ = "AccelerationZ"
        case altitudeAGL = "AltitudeAGL"
        case altitudeMSL = "AltitudeMSL"
        case approachAirportICAO = "ApproachAirportICAO"
        case approachDistance = "ApproachDistance"
        case approachHorizontalAngle = "ApproachHorizontalAngle"
        case approachRunway = "ApproachRunway"
        case approachVerticalAngle = "ApproachVerticalAngle"
        case bank = "Bank"
        case courseTrue = "CourseTrue"
        case flapsIndex = "FlapsIndex"
        case gForce = "GForce"
        case gearState = "GearState"
        case groundSpeed = "GroundSpeed"
        case groundSpeedKts = "GroundSpeedKts"
        case headingMagnetic = "HeadingMagnetic"
        case headingTrue = "HeadingTrue"
        case indicatedAirspeed = "IndicatedAirspeed"
        case indicatedAirspeedKts = "IndicatedAirspeedKts"
        case isAutopilotOn = "IsAutopilotOn"
        case isBraking = "IsBraking"
        case isCrashed = "IsCrashed"
        case isLanded = "IsLanded"
        case isOnGround = "IsOnGround"
        case isOnRunway = "IsOnRunway"
        case isOverLandingWeight = "IsOverLandingWeight"
        case isOverTakeoffWeight = "IsOverTakeoffWeight"
        case isPushbackActive = "IsPushbackActive"
        case location = "Location"
        case machNumber = "MachNumber"
        case magneticDeviation = "MagneticDeviation"
        case pitch = "Pitch"
        case reverseThrustState = "ReverseThrustState"
        case sideForce = "SideForce"
        case spoilersPosition = "SpoilersPosition"
        case stallProximity = "StallProximity"
        case stallWarning = "StallWarning"
        case stalling = "Stalling"
        case trueAirspeed = "TrueAirspeed"
        case velocity = "Velocity"
        case verticalSpeed = "VerticalSpeed"
        case weight = "Weight"
        case weightPercentage = "WeightPercentage"
    }
}

struct Location: Codable {
    let altitudeLight, latitude, longitude: Float
    
    enum CodingKeys: String, CodingKey {
        case altitudeLight = "AltitudeLight"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
