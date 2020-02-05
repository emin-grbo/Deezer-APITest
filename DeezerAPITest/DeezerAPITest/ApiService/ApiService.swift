//
//  ApiService.swift
//  DeezerAPITest
//
//  Created by Emin Roblack on 04/02/2020.
//  Copyright © 2020 Emin Roblack. All rights reserved.
//

import Foundation

public enum APIResult<T> {
    case success(T?)
    case failure(APIError)
}

public enum APIError : Error, CustomStringConvertible {
    case InvalidURL
    // Can't connect to the server (maybe offline?)
    case ConnectionError(error: Error)
    // The server responded with a non 200 status code
    case ServerError(statusCode: Int, error: Error)
    // We got no data (0 bytes) back from the server
    case NoDataError
    // The server responded with a non 200 status internal code
    case ServerInternalError(statusCode: Int, message: String?, errors: Any?)
    // Custom Error
    case CustomError(message: String)
    // Unauthorized access - user not verified
    case NotVerified

    public var description: String {
        switch self {
        case .InvalidURL:
            return "Invalid URL"
        case .ConnectionError(let error):
            return "Can't connect to the server (maybe offline?) ❓ Error: \(error.localizedDescription)"
        case .ServerError(let statusCode, let error):
            return "The server responded with a non 200 status code ❓ StatusCode: \(statusCode) ❓ Error: \(error.localizedDescription)"
        case .NoDataError:
            return "We got no data (0 bytes) back from the server"
        case .ServerInternalError(let statusCode, let message, let errors):
            return "The server responded with a non 200 status code ❓ StatusCode: \(statusCode) ❓ Message: \(message ?? "") ❓ ServerError: \(String(describing: errors))"
        case .CustomError(let message):
            return message
        case .NotVerified:
            return "User not verified"
        }
    }
}

struct ApiService {

    static let apiBaseUrl: String = "https://api.deezer.com/"

    enum ApiCall: String {
        case search                       = "search/artist?q="
        case artistAlbums                 = "artist/%@/albums/"
        case album                        = "album/%@"
        case tracks                       = "album/%@/tracks"

        
        var urlString: String {
            return ApiService.apiBaseUrl + self.rawValue
        }
    }
}
