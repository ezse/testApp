//
//  FilterView.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

enum FilterType: Int {
    case location = 0, episode = 1
}

class FilterView: UIView {
    
    private var tapClosure : ((FilterType) -> Void)?
    internal var filterByLocationButton: UIButton!
    internal var filterByEpisodeButton: UIButton!
    
    //initWithFrame to init view from code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    //common func to init our view
    private func setupView() {
        backgroundColor = .lightGray
        
        self.filterByLocationButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.width/2, height: self.bounds.height/2))
        self.filterByLocationButton.setTitle("Filter By Location", for: .normal)
        self.filterByLocationButton.addTarget(self, action: #selector(pressOnLocationButton), for: .touchUpInside)
        self.addSubview(self.filterByLocationButton)
        
        self.filterByEpisodeButton = UIButton.init(frame: CGRect.init(x: self.bounds.width/2, y: 0, width: self.bounds.width/2, height: self.bounds.height/2))
        self.filterByEpisodeButton.setTitle("Filter By Episode", for: .normal)
        self.filterByEpisodeButton.addTarget(self, action: #selector(pressOnEpisodeButton), for: .touchUpInside)
        self.addSubview(self.filterByEpisodeButton)
    }
    
    /// Handling closures
    public func addClosure(onTap closure: ((FilterType)->Void)?) {
        self.tapClosure = closure
    }
    
    @objc internal func pressOnLocationButton ( ) {
        if let closure = self.tapClosure {
            closure (.location)
        }
    }
    
    @objc internal func pressOnEpisodeButton ( ) {
        if let closure = self.tapClosure {
            closure (.episode)
        }
    }
}
