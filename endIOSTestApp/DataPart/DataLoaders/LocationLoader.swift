//
//  LocationLoader.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// LocationLoader - A class for working with data that relates to a Character's Location. In the future, it is possible to extend this class with a database connection or expand methods for working with API
private class LocationLoader: BaseDataLoader {

    static let shared = LocationLoader()
       
    private override init() { }
  
    /// prepare list of locations from the characters.
    internal func getListOfLocationFromListOfCharacters(characters: [CharacterModel], completion: @escaping ([String]?) -> Void) {
        
        let objectSet = Set(characters.map { $0.location?.name ?? "" })
    
        completion (objectSet.array.sorted())
    }
}


protocol LocationLoaderProtocol {
    
    func getListOfLocationFromListOfCharacters(characters: [CharacterModel], completion: @escaping ([String]?) -> Void)
}

extension LocationLoaderProtocol {
   
    func getListOfLocationFromListOfCharacters(characters: [CharacterModel], completion: @escaping ([String]?) -> Void) {
        return  LocationLoader.shared.getListOfLocationFromListOfCharacters(characters: characters, completion: completion)
    }
}
