//
//  Album.swift
//  Album List
//
//  Created by Gabriel on 13/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let userId: Int
    let id: Int
    let title: String
}
