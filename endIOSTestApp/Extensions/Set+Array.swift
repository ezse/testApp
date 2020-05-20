//
//  Set+Extensions.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

/// Simple Set's extension to convert to an array
extension Set {
    var array: [Element] {
        return Array(self)
    }
}
