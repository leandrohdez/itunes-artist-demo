//
//  ArtistFlowController.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation
import UIKit

class ArtistFlowController {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private var navigationController: UINavigationController? {
        return window.rootViewController as? UINavigationController
    }
    
    func showArtistListViewController() {
        let rootViewController: ArtistListViewController = ServiceLocator.inject()
        window.rootViewController = UINavigationController(rootViewController: rootViewController)
        window.makeKeyAndVisible()
    }
    
    func presentArtistSearchViewController(dataSource: ArtistSearchPresenterDataSource? = nil) {
        let viewController: ArtistSearchViewController = ServiceLocator.inject()
        let navController = UINavigationController(rootViewController: viewController)
        navController.modalTransitionStyle = .crossDissolve
        navigationController?.present(navController, animated: true, completion: nil)
        
        if let ds = dataSource {
            viewController.artistPresenter.dataSource = ds
        }
    }
    
    func dismissArtistSearchViewController(target: ArtistSearchViewController, completion: (() -> Void)? = nil) {
        target.dismiss(animated: true, completion: completion)
    }
    
    
    func pushArtistDetailViewController(artist: Artist) {
        let viewController: ArtistDetailViewController = ServiceLocator.inject()
        viewController.artistPresenter.artist = artist
        navigationController?.performClearBackTitle()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
