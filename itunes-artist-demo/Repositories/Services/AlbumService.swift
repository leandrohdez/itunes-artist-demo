//
//  AlbumService.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AlbumService {
    
    static func fetchAlbums(byArtistId: Int, success: @escaping (_ artists: [Album]) -> (), fail: @escaping (_ error: NSError) -> ()) {
        
        let urlEndpoint = "\(ApiConfig.baseUrl)/lookup"
        
        let parameters = ["id": byArtistId, "entity": "album"] as [String : Any]
        
        var headers = HTTPHeaders()
        headers["Content-Type"]     = ApiConfig.content
        headers["Accept"]           = ApiConfig.accept
        
        Alamofire.request(urlEndpoint, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            if let _ = response.response {
                var resultAlbums: [Album] = []
                
                if let jsonData = response.result.value {
                    let json = JSON(jsonData)
                    
                    let array = json["results"].arrayValue
                    array.forEach { item in
                        if let wrapper = item["wrapperType"].string, wrapper == "collection", let type = item["collectionType"].string, type == "Album" {
                            
                            if let album = Album(json: item) {
                                resultAlbums.append(album)
                            }
                        }
                    }
                }
                success(resultAlbums)
            }
            else {
                fail(NSError(domain: "Request Error", code: 500, userInfo: nil))
            }
        }
        
    }
}
