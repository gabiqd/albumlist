//
//  PhotoListViewModel.swift
//  Album List
//
//  Created by Gabriel on 14/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import Foundation

class PhotoListViewModel: NSObject {
    private var albumId: String
    let networkService: PhotoService
    private(set) var photosViewModels: [PhotoViewModel] = []
    var onPhotoListUpdated: ((PhotoListViewModel) -> Void)? = nil

    init(with albumId: Int, networkService: PhotoService) {
        self.networkService = networkService
        self.albumId = String(albumId)
        super.init()
        
        self.update()
    }
    
    func update() {
        networkService.fetchPhotos(with: albumId) { [weak self] (result) in
            guard let sself = self else { return }

            switch result {
            case .success(let response):
                let photosViewModels = response.map { PhotoViewModel(photo: $0) }
                sself.photosViewModels = photosViewModels
                sself.onPhotoListUpdated?(sself)
            case .failure(let error):
                print(error.message)
            }
        }
    }
}

