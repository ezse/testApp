//
//  CharactersViewController+Navigation.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit


/// Handling navigation to the different VC
extension CharactersViewController: EpisodeLoaderProtocol, LocationLoaderProtocol {
    
    /// LocationVC part
    func navigateToLocationsVC() {
        
        self.performSegue(withIdentifier: SegueIdentifiers.toLocationsVC.rawValue, sender: self)
    }
    
    // Update displayed characters based on Location
    func updateDataForSelectedLocation(location: String?) {
        
        weak var weakSelf = self
        
        if let location = location {
         
            self.filterCharactersByLocation(characters: self.loadedCharacters, locationName: location) { (filteredCharacters) in
               
                if let filteredCharacters = filteredCharacters {
                    
                    weakSelf?.withFilter = true
                    weakSelf?.filteredCharacters = filteredCharacters
                    weakSelf?.updateCollectionView()
                }
            }
        }else {
            self.clearAllFilters()
        }
    }
    
    /// EpisodesVC part
    func navigateToEpisodesVC() {
        
        self.performSegue(withIdentifier: SegueIdentifiers.toEpisodesVC.rawValue, sender: self)
    }
    
    // Update displayed characters based on Episode.
    func updateDataForSelectedEpisode(episode: EpisodeModel?) {
        
        weak var weakSelf = self
        
        if let episode = episode, let episodeUrl = episode.url {
         
            self.filterCharactersByEpisode(characters: self.loadedCharacters, episodeUrl: episodeUrl) { (filteredCharacters) in
                
                if let filteredCharacters = filteredCharacters {
                    
                    weakSelf?.withFilter = true
                    weakSelf?.filteredCharacters = filteredCharacters
                    weakSelf?.updateCollectionView()
                }
            }
        }else {
            self.clearAllFilters()
        }
    }
    
    @objc func clearAllFilters() {
        self.withFilter = false
        self.filteredCharacters = []
        self.updateCollectionView()
    }
}


/// Segue stuff
extension CharactersViewController {
    
    // MARK: - Segue preparations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        weak var weakSelf = self
        
        if segue.identifier == SegueIdentifiers.toEpisodesVC.rawValue {
            if let episodesVC = segue.destination as? EpisodesViewController {
                
                self.getListOfEpisodesFromListOfCharacters(characters: self.loadedCharacters) { (sortedEpisodesIDs) in
                    
                    //Episodes will be loaded from the API based on sortedEpisodesIDs. Since current CharacterModel.episode does not contain the information we need
                    if let sortedEpisodesIDs = sortedEpisodesIDs {
                        episodesVC.setupWithEpisodes(episodes: sortedEpisodesIDs) { (episodeModel) in
                            weakSelf?.updateDataForSelectedEpisode(episode: episodeModel)
                        }
                    }
                }
            }
        }else if segue.identifier == SegueIdentifiers.toLocationsVC.rawValue {
            if let locationsVC = segue.destination as? LocationsViewController {
                
                self.getListOfLocationFromListOfCharacters(characters: self.loadedCharacters) { (sortedLocationsNames) in
                    
                    //Location will be loaded from the CharacterModel.location.
                    if let sortedLocationsNames = sortedLocationsNames {
                        locationsVC.addClosure(locations: sortedLocationsNames) { (selectedLocation) in
                            weakSelf?.updateDataForSelectedLocation(location: selectedLocation)
                        }
                    }
                }
            }
        }
    }
}
