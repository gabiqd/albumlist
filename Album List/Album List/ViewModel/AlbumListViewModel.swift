//
//  AlbumListViewModel.swift
//  Album List
//
//  Created by Gabriel on 14/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import UIKit

class AlbumListViewModel: NSObject {
    let networkService: AlbumService
    private(set) var albumsViewModels: [AlbumViewModel] = []
    var onAlbumsListUpdated: ((AlbumListViewModel) -> Void)? = nil

    init(networkService: AlbumService) {
        self.networkService = networkService
        super.init()
        
        self.fetch()
    }
    
    func fetch() {
        networkService.fetchAlbums { [weak self] (result) in
            guard let sself = self else { return }

            switch result {
            case .success(let response):
                let albumsViewModels = response.map { AlbumViewModel(album: $0) }
                sself.albumsViewModels = albumsViewModels
                sself.onAlbumsListUpdated?(sself)
            case .failure(let error):
                print(error.message)
            }
        }
    }
}
