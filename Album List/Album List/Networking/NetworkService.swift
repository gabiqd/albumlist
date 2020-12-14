//
//  NetworkService.swift
//  Album List
//
//  Created by Gabriel on 12/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import Foundation

protocol AlbumService {
    func fetchAlbums(completition: @escaping (Result<[Album], NetworkError>) -> Void)
}

protocol PhotoService {
    func fetchPhotos(with albumID: String, completition: @escaping (Result<[Photo], NetworkError>) -> Void)
}

class NetworkService: NSObject {
    fileprivate static func processResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<[T], NetworkError> {
        guard error == nil else {
            return .failure(.requestError)
        }
        
        guard let data = data else {
            return .failure(.nilDataResponseError)
        }

        let response = NetworkResponse(data: data)
        guard let decodedResponse = response.decode([T].self) else {
            return .failure(.decodingError)
        }
        
        return .success(decodedResponse)
    }
    
    fileprivate func requestFor(endpoint: Endpoints) -> URLRequest {
        guard let url = endpoint.url else { fatalError() }
        let httpMethod = endpoint.httpMethod
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod

        return request
    }
    
    func submit<T: Decodable>(request: URLRequest, completition: @escaping (Result<[T], NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let result = NetworkService.processResponse(data: data, response: response, error: error) as Result<[T], NetworkError>
            completition(result)
        }
        task.resume()
    }
    
}

extension NetworkService: AlbumService {
    func fetchAlbums(completition: @escaping (Result<[Album], NetworkError>) -> Void) {
        let request = requestFor(endpoint: Endpoints.albums)
        submit(request: request, completition: completition)
    }
}

extension NetworkService: PhotoService {
    func fetchPhotos(with albumID: String, completition: @escaping (Result<[Photo], NetworkError>) -> Void) {
        let request = requestFor(endpoint: Endpoints.photos(albumID: albumID))
        submit(request: request, completition: completition)
    }
}
