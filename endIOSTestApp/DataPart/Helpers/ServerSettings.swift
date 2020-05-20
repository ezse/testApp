//
//  ServerSettings.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// Private general constants for the server connection. Could be moved into the external file (for different target's or hosts)
private struct Constants {

    struct APIDetails {
        static let APIScheme = "https"
        static let APIHost = "rickandmortyapi.com"
        static let APIPath = "/api/"
    }
}

public enum APIMethod: String {
    
    ///could be expanded
    case character = "character"
    case location = "location"
    case episode = "episode"
}

/// Final class with basic functions - generating fullUrl. Could be expanded in future
final private class ServerSettings  {

    static let shared = ServerSettings()
       
    private init() { }
    
    internal func createURLFromParameters(method: APIMethod, parameters: [String:Any]) -> URL {

        var components = URLComponents()
        components.scheme = Constants.APIDetails.APIScheme
        components.host   = Constants.APIDetails.APIHost
        components.path   = Constants.APIDetails.APIPath + "\(method)"
     
        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        return components.url!
    }
}


protocol ServerSettingsProtocol {
    
    func createURLFromParameters(method: APIMethod, parameters: [String:Any]) -> URL
}

extension ServerSettingsProtocol {
   
    func createURLFromParameters(method: APIMethod,parameters: [String:Any]) -> URL {
      
        return  ServerSettings.shared.createURLFromParameters(method: method, parameters: parameters)
    }
}
