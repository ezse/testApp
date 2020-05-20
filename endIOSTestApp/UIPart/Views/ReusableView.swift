//
//  ReusableView.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//
import UIKit

/// Protocol for views which may be reusable.
protocol ReusableView: class {
    
    /// A string used to identify a `ReusableView` that is reusable.
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}
