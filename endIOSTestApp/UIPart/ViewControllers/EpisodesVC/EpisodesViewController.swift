//
//  EpisodesViewController.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

class EpisodesViewController: BaseCollectionViewController {

    internal var filterClosure : ((EpisodeModel?) -> Void)?
    internal var episodesID: [String] = []
    internal var loadedEpisodes:[EpisodeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.loadEpisodes()
    }
    
    public func setupWithEpisodes(episodes: [String] ,closure: ((EpisodeModel?)->Void)?) {
        self.filterClosure = closure
        self.episodesID = episodes
    }
    
    internal func setupUI(){
        
        self.prepareCollectionView()
        self.prepareActivityView()
        self.prepareCancelButton()
    }
    
    override func cancelButtonPressed () {
        
        if let closure = self.filterClosure {
            closure(nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// overrided methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell: CommonCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let episode = self.loadedEpisodes[indexPath.row]

        cell.update(with: episode.name, imageUrl: nil, isFavorite: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let episode = self.loadedEpisodes[indexPath.row]
        if let closure = self.filterClosure {
            closure(episode)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
