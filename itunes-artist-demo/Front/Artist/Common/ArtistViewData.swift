//
//  ArtistViewData.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation

struct AlbumSubitemData {
    var title: String
    var thumbnailUrl: String
}

struct ArtistListItemData {
    var title: String
    var subtitle: String
    var subitems: [AlbumSubitemData]
}

struct ArtistHeaderData {
    var title: String
    var subtitle: String
}

struct AlbumListItemData {
    var title: String
    var subtitle: String
    var detail: String
    var thumbnailUrl: String
}
