//
//  PhotoViewModel.swift
//  Album List
//
//  Created by Gabriel on 14/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import UIKit

class PhotoViewModel {
    private let photo: Photo

    init(photo: Photo) {
        self.photo = photo
    }
    
    var title: String {
        return photo.title
    }
    
    var backgroundColor: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    
    var id: Int {
        return photo.id
    }
}
