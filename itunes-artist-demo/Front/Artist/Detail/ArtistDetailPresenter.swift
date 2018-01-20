//
//  ArtistDetailPresenter.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 20/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation


protocol ArtistDetailPresenterView: class {
    
}

class ArtistDetailPresenter: Presenter {
    
    private weak var view: ArtistDetailPresenterView?
    
    var artist: Artist?
    
    init(view: ArtistDetailPresenterView) {
        self.view = view
    }
    
}
