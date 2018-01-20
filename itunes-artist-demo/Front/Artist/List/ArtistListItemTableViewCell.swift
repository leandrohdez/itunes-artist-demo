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
    
    @IBOutlet var genreLabel: UILabel!
    
    @IBOutlet var albumsTitleLabel: UILabel!
    
    @IBOutlet var albumName1Label: UILabel!
    
    @IBOutlet var albumName2Label: UILabel!
    
    @IBOutlet var albumsCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
