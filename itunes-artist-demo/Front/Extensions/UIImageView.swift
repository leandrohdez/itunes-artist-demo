//
//  UIImageView.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 20/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

extension UIImageView {
    
    public func loadImageFromUrl(urlString: String) {
        Alamofire.request(urlString).responseImage { response in
            if let image = response.result.value {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
}
