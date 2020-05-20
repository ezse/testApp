//
//  BaseViewController.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// Base VC with collection view inside. Also BaseVC implements collection views delegates and datasources (Because we are using CharactersVC, EpisodesVC and LocationsVC as screens with collectionView inside)
class BaseCollectionViewController: UIViewController {

    /// Common properties
    internal var collectionView: UICollectionView!
    internal var dataSourceCount: Int = 0
    internal var activityView: UIActivityIndicatorView!
    
    /// Optional activity view init method.
    func prepareActivityView() {
     
        self.activityView = UIActivityIndicatorView.init()
        self.activityView.hidesWhenStopped = true
        self.view.addSubview(self.activityView)
        self.activityView.center = self.view.center
        self.activityView.stopAnimating()
    }
    
    /// Optional cancel button view init method.
    func prepareCancelButton () {
        
        let buttonHeight: CGFloat = 100
        let cancelButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: buttonHeight))
        cancelButton.center = self.view.center
        self.collectionView.frame.size.height -= buttonHeight
        cancelButton.frame.origin.y = self.view.frame.size.height - buttonHeight
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        self.view.addSubview(cancelButton)
    }
    
    /// will be overrided
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    func updateNextSet() {}
    @objc func cancelButtonPressed() {}
}


/// MARK: UICollectionViewDataSource
extension BaseCollectionViewController: UICollectionViewDataSource {

    func prepareCollectionView() {
       
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.frame = self.view.frame
        self.collectionView.center = self.view.center
        self.collectionView.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.defaultReuseIdentifier)
        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        self.view.addSubview(self.collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.dataSourceCount
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
         
         if indexPath.item == self.dataSourceCount - 1 && self.dataSourceCount > 4 {  //numberofitem count
             updateNextSet()
         }
     }
}

/// Collection view Flow layout
extension BaseCollectionViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

