//
//  EpisodesViewController+DataLoaderImpl.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

extension EpisodesViewController: EpisodeLoaderProtocol {
    
    func loadEpisodes() {
        
        weak var weakSelf = self
        
        self.activityView.startAnimating()
        
        self.loadEpisodesFromAPI(episodesID: self.episodesID) { (fullEpisodes, error) in
            
            if let fullEpisodes = fullEpisodes {
                
                weakSelf?.loadedEpisodes = fullEpisodes
                weakSelf?.dataSourceCount = fullEpisodes.count
                weakSelf?.collectionView.reloadData()
            }
            weakSelf?.activityView.stopAnimating()
        }
    }
}
