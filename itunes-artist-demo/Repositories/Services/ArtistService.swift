//
//  ArtistService.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ArtistService {
    
    static func fetchArtists(byName: String, success: @escaping (_ artists: [Artist]) -> (), fail: @escaping (_ error: NSError) -> ()) {
        
        let urlEndpoint = "\(ApiConfig.baseUrl)/search"
        
        let parameters = ["term": "\(byName)", "media": "music", "entity": "musicArtist"]
        
        var headers = HTTPHeaders()
        headers["Content-Type"]     = ApiConfig.content
        headers["Accept"]           = ApiConfig.accept
        
        Alamofire.request(urlEndpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            if let _ = response.response {
                var resultArtists: [Artist] = []
                
                if let jsonData = response.result.value {
                    let json = JSON(jsonData)
                    
                    let array = json["results"].arrayValue
                    array.forEach { item in
                        
                        if let wrapper = item["wrapperType"].string, wrapper == "artist" {
                            if let artist = Artist(json: item) {
                                resultArtists.append(artist)
                            }
                        }
                    }
                }
                success(resultArtists)
            }
            else {
                fail(NSError(domain: "Request Error", code: 500, userInfo: nil))
            }
        }

    }
}
