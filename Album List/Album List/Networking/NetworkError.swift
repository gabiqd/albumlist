//
//  NetworkError.swift
//  Album List
//
//  Created by Gabriel on 06/12/2020.
//  Copyright © 2020 Gabriel Quispe Delgadillo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case requestError
    case nilDataResponseError
    case serverMessage(message: String)
    
    var message: String{
        switch self{
        case .decodingError:
            return "We have an error decoding the response"
        case .requestError:
            return "An error doing the request ocurred"
        case .nilDataResponseError:
            return "We have received an empty response"
        case .serverMessage(let message):
            return message
        }
    }
}
