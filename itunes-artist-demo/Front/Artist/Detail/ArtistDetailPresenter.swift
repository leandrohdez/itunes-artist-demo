//
//  ArtistDetailPresenter.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 20/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation


protocol ArtistDetailPresenterView: class {
   func performListItemsData(items: [AlbumListItemData])
}

class ArtistDetailPresenter: Presenter {
    
    private weak var view: ArtistDetailPresenterView?
    
    var artist: Artist?
    
    init(view: ArtistDetailPresenterView) {
        self.view = view
    }
    
    func getAlumbums() {
        guard let view = self.view else { return }
        
        if let artist = self.artist {
            var resultListAlbums: [AlbumListItemData] = []
            
            artist.albums.forEach { album in
                resultListAlbums.append(
                    AlbumListItemData(title: album.name, subtitle: album.date, detail: album.copyright, thumbnailUrl: album.artworkUrl)
                )
            }
            
            view.performListItemsData(items: resultListAlbums)
        }
    }
    
}
