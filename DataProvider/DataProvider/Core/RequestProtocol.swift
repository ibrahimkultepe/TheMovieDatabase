//
//  RequestProtocol.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 15.08.2023.
//

public protocol RequestProtocol {
   var path: String { get }
   var method: RequestMethod { get }
   var parameters: RequestParameters { get }
   var headers: RequestHeaders { get }
   var encoding: RequestEncoding { get }
   var url: String { get }
}
