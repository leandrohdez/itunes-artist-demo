//
//  ArtistSearchViewController.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import UIKit

class ArtistSearchViewController: BaseViewController {

    // MARK: IBOutlets
    @IBOutlet var nameTextField: UITextField!
    
    // MARK: Presenter
    var artistPresenter: ArtistSearchPresenter!
    override var presenter: Presenter! {
        return artistPresenter
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeUI()
    }

    private func customizeUI() {
        self.title = "Buscar artista"
        
        // cerrar
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(ArtistSearchViewController.closeButtonTapped))
        
        // borrar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Buscar", style: .plain, target: self, action: #selector(ArtistSearchViewController.searchButtonTapped))
    }

}

// MARK: - Actions
extension ArtistSearchViewController {
    @objc func closeButtonTapped() {
        self.artistPresenter.closeView()
    }
    
    @objc func searchButtonTapped() {
        let name = self.nameTextField.text!
        self.artistPresenter.searchArtist(byName: name)
    }
}

// MARK: - Presenter Methods
extension ArtistSearchViewController: ArtistSearchPresenterView {
  
}
