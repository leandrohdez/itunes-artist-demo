//
//  Artist.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import SwiftyJSON


class Artist: CustomStringConvertible, Equatable {
    
    // artistId
    var id: Int
    
    // nombre del artista
    var name: String
    
    // genero principal
    var genre: String
    
    // lista de albumes
    var albums: [Album]?
    
    
    init(id: Int, name: String, genre: String) {
        self.id = id
        self.name = name
        self.genre = genre
        self.albums = nil
    }
    
    init?(json: JSON) {
        
        guard let id    = json["artistId"].int else { return nil }
        self.id = id
        
        guard let name  = json["artistName"].string else { return nil }
        self.name = name
        
        guard let genre = json["primaryGenreName"].string else { return nil }
        self.genre = genre
        
        self.albums = nil
    }
    
    var description: String {
        return "\(self.name) (\(self.genre))"
    }
    
    static func ==(lhs: Artist, rhs: Artist) -> Bool {
        return lhs.id==rhs.id
    }
}
