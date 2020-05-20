//
//  endIOSTestAppTests.swift
//  endIOSTestAppTests
//
//  Created by Egor Zemlyanskiy on 19.05.20.
//  Copyright © 2020 ez. All rights reserved.
//

import XCTest

@testable import endIOSTestApp


/// simple mapping/relations checking
class endIOSTestAppTests: XCTestCase {

    var character: CharacterModel!
    
    override func setUp() {
        super.setUp()
        
        character = CharacterModel(id: 100, name: nil, status: nil, species: "sdfs", type: "type", gender: nil, origin: CharacterShortLocationModel.init(name: nil, url: nil), location: CharacterShortLocationModel.init(name: "TestLocation", url: nil), image: nil, episode: [], url: "", created: nil, isFavorite: false)
    }
    
    func testCharacterModel() {
    
        character.isFavorite = true
        XCTAssertEqual(character.isFavorite, true, "Something is wrong")
    }
    
    func testCharacterWithRootObjectMapping() {
        
        let characterWitRootDictionary: [String: Any] = ["info":["count": 1, "pages": 212, "next": "next page", "prev": "prev page"], "results":[["id": 10, "name": "John", "status": "status", "species": "some species","type" : "user type", "gender" : "Female", "origin" : ["name": "origin Name", "url": "someURL"], "location": ["name": "location Name", "url": "someURL"], "image": "user image", "episode" : ["episode 1"], "url" : "some url", "created": "date created", "isFavorite" : false]]]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: characterWitRootDictionary,
            options: []) {
            
            let mappedObject = try! JSONDecoder().decode(RootCharacterResponseInfoModel.self, from: theJSONData)
                      
            XCTAssertEqual(mappedObject.info?.pages, 212)
            XCTAssertEqual(mappedObject.info?.count, 1)
            XCTAssertEqual(mappedObject.results?[0].name, "John")
            XCTAssertEqual(mappedObject.results?[0].url, "some url")
        }
    }
    
    func testEpisodeMapping() {
        
        let episodeDictionary: [String: Any] = ["id": 1090, "name": "episode 1", "air_date": "air date", "episode": "some episode", "characters" : ["character 1"], "url" : "some url", "created": "date created", "new_key": "some addititonal key"]
        
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: episodeDictionary,
            options: []) {
            
            let mappedObject = try! JSONDecoder().decode(EpisodeModel.self, from: theJSONData)
                      
            XCTAssertEqual(mappedObject.id, 1090)
            XCTAssertEqual(mappedObject.name, "episode 1")
            XCTAssertEqual(mappedObject.url, "some url")
        }
    }

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

/// testing DataLoaders
class endIOSTestAppTestsProtocols: XCTestCase, CharactersLoaderProtocol, EpisodeLoaderProtocol, LocationLoaderProtocol {
    
    var episodes: [String] = ["https://rickandmortyapi.com/api/episode/1", "https://rickandmortyapi.com/api/episode/2", "https://rickandmortyapi.com/api/episode/3", "https://rickandmortyapi.com/api/episode/4", "https://rickandmortyapi.com/api/episode/5"]
   
    var character1: CharacterModel!
    var character2: CharacterModel!
    var character3: CharacterModel!
    
    override func setUp() {
        super.setUp()
        
        character1 = CharacterModel.init(id: 1, name: "character1", status: "", species: "", type: "", gender:nil, origin: nil, location: CharacterShortLocationModel.init(name: "location", url: "sdf"), image: "", episode: [self.episodes[0], self.episodes[1]], url: "", created: "", isFavorite: false)
        character2 = CharacterModel.init(id: 2, name: "character2", status: "", species: "", type: "", gender: nil, origin: nil, location: CharacterShortLocationModel.init(name: "location1", url: "sdf"), image: "", episode: [self.episodes[2], self.episodes[1]], url: "", created: "", isFavorite: false)
        character3 = CharacterModel.init(id: 3, name: "character3", status: "", species: "", type: "", gender: nil, origin: nil, location: CharacterShortLocationModel.init(name: "location2", url: "sdf"), image: "", episode: [self.episodes[4], self.episodes[3], self.episodes[1]], url: "", created: "", isFavorite: false)
    }
    
    func testGettingEpisodesFromCharacters() {
        
        self.getListOfEpisodesFromListOfCharacters(characters: [character1, character2, character3]) { (results) in
            
            XCTAssertEqual(results, ["1", "2", "3", "4", "5"], "Something is wrong")
        }
    }
    
    func testGettingLocationsFromCharacters() {
        
        self.getListOfLocationFromListOfCharacters(characters: [character1, character2, character3, character1, character3]) { (results) in
            XCTAssertEqual(results, ["location", "location1", "location2"], "Something is wrong")
        }
    }
    
    func testFilteringCharactersByLocation() {
        
        self.filterCharactersByLocation(characters: [character1, character2, character3], locationName: "location1") { (results) in
            
            XCTAssertEqual(results?.count, 1, "Something is wrong")
            XCTAssertEqual(results?[0].name, self.character2.name, "Something is wrong")
        }
    }
    
    func testFilteringCharactersByEpisode () {
        
        self.filterCharactersByEpisode(characters: [character1, character2, character3, character3, character2], episodeUrl: self.episodes[0]) { (results) in
            
             XCTAssertEqual(results?.count, 1, "Something is wrong")
             XCTAssertEqual(results?[0].name, self.character1.name, "Something is wrong")
        }
    }

}
