//
//  BaseDataLoader.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

public enum HTTPMethod: String {
    
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

internal class BaseDataLoader{

    /// Base method. If you want to create another "methods" for getting the data - just inherit and call this method. Method will return T object.
    func loadDataFromAPI <T: Decodable>(type: T.Type, url: URL, method: HTTPMethod, completion: @escaping (T?, Error?) -> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,                            // is there data
                let response = response as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(nil, error)
                    return
            }

            let mappedObject = try! JSONDecoder().decode(type, from: data)
            
            DispatchQueue.main.async {
                completion(mappedObject, nil)
            }
        }
        task.resume()
    }
}
