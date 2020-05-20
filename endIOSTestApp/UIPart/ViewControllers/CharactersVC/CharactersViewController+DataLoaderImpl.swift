//
//  CharactersViewController+DataLoaderImpl.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// Connect to data loaders
extension CharactersViewController: CharactersLoaderProtocol {
    
    func loadCharacters(){
        
        weak var weakSelf = self
        
        self.activityView.startAnimating()
        
        self.loadCharactersFromAPI(page: self.currentPage) { (characters, loadedInfo, error) in
            
            if let characters = characters {
                
                weakSelf?.loadedInfo = loadedInfo
                weakSelf?.loadedCharacters.append(contentsOf: characters)
                weakSelf?.updateCollectionView()
            }
            weakSelf?.activityView.stopAnimating()
            weakSelf?.refresher.endRefreshing()
        }
    }
    
    @objc func resetPageAndLoadData() {
        
        self.refresher.beginRefreshing()
        self.withFilter = false
        self.currentPage = 0
        self.loadedCharacters = []
        self.filteredCharacters = []
        self.loadCharacters()
    }
    
    func overridedUpdateNextSet(){
         
        /// Could be modified: we can use info.nextPage for this.
        if let pages = self.loadedInfo?.pages {
            let next = self.currentPage + 1
            if pages >= next {
                
                self.currentPage = next
                self.loadCharacters()
            }
        }
    }
    
    func updateCollectionView() {
        
        self.dataSourceCount = self.withFilter ? self.filteredCharacters.count : self.loadedCharacters.count
        self.collectionView.reloadData()
        self.clearButton.isEnabled = self.withFilter ? true : false
    }
}
