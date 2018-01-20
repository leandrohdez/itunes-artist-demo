//
//  ArtistServiceLocator.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation


class ArtistServiceLocator: ServiceLocatorModule {
    
    func registerServices(serviceLocator: ServiceLocator) {
        
        serviceLocator.register { self.provideArtistFlowController() }
        serviceLocator.register { self.provideArtistListViewController() }
        serviceLocator.register { self.provideArtistSearchViewController() }
        serviceLocator.register { self.provideArtistDetailViewControler() }
    }
    
    private func provideArtistFlowController() -> ArtistFlowController {
        return ArtistFlowController(window: ServiceLocator.inject())
    }
    
    private func provideArtistListViewController() -> ArtistListViewController {
        
        let viewController = ArtistListViewController(nibName: "ArtistListViewController", bundle: Bundle.main)
        viewController.artistPresenter = ArtistListPresenter(view: viewController)
        
        return viewController
    }
    
    private func provideArtistSearchViewController() -> ArtistSearchViewController {
        
        let viewController = ArtistSearchViewController(nibName: "ArtistSearchViewController", bundle: Bundle.main)
        viewController.artistPresenter = ArtistSearchPresenter(view: viewController)
        
        return viewController
    }
    
    private func provideArtistDetailViewControler() -> ArtistDetailViewController {

        let viewController = ArtistDetailViewController(nibName: "ArtistDetailViewController", bundle: Bundle.main)
        viewController.artistPresenter = ArtistDetailPresenter(view: viewController)

        return viewController
    }
}
