//
//  LocationsViewController.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

class LocationsViewController: BaseCollectionViewController {

    internal var filterClosure : ((String?) -> Void)?
    internal var locations: [String]? = []
    
    public func addClosure(locations: [String]?, closure: ((String?)->Void)?) {
        self.filterClosure = closure
        self.locations = locations
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    override func cancelButtonPressed () {
        
        if let closure = self.filterClosure {
            closure(nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    internal func setupUI(){
        
        self.prepareCollectionView()
        self.prepareCancelButton()
        
        self.dataSourceCount = self.locations?.count ?? 0
        self.collectionView.reloadData()
    }
    
    
    /// overrided methods
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell: CommonCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        let location = self.locations?[indexPath.row]

        cell.update(with: location, imageUrl: nil, isFavorite: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let episode = self.locations?[indexPath.row]
        if let closure = self.filterClosure {
            closure(episode)
            self.navigationController?.popViewController(animated: true)
        }
    }
}
