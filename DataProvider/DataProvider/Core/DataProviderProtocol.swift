//
//  DataProviderProtocol.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

public typealias DataProviderResult<T: Decodable> = ((Result<T, Error>) -> Void)

public protocol DataProviderProtocol {
    
    func request<T: DecodableResponseRequest>(for request: T,
                                              result: DataProviderResult<T.ResponseType>?)
}
