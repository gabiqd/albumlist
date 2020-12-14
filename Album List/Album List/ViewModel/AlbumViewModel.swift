//
//  AlbumViewModel.swift
//  Album List
//
//  Created by Gabriel on 13/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import Foundation

class AlbumViewModel {
    private let album: Album

    init(album: Album) {
        self.album = album
    }
    
    var title: String {
        return album.title
    }
    
    var id: Int {
        return album.id
    }
}



