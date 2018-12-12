//
//  ConnectAPI.swift
//  LiveFlight
//
//  Created by Cameron Carmichael Alonso on 10/08/2018.
//  Copyright © 2018 LiveFlight. All rights reserved.
//

import SwiftSocket

public class ConnectAPI: NSObject {
    
    var client:TCPClient?
    
    public var isConnected = false

    public func connectToInfiniteFlight(ip:String, completionHandler: @escaping (Bool) -> ()) {
        isConnected = false
        client = TCPClient(address: ip, port: Int32(10111))
        guard let c = client else {
            print("Failed to create client")
            return
        }
        
        print("Attempting to connect on \(c.address):\(c.port)")
        switch c.connect(timeout: 10) {
        case .success:
            print("Connected to Infinite Flight on \(c.address)")
            isConnected = true
            completionHandler(true)
        case .failure(let error):
            print("Failed to connect to client: \(error.localizedDescription)")
            client = nil
            completionHandler(false)
        }
    }
    
    public func closeConnection() {
        guard let c = client else {
            print("Can't close connection - client has not been initialised")
            return
        }
        
        c.close()
        isConnected = false
    }
    
    // CC: In LiveFlight for iOS, I pass a ConnectCommand object
    // However, it causes a crash here... call .rawValue on ConnectCommmand or just pass any String
    public func sendCommand(command:String) {
        let _ = self.sendCommand(command: command, parameters:[], expectsResponse: false)
    }
    
    public func sendCommandWithResponse(command:String) -> String {
        return self.sendCommand(command: command, parameters: [], expectsResponse: true)
    }
    
    public func sendCommand(command:String, parameter:String?) {
        let _ = self.sendCommand(command: command, parameters: prepareParams(parameter: parameter), expectsResponse: false)
    }
    
    public func sendCommandWithResponse(command:String, parameter:String?) -> String {
        return self.sendCommand(command: command, parameters: prepareParams(parameter: parameter), expectsResponse: true)
    }
    
    private func prepareParams(parameter:String?) -> [Any] {
        
        var params:[Any] = []
        if let param = parameter {
            
            let parameterName:String = "Parameter"
            let parameterString = "{\"Name\":\"\(parameterName)\",\"Value\":\"\(param)\"}"
            let dataWrapped = parameterString.data(using: .utf8)
            guard let data = dataWrapped else {
                print("Couldn't encode data correctly")
                return params
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            params = [json!]
            
        }
        
        return params
        
    }
    
    private func sendCommand(command:String, parameters:[Any], expectsResponse:Bool) -> String {
        
        guard let c = client else {
            return "Can't send command - client has not been initialised"
        }
        
        let arrayData: Data? = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        var arrayString: String? = nil
        if let aData = arrayData {
            arrayString = String(data: aData, encoding: .utf8)
        }
        // CC: scrappy... should ideally serialise
        let string = "{\"Command\":\"\(command)\",\"Parameters\":\(arrayString ?? "[]")}\n"
        print("Sending command: \(string)")
        
        let result = Data(referencing: ConnectBridge.prepareData(for: string))
        
        let commandResult = c.send(data: result)
        print("Command send result: \(commandResult.isSuccess)")
        switch commandResult {
        case .success:
            
            if (expectsResponse) {
                var lengthDataBytes = [UInt8]()
                while true {
                    if let data1 = c.read(4) {
                        lengthDataBytes = lengthDataBytes + data1
                        break
                    }
                }
                
                let length = UInt32(littleEndian: Data(bytes: lengthDataBytes).withUnsafeBytes { $0.pointee })
                if (length == 0) {
                    return "Response has no data"
                }
                
                guard let dataBytes = c.read(Int(length)) else {
                    return "Can't read response"
                }
                
                // CC: Decode to use objects, we just output string now
                // Make sure to return AnyObject? at method level
                /*if let response = decodeResponse(command: ConnectCommand(rawValue: command)!, response: Data(bytes: dataBytes)) {
                    return response
                }*/
                
                return String(data: Data(bytes: dataBytes), encoding: .utf8) ?? "unknown"
            }
            
            return "No response"
            
        case .failure(let error):
            return "Error writing command: \(error.localizedDescription)"
        }
        
    }
    
    private func decodeResponse(command:ConnectCommand, response:Data) -> AnyObject? {
        
        print("Raw response: \(String(data: response, encoding: .utf8) ?? "unknown")")
        
        switch command {
        
        case .AircraftState:
            
            return nil
            
        case .Status:
            do {
                let object =  try JSONDecoder().decode(Status.self, from: response)
                return object as AnyObject
            } catch let error {
                print("Status decode error: \(error)")
            }
            return nil
            
        case .AircraftInfo:
            do {
                let object =  try JSONDecoder().decode(AircraftInfo.self, from: response)
                return object as AnyObject
            } catch let error {
                print("Status decode error: \(error)")
            }
            return nil
            
        case .AutopilotState:
            do {
                let object =  try JSONDecoder().decode(AutopilotState.self, from: response)
                return object as AnyObject
            } catch let error {
                print("Autopilot state decode error: \(error)")
            }
            return nil
            
        default:
            let object = String(data: response, encoding: .utf8)
            return object as AnyObject
            
        }
        
    }
    
}
