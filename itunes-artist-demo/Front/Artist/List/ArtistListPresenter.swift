//
//  ArtistListPresenter.swift
//  itunes-artist-demo
//
//  Created by Leandro Hernandez on 19/1/18.
//  Copyright © 2018 antrax. All rights reserved.
//

import Foundation

protocol ArtistListPresenterView: class {
    func performListItemsData(items: [ArtistListItemData])
    func performUpdateListItemData(item: ArtistListItemData, atIndex: Int)
    func performBeginLoading()
    func performEndLoading()
}

class ArtistListPresenter: Presenter {
    
    private weak var view: ArtistListPresenterView?
    
    var searchName: String = ""
    
    var artists: [Artist] = []
    
    init(view: ArtistListPresenterView) {
        self.view = view
    }
    
    func searchArtist() {
        let flow: ArtistFlowController = ServiceLocator.inject()
        flow.presentArtistSearchViewController(dataSource: self)
    }
    
    func getArtistAlbums(byIndex index: Int) {
        if self.artists.count > index {
            let artist = self.artists[index]
            
            // llamar al servicio si no ha cargado los albumes
            if artist.albums == nil {
                self.serviceGetAlbums(ofArtist: artist, atIndex: index)
            }
        }
    }
    
    func artistDetail(byIndex index: Int) {
        if self.artists.count > index {
            let artist = self.artists[index]
            
            let flow: ArtistFlowController = ServiceLocator.inject()
            flow.pushArtistDetailViewController(artist: artist)
        }
    }
}

// MARK: Calling Service
extension ArtistListPresenter {
    
    func serviceGetArtists(byName name: String) {
        
        guard let view = self.view else { return }
        
        view.performBeginLoading()
        
        ArtistService.fetchArtists(byName: name, success: { (artists) in
            
            self.artists = artists
            var result: [ArtistListItemData] = []
            self.artists.forEach { artist in
                result.append(
                    ArtistListItemData(title: artist.name, subtitle: artist.genre, subitems: [])
                )
            }
            
            view.performListItemsData(items: result)
            view.performEndLoading()
            
        }) { (error) in
            view.performEndLoading()
            print("*** Error: \(error)")
        }
    }
    
    func serviceGetAlbums(ofArtist artist: Artist, atIndex index: Int) {
        
        guard let view = self.view else { return }
        
        AlbumService.fetchAlbums(byArtistId: artist.id, success: { (albums) in
            
            self.artists[index].albums = albums
            
            var subitems: [AlbumSubitemData] = []
            albums.forEach { album in
                subitems.append( AlbumSubitemData(title: album.name, thumbnailUrl: album.artworkUrl) )
            }
           
            let result = ArtistListItemData(title: self.artists[index].name, subtitle: self.artists[index].genre, subitems: subitems)
            view.performUpdateListItemData(item: result, atIndex: index)
            
        }) { (error) in
            print("*** Error: \(error)")
        }
    }
}

// MARK: - ArtistSearchPresenterDataSource
extension ArtistListPresenter: ArtistSearchPresenterDataSource {
    func enteredSearchString(string: String) {
        self.searchName = string
        self.serviceGetArtists(byName: string)
    }
    
}
