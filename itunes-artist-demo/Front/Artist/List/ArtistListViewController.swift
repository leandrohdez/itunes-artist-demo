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
    
    @IBOutlet var notFoundView: UIView!
    
    
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
        
        self.searchButtonTapped()
        customizeUI()
    }
    
    private func customizeUI() {
        self.title = "iTunes Demo"
        
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
        self.notFoundView.isHidden = (items.count == 0) ? false : true
    }
    
    func performUpdateListItemData(item: ArtistListItemData, atIndex: Int) {
        self.listItems[atIndex] = item
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        cell.genreLabel.backgroundColor = UIColor(someString: item.subtitle) 
        
        cell.albumsTitleLabel.text = "Discografía:".uppercased()
        
        if item.subitems.count > 0 {
            cell.albumName1Label.isHidden = false
            cell.albumName1Label.text = "\(item.subitems[0].title)"
            
            cell.thumbnail1ImageView.isHidden = false
            cell.thumbnail1ImageView.image = UIImage(named: "default_music_icon")
            cell.thumbnail1ImageView!.loadImageFromUrl(urlString: item.subitems[0].thumbnailUrl)
        }
        else {
            cell.albumName1Label.isHidden = true
            cell.thumbnail1ImageView.isHidden = true
        }
        
        if item.subitems.count > 1 {
            cell.albumName2Label.isHidden = false
            cell.albumName2Label.text = "\(item.subitems[1].title)"
            
            cell.thumbnail2ImageView.isHidden = false
            cell.thumbnail2ImageView.image = UIImage(named: "default_music_icon")
            cell.thumbnail2ImageView!.loadImageFromUrl(urlString: item.subitems[1].thumbnailUrl)
        }
        else {
            cell.albumName2Label.isHidden = true
            cell.thumbnail2ImageView.isHidden = true
        }
        
        if item.subitems.count > 2 {
            cell.albumsCountLabel.isHidden = false
            cell.albumsCountLabel.text = "+\(item.subitems.count-2)"
        }
        else {
            cell.albumsCountLabel.isHidden = true
        }
        
        self.artistPresenter.getArtistAlbums(byIndex: indexPath.row)
        
        if indexPath.row % 2 == 0 {
            cell.styleOddRow()
        }
        else {
            cell.styleEvenRow()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.artistPresenter.artistDetail(byIndex: indexPath.row)
    }
}








