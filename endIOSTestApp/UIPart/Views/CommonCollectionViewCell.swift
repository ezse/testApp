//
//  CharacterCell.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// Base collection view cell with Image and Label inside. 
class CommonCollectionViewCell: UICollectionViewCell, ReusableView {
    
    // MARK: Properties
    var imageView: UIImageView!
    var favoriteImageView: UIImageView!
    var nameLabel: UILabel!
    internal var isFavorite: Bool?
  
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView(frame: self.bounds)
        imageView.image = nil
        //customise imageview
        imageView?.backgroundColor = UIColor.lightGray
        contentView.addSubview(imageView!)
        
        favoriteImageView = UIImageView(frame: CGRect(x: self.frame.size.width - 50, y: 10, width: 30, height: 30))
        favoriteImageView.image = nil
        contentView.addSubview(favoriteImageView!)
        
        nameLabel = UILabel(frame: CGRect(x: 20, y: 20, width: self.bounds.width - 20, height: 80))
        nameLabel.numberOfLines = 3
        contentView.addSubview(nameLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
    
    func favorite(isFavorite: Bool?) {
        
        if let isFavorite = isFavorite {
            self.favoriteImageView.isHidden = false
            self.isFavorite = isFavorite
            self.favoriteImageView.image = isFavorite ? UIImage.init(named: "marked_icon") : UIImage.init(named: "not_marked_icon")
        }
        else {
            self.favoriteImageView.isHidden = true
        }
    }
  
    /// Configures the cell for display the `UIImage`.
    ///
    /// - Parameter image: The `UIImage` to display or nil.
    func update (with name: String?, imageUrl: String?, isFavorite: Bool?) {
        
        self.imageView.image = nil
        
        self.nameLabel.text = name
        
        if let imageURL = imageUrl {
            self.nameLabel.textColor = .white
            self.imageView.loadImage(fromURL: imageURL)
        }else {
            self.nameLabel.textColor = .black
        }
        self.favorite(isFavorite: isFavorite)
    }
}

