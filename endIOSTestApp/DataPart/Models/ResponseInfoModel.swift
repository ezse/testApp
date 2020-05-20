//
//  ResponseInfoModel.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit


struct ResponseInfoModel: Decodable {
    
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

