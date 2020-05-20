//
//  CharactersLoader.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// EpisodeLoader - A class for working with data that relates to a Character. In the future, it is possible to extend this class with a database connection or expand methods for working with API
private class CharactersLoader: BaseDataLoader, ServerSettingsProtocol {

    static let shared = CharactersLoader()
       
    private override init() { }
    
    /// Call web api to get all characters with 'page' parameter. Refer to https://rickandmortyapi.com/documentation/#get-all-characters
    internal func getCharactersFromAPI (page: Int, completion: @escaping ([CharacterModel]?, ResponseInfoModel?, Error?) -> Void) {
        
        let url = self.createURLFromParameters(method: .character, parameters: (page == 0 ? [:] : ["page":page]))
        
        self.loadDataFromAPI(type: RootCharacterResponseInfoModel.self, url: url, method: .GET) { (response, error) in
            
            if let characters = response?.results, let info = response?.info {
                completion (characters, info ,nil)
            }else {
                completion (nil, nil, error)
            }
        }
    }
    
    /// Filter characters by selected Location. Was done locally, since the current web api does not support filtering by location. Refer to https://rickandmortyapi.com/documentation/#filter-characters
    internal func filterCharactersByLocationLocally (characters: [CharacterModel], locationName: String, completion: @escaping ([CharacterModel]?) -> Void) {
        
        let foundArray = characters.filter( { return $0.location?.name == locationName } )
        completion( foundArray)
        
    }
    
    /// Filter characters by selected Episode. Was done locally, since the current web api does not support filtering by episode Refer to https://rickandmortyapi.com/documentation/#filter-characters
    internal func filterCharactersByEpisodeLocally (characters: [CharacterModel], episodeUrl: String, completion: @escaping ([CharacterModel]?) -> Void) {
        
        var foundCharacters: [CharacterModel] = []
        for character in characters {
            if let episodes = character.episode {
                if episodes.contains( episodeUrl) {
                    foundCharacters.append(character)
                }
            }
        }
    
        completion( foundCharacters)
    }
}


protocol CharactersLoaderProtocol {
    
    func loadCharactersFromAPI (page: Int, completion: @escaping ([CharacterModel]?, ResponseInfoModel?, Error?) -> Void)
    func filterCharactersByLocation (characters: [CharacterModel], locationName: String, completion: @escaping ([CharacterModel]?) -> Void)
    func filterCharactersByEpisode (characters: [CharacterModel], episodeUrl: String, completion: @escaping ([CharacterModel]?) -> Void)
}

extension CharactersLoaderProtocol {
   
    func loadCharactersFromAPI (page: Int, completion: @escaping ([CharacterModel]?, ResponseInfoModel?, Error?) -> Void) {
        return  CharactersLoader.shared.getCharactersFromAPI(page: page, completion: completion)
    }
    
    func filterCharactersByLocation (characters: [CharacterModel], locationName: String, completion: @escaping ([CharacterModel]?) -> Void) {
        return  CharactersLoader.shared.filterCharactersByLocationLocally(characters: characters, locationName: locationName, completion: completion)
    }
    
    func filterCharactersByEpisode (characters: [CharacterModel], episodeUrl: String, completion: @escaping ([CharacterModel]?) -> Void) {
        
        return CharactersLoader.shared.filterCharactersByEpisodeLocally(characters: characters, episodeUrl: episodeUrl, completion: completion)
    }
}
