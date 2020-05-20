//
//  EpisodeModel.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 20.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

struct EpisodeModel: Decodable {
    
    let id: Int
    let name: String?
    let air_date: String?
    let episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
}


struct RootEpisodeResponseInfoModel: Decodable {
    
    let results: [EpisodeModel]?
    let info: ResponseInfoModel?
}
