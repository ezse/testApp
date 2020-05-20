//
//  ViewController.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

class CharactersViewController: BaseCollectionViewController {

    internal var loadedCharacters:[CharacterModel] = []
    internal var filteredCharacters:[CharacterModel] = []
    internal var loadedInfo: ResponseInfoModel?
    internal var currentPage = 0
    internal var withFilter = false
    internal var filterView: FilterView!
    internal var refresher:UIRefreshControl!
    internal var clearButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.addRefresherToCollectionView()
        self.resetPageAndLoadData()
     }
    
    internal func setupUI(){
        
        self.prepareCollectionView()
        self.prepareActivityView()
        self.prepareFilterView()
        self.prepareNavigationClearButton()
    }
    
    internal func addRefresherToCollectionView() {
       
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = .lightGray
        self.refresher.addTarget(self, action: #selector(resetPageAndLoadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }
    
    internal func prepareNavigationClearButton () {
        
        self.clearButton = UIBarButtonItem(title: "Clear filters", style: .plain, target: self, action: #selector(clearAllFilters))
        navigationItem.rightBarButtonItems = [self.clearButton]
    }
    
    internal func prepareFilterView() {
        
        let filterViewHeight: CGFloat = 100
        self.collectionView.frame.size.height -= filterViewHeight
        self.filterView = FilterView.init(frame: CGRect.init(x: 0, y: self.view.frame.size.height - filterViewHeight, width: self.view.frame.size.width, height: filterViewHeight))
        
        weak var weakSelf = self
        self.filterView.addClosure { (type) in
            switch type {
            case .episode:
                weakSelf?.navigateToEpisodesVC()
            case .location:
                weakSelf?.navigateToLocationsVC()
            }
        }
        self.view.addSubview(self.filterView)
    }
    
    
    /// overrided methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell: CommonCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let character = self.withFilter ? self.filteredCharacters[indexPath.item] : self.loadedCharacters[indexPath.item]

        cell.update(with: character.name, imageUrl: character.image, isFavorite: character.isFavorite ?? false)
        
        return cell
    }
    
    /// favorite in-memory stored characters. doesnt really works with filtered objects.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CommonCollectionViewCell {
            
            var character = self.withFilter ? self.filteredCharacters[indexPath.item] : self.loadedCharacters[indexPath.item]
            character.isFavorite = !(character.isFavorite ?? false)
            cell.favorite(isFavorite: character.isFavorite ?? false)
            
            if self.withFilter {
                self.filteredCharacters[indexPath.item] = character
            }
            self.loadedCharacters[indexPath.item] = character
        }
    }
    
    override func updateNextSet() {
            
        if !withFilter {
            self.overridedUpdateNextSet()
        }
    }
}
