//
//  NetworkEndpoints.swift
//  Album List
//
//  Created by Gabriel on 13/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import Foundation

enum Endpoints {
    case albums
    case photos(albumID: String)
    
    var url: URL?{
        let host = "jsonplaceholder.typicode.com"
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        
        switch self {
        case .albums:
            components.path = "/albums"
        case .photos(albumID: let albumID):
            components.path = "/photos"
            let queryItem = URLQueryItem(name: "albumId", value: albumID)
            components.queryItems = [queryItem]
        }
        
        return components.url
    }
    
    var httpMethod: String {
        switch self {
        case .albums:
            return "GET"
        case .photos(albumID: _):
            return "GET"
        }
    }
}
