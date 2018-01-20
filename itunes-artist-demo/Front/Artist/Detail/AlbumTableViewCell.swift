//
//  AlbumTableViewCell.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 20/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet var thumbnail: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
