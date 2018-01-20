//
//  ArtistListItemTableViewCell.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import UIKit

class ArtistListItemTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var genreLabel: UILabel! {
        didSet {
            genreLabel.layer.cornerRadius = 10
            genreLabel.layer.masksToBounds = true
        }
    }
    
    @IBOutlet var albumsTitleLabel: UILabel!
    
    @IBOutlet var thumbnail1ImageView: UIImageView!
    
    @IBOutlet var albumName1Label: UILabel!
    
    @IBOutlet var thumbnail2ImageView: UIImageView!
    
    @IBOutlet var albumName2Label: UILabel!
    
    @IBOutlet var albumsCountLabel: UILabel! {
        didSet {
            albumsCountLabel.layer.cornerRadius = 9
            albumsCountLabel.layer.masksToBounds = true
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
