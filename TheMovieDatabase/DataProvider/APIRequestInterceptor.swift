//
//  APIRequestInterceptor.swift
//  TheMovieDatabase
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

import Alamofire
import KeychainSwift

public class APIRequestInterceptor: RequestInterceptor {
    
    public static let shared = APIRequestInterceptor()
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        let accessToken = KeychainSwift().get(Keychain.token)
        
        if let accessToken = accessToken {
            urlRequest.headers.add(name: "X-TheMovieDatabase-Token", value: accessToken)
        }

        completion(.success(urlRequest))
    }
}
