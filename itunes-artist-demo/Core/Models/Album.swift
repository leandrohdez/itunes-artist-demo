//
//  Album.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import SwiftyJSON


class Album: CustomStringConvertible, Equatable {
    
    var id: Int
    
    // nombre del album
    var name: String
    
    // género
    var genre: String
    
    // portada del album
    var artworkUrl: String
    
    // por poner algo mas
    var copyright: String
    
    var date: String
    
    init(id: Int, name: String, genre: String, artworkUrl: String, copyright: String, date: String) {
        self.id = id
        self.name = name
        self.genre = genre
        self.artworkUrl = artworkUrl
        self.copyright = copyright
        self.date = date
    }
    
    init?(json: JSON) {
        
        guard let id = json["collectionId"].int else { return nil }
        self.id = id
        
        guard let name  = json["collectionName"].string else { return nil }
        self.name = name
        
        guard let genre = json["primaryGenreName"].string else { return nil }
        self.genre = genre
        
        guard let artworkUrl = json["artworkUrl100"].string else { return nil }
        self.artworkUrl = artworkUrl
        
        guard let copyright = json["copyright"].string else { return nil }
        self.copyright = copyright
        
        guard let date = json["releaseDate"].string else { return nil }
        self.date = date
    }
    
    var description: String {
        return "\(self.name)"
    }
    
    static func ==(lhs: Album, rhs: Album) -> Bool {
        return lhs.id==rhs.id
    }
    
}
