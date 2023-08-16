//
//  DecodableResponseRequest.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

public protocol DecodableResponseRequest: RequestProtocol {
   associatedtype ResponseType: Decodable
}
