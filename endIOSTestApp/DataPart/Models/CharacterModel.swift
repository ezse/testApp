//
//  Character.swift
//  endIOSTestApp
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import UIKit

struct CharacterModel: Decodable {

    enum Gender: String, Decodable {
        case male = "Male", female = "Female", unknown = "unknown", genderless = "Genderless"
    }
    
    let id: Int
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: Gender?
    let origin: CharacterShortLocationModel?
    let location: CharacterShortLocationModel?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    var isFavorite: Bool?
}


struct RootCharacterResponseInfoModel: Decodable {
    
    let results: [CharacterModel]?
    let info: ResponseInfoModel?
}
