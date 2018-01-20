//
//  ArtistSearchPresenter.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation


protocol ArtistSearchPresenterView: class {
 
}

protocol ArtistSearchPresenterDataSource: class {
    func enteredSearchString(string: String)
}

class ArtistSearchPresenter: Presenter {
    
    private weak var view: ArtistSearchPresenterView?
    
    var dataSource: ArtistSearchPresenterDataSource?

    init(view: ArtistSearchPresenterView) {
        self.view = view
    }
    
    func searchArtist(byName name: String) {
        let flow: ArtistFlowController = ServiceLocator.inject()
        flow.dismissArtistSearchViewController(target: self.view as! ArtistSearchViewController) {
            if let ds = self.dataSource {
                ds.enteredSearchString(string: name)
            }
        }
    }
    
    func closeView() {
        let flow: ArtistFlowController = ServiceLocator.inject()
        flow.dismissArtistSearchViewController(target: self.view as! ArtistSearchViewController)
    }
    
}


