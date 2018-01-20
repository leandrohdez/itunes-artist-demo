//
//  ArtistDetailViewController.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 20/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import UIKit

class ArtistDetailViewController: BaseViewController {

    // MARK: Outlets
    
    // MARK: Properties
    
    // MARK: Presenter
    var artistPresenter: ArtistDetailPresenter!
    override var presenter: Presenter! {
        return artistPresenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customizeUI()
    }


    private func customizeUI() {
        self.title = "Artista detalle"
    }
}


// MARK: Presenter Methods
extension ArtistDetailViewController: ArtistDetailPresenterView {
    
}
