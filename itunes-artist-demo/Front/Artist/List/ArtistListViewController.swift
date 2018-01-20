//
//  ArtistListViewController.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import UIKit
import GradientLoadingBar

class ArtistListViewController: BaseViewController {
    
    // Cells
    private var cellIdentifier: String = "cellArtistFoundIdentifier"
    
    // MARK: IBOutlets
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ArtistListItemTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    // MARK: Properties
    var listItems: [ArtistListItemData] = []
    
    private let loadingIndicator = GradientLoadingBar()
    
    
    // MARK: Presenter
    var artistPresenter: ArtistListPresenter!
    override var presenter: Presenter! {
        return artistPresenter
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeUI()
    }
    
    private func customizeUI() {
        self.title = "Artistas"
        
        // boton para buscar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(ArtistListViewController.searchButtonTapped))
    }
}

// MARK: - Methods
extension ArtistListViewController {

}

// MARK: - Actions
extension ArtistListViewController {
    @objc func searchButtonTapped() {
        self.artistPresenter.searchArtist()
    }
}

// MARK: - Presenter Methods
extension ArtistListViewController: ArtistListPresenterView {
    
    func performListItemsData(items: [ArtistListItemData]) {
        self.listItems = items
        self.tableView.reloadData()
    }
    
    func updateListItemsData(items: [ArtistListItemData], atIndex: Int) {
        self.listItems = items
    }
    
    func performBeginLoading() {
        print("cargando..")
        self.loadingIndicator.show()
    }
    
    func performEndLoading() {
        print("cargado")
        self.loadingIndicator.hide()
    }
}

// MARK: - TableView Methods
extension ArtistListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.listItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ArtistListItemTableViewCell
        
        cell.nameLabel.text         = item.title
        cell.genreLabel.text        = item.subtitle
        
        if item.subitems.count > 0 {
            cell.albumsTitleLabel.text = "Discografía:"
            
            if item.subitems.count > 0 {
                cell.albumName1Label.text = "♫ \(item.subitems[0])"
            }
            
            if item.subitems.count > 1 {
                cell.albumName2Label.text = "♫ \(item.subitems[1])"
            }
            
            if item.subitems.count > 2 {
                cell.albumsCountLabel.text = "\(item.subitems.count-2) mas"
            }
        }
        
        self.artistPresenter.getArtistAlbums(byIndex: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let item = self.listItems[indexPath.row]
        return 145
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.artistPresenter.artistDetail(byIndex: indexPath.row)
    }
    
}







