//
//  EpisodeLoader.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// EpisodeLoader - A class for working with data that relates to a Character's Episodes. In the future, it is possible to extend this class with a database connection or expand methods for working with API
private class EpisodeLoader: BaseDataLoader, ServerSettingsProtocol {

    static let shared = EpisodeLoader()
       
    private override init() { }
    
    /// Call web api to get all Episode with ids [1,2,3] parameter. Refer to https://rickandmortyapi.com/documentation/#get-multiple-episodes
    internal func getEpisodesFromAPI (episodes: [String], completion: @escaping ([EpisodeModel]?, Error?) -> Void) {
        
        let stringRepresentation = episodes.joined(separator:",")
        
        let url = self.createURLFromParameters(method: .episode, parameters: (episodes.count == 0 ? [:] : ["":stringRepresentation]))
        
        self.loadDataFromAPI(type: RootEpisodeResponseInfoModel.self, url: url, method: .GET) { (response, error) in
            
            if let episodes = response?.results {
                completion (episodes, nil)
            }else {
                completion (nil, error)
            }
        }
    }
    
    /// prepare list of episodes id from the characters
    internal func getListOfEpisodesFromListOfCharacters(characters: [CharacterModel], completion: @escaping ([String]?) -> Void) {
        
        var objectsSet:Set<String> = []
        for character in characters {
            objectsSet.formUnion(character.episode ?? [])
        }
        
        let sorted = objectsSet.array.sorted {$0.localizedStandardCompare($1) == .orderedAscending}
        
        var arrOfNumbers: [String] = []
        for episode in sorted {
        
            arrOfNumbers.append(episode.components(separatedBy: "/").last ?? "")
        }
        
        completion (arrOfNumbers)
    }
}


protocol EpisodeLoaderProtocol {
    
    func loadEpisodesFromAPI (episodesID: [String], completion: @escaping ([EpisodeModel]?, Error?) -> Void)
    func getListOfEpisodesFromListOfCharacters(characters: [CharacterModel], completion: @escaping ( [String]?) -> Void)
}

extension EpisodeLoaderProtocol {
   
    func loadEpisodesFromAPI (episodesID: [String], completion: @escaping ([EpisodeModel]?, Error?) -> Void) {
        return  EpisodeLoader.shared.getEpisodesFromAPI(episodes: episodesID, completion: completion)
    }
    
    func getListOfEpisodesFromListOfCharacters(characters: [CharacterModel], completion: @escaping ([String]?) -> Void) {
        
        return EpisodeLoader.shared.getListOfEpisodesFromListOfCharacters(characters: characters, completion: completion)
    }
}
