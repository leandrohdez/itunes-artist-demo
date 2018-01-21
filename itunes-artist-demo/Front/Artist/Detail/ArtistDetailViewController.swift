//
//  ArtistDetailViewController.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 20/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import UIKit
import GradientLoadingBar


class ArtistDetailViewController: BaseViewController {

    // Cells
    let cellIdentifier: String = "cellArtistAlbumIdentifier"
    
    // MARK: Outlets
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "AlbumTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    // MARK: Properties
    var header: ArtistHeaderData?
    var listItems: [AlbumListItemData] = []
    
    private let loadingIndicator = GradientLoadingBar()
    
    // MARK: Presenter
    var artistPresenter: ArtistDetailPresenter!
    override var presenter: Presenter! {
        return artistPresenter
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let header = Bundle.main.loadNibNamed("ArtistDetailHeaderView", owner: self, options: nil)![0] as? ArtistDetailHeaderView {
            self.tableView.tableHeaderView = header
        }
        
        self.loadData()
        customizeUI()
    }

    private func customizeUI() {
        self.title = "Artista"
    }
    
}

// MARK: - Methods
extension ArtistDetailViewController {
    func loadData() {
        self.artistPresenter.getArtist()
        self.artistPresenter.getAlumbums()
    }
}

// MARK: Presenter Methods
extension ArtistDetailViewController: ArtistDetailPresenterView {
    
    func performHeaderData(headerData: ArtistHeaderData) {
        self.header = headerData
        if let view = self.tableView.tableHeaderView as? ArtistDetailHeaderView {
            view.titleLabel.text    = headerData.title
            view.subtitleLabel.text = headerData.subtitle
        }
    }
    
    func performListItemsData(items: [AlbumListItemData]) {
        self.listItems = items
        self.tableView.reloadData()
    }
}

// MARK: TableView Methods
extension ArtistDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = self.listItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! AlbumTableViewCell
        
        cell.titleLabel.text        = item.title
        cell.subtitleLabel.text     = item.subtitle
        cell.descriptionLabel.text  = item.detail
        cell.thumbnail.image        = UIImage(named: "default_music_icon")
        cell.thumbnail!.loadImageFromUrl(urlString: item.thumbnailUrl)
        
        if indexPath.row % 2 == 0 {
            cell.styleOddRow()
        }
        else {
            cell.styleEvenRow()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Discografía:"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}






